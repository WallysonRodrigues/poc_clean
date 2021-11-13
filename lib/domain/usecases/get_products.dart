import '../entities/product.dart';
import '../repositories/catalog_repository.dart';

class GetProducts {
  final CatalogRepositoryInterface repository;

  GetProducts(this.repository);

  Stream<List<Product>> call({String? search}) {
    return repository.getProducts(search);
  }
}
