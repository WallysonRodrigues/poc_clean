import '../entities/cart.dart';
import '../entities/product.dart';
import '../repositories/cart_repository.dart';

class AddProductToCart {
  final CartRepositoryInterface repository;

  AddProductToCart(this.repository);

  Stream<Cart> call(Product product) {
    return repository.addProduct(product);
  }
}
