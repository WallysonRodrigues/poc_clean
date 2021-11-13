part of 'cart_bloc.dart';

abstract class CartState {}

class CartEmptyState extends CartState {}

class ProductAddedState extends CartState {}

class LoadedState extends CartState {
  final Cart cart;

  LoadedState(this.cart);
}
