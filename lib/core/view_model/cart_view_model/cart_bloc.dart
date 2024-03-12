import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_store/core/view_model/cart_view_model/cart_states.dart';

import '../../../models/product_model.dart';

class CartBloc extends Cubit<CartStates>{
  List<Product> products = [];
  CartBloc():super(CartInitialStates());
  void addToCart(Product product){
    product.addedToCart =true;
    products.add(product);
  }
  void removeFromCart(product){
    products.removeWhere((p) => p.date==product.date);
  }
  List<Product> addToCartPage(){
    emit(CartLoadedStates(products));
    return products;
  }
}