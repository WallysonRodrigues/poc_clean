part of 'product_detail_bloc.dart';

abstract class ProductDetailEvent {}

class DetailProductEvent extends ProductDetailEvent {
  final String uuid;

  DetailProductEvent(this.uuid);
}
