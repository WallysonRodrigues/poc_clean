part of 'catalog_bloc.dart';

abstract class CatalogBlocState {}

class InitialState extends CatalogBlocState {}

class LoadingState extends CatalogBlocState {}

class LoadedState extends CatalogBlocState {
  final List<Product> products;

  LoadedState(this.products);
}

class FailureState extends CatalogBlocState {
  final String errorMessage;

  FailureState(this.errorMessage);
}
