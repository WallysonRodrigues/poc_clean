import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'domain/repositories/cart_repository.dart';
import 'feature/cart/bloc/cart/cart_bloc.dart';
import 'feature/cart/repositories/cart_repository.dart';
import 'feature/cart/views/checkout_view.dart';
import 'feature/catalog/repositories/catalog_repository.dart';
import 'feature/catalog/views/catalog_view.dart';
import 'feature/catalog/views/product_detail_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    GetIt getIt = GetIt.instance;

    getIt.registerLazySingleton<CartRepositoryInterface>(() => CartRepository());

    return BlocProvider(
      create: (context) => CartBloc(GetIt.I.get<CartRepositoryInterface>())..add(LoadCartStatusEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: CatalogView.name,
        routes: {
          CatalogView.name: (_) => CatalogView(CatalogRepository()),
          ProductDetailView.name: (_) => ProductDetailView(CatalogRepository()),
          CheckOutView.name: (_) => const CheckOutView(),
        },
      ),
    );
  }
}
