import 'package:i_store/models/product_model.dart';

class CartStates {}

class CartInitialStates extends CartStates{}
class CartLoadedStates extends CartStates{
 List<Product> products ;

 CartLoadedStates(this.products);
}