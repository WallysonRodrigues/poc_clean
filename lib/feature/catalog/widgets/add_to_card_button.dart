import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../domain/entities/product.dart';
import '../../cart/bloc/cart/cart_bloc.dart';

class AddToCardButton extends StatelessWidget {
  final Product product;

  const AddToCardButton({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text('Adicionar ao carrinho'),
      onPressed: () => context.read<CartBloc>().add(AddProductToCartEvent(product)),
    );
  }
}
