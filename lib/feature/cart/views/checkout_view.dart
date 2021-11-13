import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../components/app_scaffold.dart';
import '../bloc/cart/cart_bloc.dart';

class CheckOutView extends StatelessWidget {
  static const name = 'products-sold-view';

  const CheckOutView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(LoadCartProductsEvent());

    return AppScaffold(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is LoadedState) {
              return ListView.separated(
                itemCount: state.cart.products.length,
                itemBuilder: (context, index) {
                  var product = state.cart.products[index];

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(product.name),
                              Text(product.value),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
