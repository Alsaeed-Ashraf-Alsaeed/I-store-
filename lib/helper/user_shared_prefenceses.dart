import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:i_store/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
   Future<UserModel> getUserModel()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userModelJson =  prefs.getString('user');
     UserModel userModel = UserModel.fromJson(
       jsonDecode(userModelJson!),
     );
    return userModel ;
  }
  void setUserModel(UserModel userModel) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user', jsonEncode(userModel.toJson()));

  }

  Future<void> deleteUser() async {
     SharedPreferences prefs = await SharedPreferences.getInstance();
     prefs.clear();
  }
}
