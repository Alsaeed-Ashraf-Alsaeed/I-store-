import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_store/core/view_model/cart_view_model/cart_bloc.dart';
import 'package:i_store/core/view_model/home_page_view_model/product_bloc.dart';
import 'package:i_store/core/view_model/profile_view_model/profile_bloc.dart';
import 'package:i_store/view/pages/admin_page.dart';
import 'package:i_store/view/pages/cart_page.dart';
import 'package:i_store/view/pages/home_screen.dart';
import 'package:i_store/view/pages/profile_page.dart';

class  MainPage extends StatefulWidget {
    MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int idx = 0 ;
  CartBloc cartBloc =CartBloc();
  late List pages ;
  @override
  void dispose() {
    cartBloc.close();
    super.dispose();
  }
  @override
  void initState() {
   pages =  [
     BlocProvider<ProductsBloc>(
         create: (ctx)=>ProductsBloc(),
         child: BlocProvider.value(
             value: cartBloc,
             child: HomeScreen())),
     BlocProvider.value(
         value: cartBloc,
         child: CartPage()),
     BlocProvider<ProfileBloc>(
       create: (ctx)=>ProfileBloc(),
         child: ProfilePage()),
     AdminPage(),
   ];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: buildCurvedNavigationBar(context),
      body:pages[idx],
    );
  }

  buildCurvedNavigationBar(context) {
    CurvedNavigationBarItem buildCurvedNavigationBarItem(IconData icon ,String  text) {
      return CurvedNavigationBarItem(
        child: Icon(icon,size: 20.r,color: Colors.white,),
        label: text,
        labelStyle: TextStyle(fontSize: 13.r,color: Colors.white),

      );
    }
    return CurvedNavigationBar(

      iconPadding: 10,

      height: 50.h,
      backgroundColor: Colors.white,
      color: Colors.redAccent,
      animationDuration: Duration(milliseconds: 400),
      items:  [
        buildCurvedNavigationBarItem(Icons.home,'Home'),
        buildCurvedNavigationBarItem(Icons.shopping_cart_outlined,'Cart'),
        buildCurvedNavigationBarItem(Icons.person,'Profile'),
        buildCurvedNavigationBarItem(Icons.admin_panel_settings,'Admin'),

      ],
      onTap: (index) {
        idx=index;
        setState((){});
      },
    );

  }
}
