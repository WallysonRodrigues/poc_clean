import '../entities/product.dart';

abstract class CatalogRepositoryInterface {
  Stream<List<Product>> getProducts(String? search);
  Stream<Product> getProduct(String uuid);
}
