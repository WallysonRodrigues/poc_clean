import '../entities/cart.dart';
import '../entities/product.dart';

abstract class CartRepositoryInterface {
  Stream<Cart> getCart();
  Stream<Cart> addProduct(Product product);
}
