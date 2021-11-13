import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cart/widgets/cart_counter.dart';
import '../widgets/add_to_card_button.dart';
import '../../../domain/repositories/catalog_repository.dart';
import '../../../domain/entities/product.dart';
import '../bloc/product_detail/product_detail_bloc.dart';
import '../../../components/app_scaffold.dart';
import '../repositories/catalog_repository.dart';

class ProductDetailView extends StatelessWidget {
  static const name = 'product-detail-view';

  final CatalogRepositoryInterface repository;

  const ProductDetailView(this.repository, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final uuid = ModalRoute.of(context)!.settings.arguments as String;

    return BlocProvider(
      create: (_) => ProductDetailBloc(CatalogRepository())..add(DetailProductEvent(uuid)),
      child: const _ProductDetailPage(),
    );
  }
}

class _ProductDetailPage extends StatelessWidget {
  const _ProductDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      actions: const [
        CartCounter(),
      ],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: BlocBuilder<ProductDetailBloc, ProductDetailState>(
          builder: (context, state) {
            if (state is LoadingState) {
              return _stateLoading();
            }

            if (state is LoadedState) {
              return _stateLoaded(context, state.product);
            }

            if (state is FailureState) {
              return _stateFailure(state.errorMessage);
            }

            return Container();
          },
        ),
      ),
    );
  }

  Widget _stateLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _stateLoaded(BuildContext context, Product product) {
    return Column(
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
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Text(
          product.description,
          style: const TextStyle(
            fontSize: 16.0,
          ),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'R\$ ${product.value}',
              style: const TextStyle(
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            AddToCardButton(
              product: product,
            ),
          ],
        ),
      ],
    );
  }

  Widget _stateFailure(String error) {
    return Center(
      child: Text(error),
    );
  }
}
