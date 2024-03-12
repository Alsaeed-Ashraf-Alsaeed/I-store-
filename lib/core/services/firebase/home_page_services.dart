import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:i_store/models/product_model.dart';

class HomeServices {
  static Future<List<Product>> getProducts() async {
    List<Product> products = [];
    QuerySnapshot query =
        await FirebaseFirestore.instance.collection('products').orderBy(
          'date',
          descending: true,
        ). get();

    products =
        query.docs.map((e) => Product.fromJson(e.data() as Map)).toList();
     print(products);
    return products;
  }
}
