import '../entities/product.dart';
import '../repositories/catalog_repository.dart';

class GetProduct {
  final CatalogRepositoryInterface repository;

  GetProduct(this.repository);

  Stream<Product> call(String uuid) {
    return repository.getProduct(uuid);
  }
}
