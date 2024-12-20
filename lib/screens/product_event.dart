import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchProducts extends ProductEvent {
  final int page;

  FetchProducts(this.page);

  @override
  List<Object> get props => [page];
}
