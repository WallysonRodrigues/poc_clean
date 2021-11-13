import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:poc_clean/domain/entities/cart.dart';
import 'package:poc_clean/domain/entities/product.dart';
import 'package:poc_clean/feature/cart/bloc/cart/cart_bloc.dart';
import 'package:poc_clean/feature/cart/repositories/cart_repository.dart';

import 'cart_bloc_test.mocks.dart';

late MockCartRepository mockCartRepository;

final mockProduct = Product(
  uuid: '44b8299e-3b3a-11ec-8d3d-0242ac130003',
  name: 'Caneca Flutter',
  description: 'Material: cerâmica resinada. Tamanho: 9,5 cm altura | 8 cm diâmetro. Capacidade: 350ml. Peso aproximado: 350 gramas.',
  image: 'https://cdn.awsli.com.br/1000x1000/608/608801/produto/54971833/2fa6e156a2.jpg',
  value: '32,90',
);

final mockCartEmpty = Cart(
  products: [],
);

final mockCartNotEmpty = Cart(
  products: [mockProduct],
);

@GenerateMocks([CartRepository])
void main() {
  setUp(() {
    mockCartRepository = MockCartRepository();
  });

  tearDown(() {
    reset(mockCartRepository);
  });

  blocTest(
    'should emits LoadedState when LoadCartProductsEvent was emmit and the repository answer be a cart with products',
    setUp: () async => when(mockCartRepository.getCart()).thenAnswer((_) => Stream.fromIterable([mockCartNotEmpty])),
    build: () => CartBloc(mockCartRepository),
    act: (CartBloc bloc) => bloc.add(LoadCartProductsEvent()),
    expect: () => [
      isA<LoadedState>(),
    ],
  );

  blocTest(
    'should emits CartEmptyState when LoadCartProductsEvent was emmit and the repository answer be a cart without products',
    setUp: () async => when(mockCartRepository.getCart()).thenAnswer((_) => Stream.fromIterable([mockCartEmpty])),
    build: () => CartBloc(mockCartRepository),
    act: (CartBloc bloc) => bloc.add(LoadCartProductsEvent()),
    expect: () => [
      isA<CartEmptyState>(),
    ],
  );

  blocTest(
    'should emits LoadedState when LoadCartStatusEvent was emmit and the repository answer be a cart with products',
    setUp: () async => when(mockCartRepository.getCart()).thenAnswer((_) => Stream.fromIterable([mockCartNotEmpty])),
    build: () => CartBloc(mockCartRepository),
    act: (CartBloc bloc) => bloc.add(LoadCartStatusEvent()),
    expect: () => [
      isA<LoadedState>(),
    ],
  );

  blocTest(
    'should emits CartEmptyState when LoadCartStatusEvent was emmit and the repository answer be a cart without products',
    setUp: () async => when(mockCartRepository.getCart()).thenAnswer((_) => Stream.fromIterable([mockCartEmpty])),
    build: () => CartBloc(mockCartRepository),
    act: (CartBloc bloc) => bloc.add(LoadCartStatusEvent()),
    expect: () => [
      isA<CartEmptyState>(),
    ],
  );

  blocTest(
    'should emits [ProductAddedState, LoadedState] when LoadCartStatusEvent was emmit and the repository answer be a cart without products',
    setUp: () async => when(mockCartRepository.addProduct(any)).thenAnswer((_) => Stream.fromIterable([mockCartNotEmpty])),
    build: () => CartBloc(mockCartRepository),
    act: (CartBloc bloc) => bloc.add(AddProductToCartEvent(mockProduct)),
    expect: () => [
      isA<ProductAddedState>(),
      isA<LoadedState>(),
    ],
  );
}
