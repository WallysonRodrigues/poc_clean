part of 'product_detail_bloc.dart';

abstract class ProductDetailState {}

class InitialState extends ProductDetailState {}

class LoadingState extends ProductDetailState {}

class LoadedState extends ProductDetailState {
  final Product product;

  LoadedState(this.product);
}

class FailureState extends ProductDetailState {
  final String errorMessage;

  FailureState(this.errorMessage);
}
