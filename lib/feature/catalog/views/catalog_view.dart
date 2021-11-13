import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cart/widgets/cart_counter.dart';
import '../../../domain/repositories/catalog_repository.dart';
import '../../../domain/entities/product.dart';
import '../bloc/catalog/catalog_bloc.dart';
import '../repositories/catalog_repository.dart';
import '../widgets/product_card.dart';

import '../../../components/app_scaffold.dart';

class CatalogView extends StatelessWidget {
  static const name = 'catalog-view';
  final CatalogRepositoryInterface repository;

  const CatalogView(this.repository, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CatalogBloc(CatalogRepository())..add(LoadEvent()),
      child: _CatalogPage(),
    );
  }
}

class _CatalogPage extends StatelessWidget {
  final TextEditingController _searchController = TextEditingController();

  _CatalogPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: TextField(
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
        ),
        controller: _searchController,
        onChanged: (value) => context.read<CatalogBloc>().add(SearchEvent(search: _searchController.text)),
      ),
      actions: const [
        CartCounter(),
      ],
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Divider(),
            Expanded(
              child: BlocBuilder<CatalogBloc, CatalogBlocState>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return _stateLoading();
                  }

                  if (state is LoadedState) {
                    return _stateLoaded(state.products);
                  }

                  if (state is FailureState) {
                    return _stateFailure(state.errorMessage);
                  }

                  return Container();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _stateLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _stateLoaded(List<Product> products) {
    return ListView.separated(
      itemCount: products.length,
      itemBuilder: (_, index) => ProductCard(product: products[index]),
      separatorBuilder: (_, index) => const Divider(),
    );
  }

  Widget _stateFailure(String error) {
    return Center(
      child: Text(error),
    );
  }
}
