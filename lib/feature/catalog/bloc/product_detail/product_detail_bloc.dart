import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/entities/product.dart';
import '../../../../domain/repositories/catalog_repository.dart';
import '../../../../domain/usecases/get_product.dart';

part 'product_detail_event.dart';
part 'product_detail_state.dart';

class ProductDetailBloc extends Bloc<ProductDetailEvent, ProductDetailState> {
  final CatalogRepositoryInterface repository;

  ProductDetailBloc(this.repository) : super(InitialState()) {
    on<DetailProductEvent>(_detail);
  }

  FutureOr<void> _detail(ProductDetailEvent event, Emitter<ProductDetailState> emit) async {
    emit(LoadingState());

    try {
      final getProduct = GetProduct(repository);
      final product = await getProduct((event as DetailProductEvent).uuid).first;

      emit(LoadedState(product));
    } catch (e) {
      emit(FailureState('Falha ao carregar dados do produto'));
    }
  }
}
