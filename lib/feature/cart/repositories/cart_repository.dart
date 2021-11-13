import '../../../domain/entities/cart.dart';
import '../../../domain/entities/product.dart';
import '../../../domain/repositories/cart_repository.dart';

class CartRepository implements CartRepositoryInterface {
  final Cart _cart = Cart(products: [
    // Product(
    //   uuid: '44b8299e-3b3a-11ec-8d3d-0242ac130003',
    //   name: 'Caneca Flutter',
    //   description: 'Material: cerâmica resinada. Tamanho: 9,5 cm altura | 8 cm diâmetro. Capacidade: 350ml. Peso aproximado: 350 gramas.',
    //   image: 'https://cdn.awsli.com.br/1000x1000/608/608801/produto/54971833/2fa6e156a2.jpg',
    //   value: '32,90',
    // ),
  ]);

  @override
  Stream<Cart> addProduct(Product product) async* {
    _cart.products.add(product);

    yield (_cart);
  }

  @override
  Stream<Cart> getCart() async* {
    yield (_cart);
  }
}
