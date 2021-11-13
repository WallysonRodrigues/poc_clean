import 'package:flutter/material.dart';

import '../../../domain/entities/product.dart';
import '../views/product_detail_view.dart';
import 'add_to_card_button.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        ProductDetailView.name,
        arguments: product.uuid,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.network(
            product.image,
            height: MediaQuery.of(context).size.height * 0.4,
            fit: BoxFit.fitHeight,
          ),
          const SizedBox(
            height: 20.0,
          ),
          Text(
            product.name,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 10.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'R\$ ${product.value}',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              AddToCardButton(
                product: product,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
