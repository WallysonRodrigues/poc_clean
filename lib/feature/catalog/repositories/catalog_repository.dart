import 'dart:async';

import '../../../domain/entities/product.dart';
import '../../../domain/repositories/catalog_repository.dart';

final List<Product> mockList = [
  Product(
    uuid: '44b8299e-3b3a-11ec-8d3d-0242ac130003',
    name: 'Caneca Flutter',
    description: 'Material: cerâmica resinada. Tamanho: 9,5 cm altura | 8 cm diâmetro. Capacidade: 350ml. Peso aproximado: 350 gramas.',
    image: 'https://cdn.awsli.com.br/1000x1000/608/608801/produto/54971833/2fa6e156a2.jpg',
    value: '32,90',
  ),
  Product(
    uuid: '4cf41370-3b3a-11ec-8d3d-0242ac130003',
    name: 'Smart Speaker Amazon Echo Show 5 Alexa',
    description: 'A Alexa com conteúdo em imagem e som: tela inteligente compacta de 5,5" pronta para ajudar a organizar seu dia, proporcionar diversão e conectar você aos seus amigos e familiares.',
    image: 'https://i.zst.com.br/thumbs/12/1c/30/929473822.jpg',
    value: '499,00',
  ),
];

class CatalogRepository implements CatalogRepositoryInterface {
  @override
  Stream<List<Product>> getProducts(String? search) async* {
    yield ([]);

    yield ((search == null) ? mockList : mockList.where((e) => e.name.toUpperCase().contains(search.toUpperCase())).toList());
  }

  @override
  Stream<Product> getProduct(String uuid) async* {
    yield (mockList.where((e) => e.uuid == uuid).first);
  }
}
