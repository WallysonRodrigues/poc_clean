import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poc_clean/domain/entities/product.dart';

import 'package:poc_clean/feature/catalog/bloc/catalog/catalog_bloc.dart';
import 'package:poc_clean/feature/catalog/repositories/catalog_repository.dart';

import 'catalog_bloc_test.mocks.dart';

@GenerateMocks([CatalogRepository])
late MockCatalogRepository mockCatalogRepository;

final mocklist = [
  Product(
    uuid: '44b8299e-3b3a-11ec-8d3d-0242ac130003',
    name: 'Caneca Flutter',
    description: 'Material: cerâmica resinada. Tamanho: 9,5 cm altura | 8 cm diâmetro. Capacidade: 350ml. Peso aproximado: 350 gramas.',
    image: 'https://cdn.awsli.com.br/1000x1000/608/608801/produto/54971833/2fa6e156a2.jpg',
    value: '32,90',
  )
];

void main() {
  setUp(() {
    mockCatalogRepository = MockCatalogRepository();
  });

  tearDown(() {
    reset(mockCatalogRepository);
  });

  blocTest(
    'should emits [LoadingState, LoadedState] when LoadEvent was emmit and the repository answer be a success',
    setUp: () async => when(mockCatalogRepository.getProducts(any)).thenAnswer((_) => Stream.fromIterable([mocklist])),
    build: () => CatalogBloc(mockCatalogRepository),
    act: (CatalogBloc bloc) => bloc.add(LoadEvent()),
    expect: () => [
      isA<LoadingState>(),
      isA<LoadedState>(),
    ],
  );

  blocTest(
    'should emits [LoadingState, FailureState] when LoadEvent was emmit and the repository answer be a fail',
    setUp: () async => {
      when(mockCatalogRepository.getProducts(any)).thenThrow(Exception()),
    },
    build: () => CatalogBloc(mockCatalogRepository),
    act: (CatalogBloc bloc) => bloc.add(LoadEvent()),
    expect: () => [
      isA<LoadingState>(),
      isA<FailureState>(),
    ],
  );

  blocTest(
    'should emits [LoadingState, LoadedState] when SearchEvent was emmit and the repository answer be a success',
    setUp: () async => when(mockCatalogRepository.getProducts(any)).thenAnswer((_) => Stream.fromIterable([mocklist])),
    build: () => CatalogBloc(mockCatalogRepository),
    act: (CatalogBloc bloc) => bloc.add(SearchEvent()),
    wait: const Duration(seconds: 2),
    expect: () => [
      isA<LoadingState>(),
      isA<LoadedState>(),
    ],
  );

  blocTest(
    'should emits [LoadingState, FailureState] when SearchEvent was emmit and the repository answer be a fail',
    setUp: () async => {
      when(mockCatalogRepository.getProducts(any)).thenThrow(Exception()),
    },
    build: () => CatalogBloc(mockCatalogRepository),
    act: (CatalogBloc bloc) => bloc.add(SearchEvent()),
    wait: const Duration(seconds: 2),
    expect: () => [
      isA<LoadingState>(),
      isA<FailureState>(),
    ],
  );
}
