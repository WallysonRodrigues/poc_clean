import '../entities/cart.dart';
import '../repositories/cart_repository.dart';

class GetCart {
  final CartRepositoryInterface repository;

  GetCart(this.repository);

  Stream<Cart> call() {
    return repository.getCart();
  }
}
