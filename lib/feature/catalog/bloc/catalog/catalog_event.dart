part of 'catalog_bloc.dart';

abstract class CatalogBlocEvent {}

class LoadEvent extends CatalogBlocEvent {}

class SearchEvent extends CatalogBlocEvent {
  final String? search;
  SearchEvent({this.search});
}
