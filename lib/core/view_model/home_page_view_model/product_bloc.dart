import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_store/core/services/firebase/home_page_services.dart';
import 'package:i_store/core/view_model/home_page_view_model/products_states.dart';

import '../../../models/product_model.dart';

class ProductsBloc extends Cubit<ProductsStates> {
  ProductsBloc() : super(ProductsInitialStates());
  List<Product> products = [];
  void getProducts() async {
    products = await HomeServices.getProducts();
    print(products);
    emit(ProductsLoadedStates(products: products));
  }
}
