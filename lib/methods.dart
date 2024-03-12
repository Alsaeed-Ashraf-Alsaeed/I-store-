import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_store/constants/themes_colors/themes_colors.dart';
import 'package:i_store/view/pages/cart_page.dart';
import 'package:i_store/view/pages/home_screen.dart';
import 'package:i_store/view/pages/login_screen.dart';
import 'package:i_store/view/pages/main_page.dart';
import 'package:i_store/core/view_model/auth_view_model/auth_bloc.dart';

class MyRouter {

  static Route onRouteGenerate(RouteSettings settings) {
    User? user =  FirebaseAuth.instance.currentUser;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider<AuthBloc>(
            create: (ctx)=>AuthBloc(),
            child:user==null? LoginScreen():MainPage(),
          ),
        );
        case '/home_screen':
        return MaterialPageRoute(
          builder:(ctx)=>HomeScreen(),
        );
      case '/cart_page':
        return MaterialPageRoute(
          builder: (ctx) => CartPage(),
        );
      default:
        return MaterialPageRoute(builder: (ctx) => LoginScreen());
    }
  }
}

void showSnackBar(String content , BuildContext context){
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content:Text(content,style:MyTheme.styleSmall ,)));
}

Future<String?> getDeviceToken(){
  return FirebaseMessaging.instance.getToken();
}