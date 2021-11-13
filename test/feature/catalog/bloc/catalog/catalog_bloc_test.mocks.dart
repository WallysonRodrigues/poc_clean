// Mocks generated by Mockito 5.0.16 from annotations
// in poc_clean/test/feature/catalog/bloc/catalog/catalog_bloc_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:poc_clean/domain/entities/product.dart' as _i4;
import 'package:poc_clean/feature/catalog/repositories/catalog_repository.dart' as _i2;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

/// A class which mocks [CatalogRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockCatalogRepository extends _i1.Mock implements _i2.CatalogRepository {
  MockCatalogRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Stream<List<_i4.Product>> getProducts(String? search) =>
      (super.noSuchMethod(Invocation.method(#getProducts, [search]), returnValue: Stream<List<_i4.Product>>.empty()) as _i3.Stream<List<_i4.Product>>);
  @override
  _i3.Stream<_i4.Product> getProduct(String? uuid) => (super.noSuchMethod(Invocation.method(#getProduct, [uuid]), returnValue: Stream<_i4.Product>.empty()) as _i3.Stream<_i4.Product>);
}
