import 'package:ecommerce_app/services/api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecommerce_app/services/api_service.dart';
import 'product_event.dart';
import 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductLoading()) {
    on<FetchProducts>((event, emit) async {
      try {
        final products = await ApiService.fetchProducts(event.page);
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Failed to load products'));
      }
    });
  }
}
