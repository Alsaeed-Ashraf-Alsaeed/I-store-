import 'package:i_store/models/product_model.dart';

class ProductsStates {}


class ProductsInitialStates extends ProductsStates{}
class ProductsLoadedStates extends ProductsStates{
  List<Product> products ;
  ProductsLoadedStates({required this.products});
}
