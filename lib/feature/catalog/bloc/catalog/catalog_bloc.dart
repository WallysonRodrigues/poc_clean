import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../../../domain/entities/product.dart';
import '../../../../domain/repositories/catalog_repository.dart';
import '../../../../domain/usecases/get_products.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogBlocEvent, CatalogBlocState> {
  final CatalogRepositoryInterface repository;

  EventTransformer<SearchEvent> debouce(Duration duration) {
    return (events, mapper) => events.debounce(duration).switchMap(mapper);
  }

  CatalogBloc(this.repository) : super(LoadingState()) {
    on<LoadEvent>(_load);
    on<SearchEvent>(
      _search,
      transformer: debouce(const Duration(seconds: 1)),
    );
  }

  FutureOr<void> _load(CatalogBlocEvent event, Emitter<CatalogBlocState> emit) async {
    emit(LoadingState());

    try {
      final getProducts = GetProducts(repository);
      final products = await getProducts().where((list) => list.isNotEmpty).first;

      emit(LoadedState(products));
    } catch (e) {
      emit(FailureState('Nenhum registro encontrado'));
    }
  }

  FutureOr<void> _search(CatalogBlocEvent event, Emitter<CatalogBlocState> emit) async {
    emit(LoadingState());

    try {
      final getProducts = GetProducts(repository);
      final products = await getProducts(search: (event as SearchEvent).search).where((list) => list.isNotEmpty).first;

      emit(LoadedState(products));
    } catch (e) {
      emit(FailureState('Nenhum registro encontrado'));
    }
  }
}
