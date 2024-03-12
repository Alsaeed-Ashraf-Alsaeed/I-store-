import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:i_store/models/product_model.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class AdminServices {

  static void addProduct(Product product) {
    FirebaseFirestore.instance.collection('products').add(product.toJson(),);
  }
  Future? addImageToStorage() async {
    File file;
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      file = File(result.files.single.path!);
      Reference imageRef =
      FirebaseStorage.instance.ref('images/${result.files.single.name}');
      await imageRef.putFile(file);
      return imageRef.getDownloadURL();
    }
  }
}
