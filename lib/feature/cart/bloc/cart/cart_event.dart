part of 'cart_bloc.dart';

abstract class CartEvent {}

class LoadCartStatusEvent extends CartEvent {}

class LoadCartProductsEvent extends CartEvent {}

class AddProductToCartEvent extends CartEvent {
  final Product product;

  AddProductToCartEvent(this.product);
}
