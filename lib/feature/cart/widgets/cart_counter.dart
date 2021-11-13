import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../views/checkout_view.dart';
import '../bloc/cart/cart_bloc.dart';

class CartCounter extends StatelessWidget {
  const CartCounter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5.0),
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state is LoadedState) {
            return _stateCartNotEmpty(
              context,
              count: state.cart.products.length,
            );
          }

          return _stateCartEmpty();
        },
      ),
    );
  }

  Widget _stateCartNotEmpty(BuildContext context, {required int count}) {
    return IconButton(
      onPressed: () => Navigator.pushNamed(context, CheckOutView.name),
      icon: Badge(
        animationType: BadgeAnimationType.slide,
        badgeColor: Colors.white,
        badgeContent: Text(count.toString()),
        child: const Icon(Icons.shopping_cart),
      ),
    );
  }

  Widget _stateCartEmpty() {
    return const IconButton(
      onPressed: null,
      icon: Icon(Icons.shopping_cart),
      disabledColor: Colors.white,
    );
  }
}
