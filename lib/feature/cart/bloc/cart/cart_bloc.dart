import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/entities/cart.dart';

import '../../../../domain/entities/product.dart';
import '../../../../domain/repositories/cart_repository.dart';
import '../../../../domain/usecases/add_product_to_cart.dart';
import '../../../../domain/usecases/get_cart.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepositoryInterface repository;

  CartBloc(this.repository) : super(CartEmptyState()) {
    on<LoadCartStatusEvent>(_loadStatus);
    on<LoadCartProductsEvent>(_load);
    on<AddProductToCartEvent>(_add);
  }

  void _loadStatus(CartEvent event, Emitter<CartState> emit) async {
    final getCart = GetCart(repository);
    final cart = await getCart().first;

    cart.products.isEmpty ? emit(CartEmptyState()) : emit(LoadedState(cart));
  }

  void _load(CartEvent event, Emitter<CartState> emit) async {
    final getCart = GetCart(repository);
    final cart = await getCart().first;

    cart.products.isEmpty ? emit(CartEmptyState()) : emit(LoadedState(cart));
  }

  void _add(CartEvent event, Emitter<CartState> emit) async {
    final addProduct = AddProductToCart(repository);
    final cart = await addProduct((event as AddProductToCartEvent).product).first;

    emit(ProductAddedState());
    emit(LoadedState(cart));
  }
}
