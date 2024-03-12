import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_store/constants/themes_colors/themes_colors.dart';
import 'package:i_store/core/view_model/home_page_view_model/product_bloc.dart';
import 'package:i_store/core/view_model/home_page_view_model/products_states.dart';
import 'package:i_store/view/pages/details_screen.dart';
import 'package:i_store/view/widgets/custom_form_field.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dotted_border/dotted_border.dart';

import '../../core/view_model/cart_view_model/cart_bloc.dart';
import '../../models/product_model.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);


  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  List<Map> categories = [
    {'type': 'all', 'icon': Icons.align_horizontal_left},
    {'type': 'women ', 'icon': Icons.woman},
    {'type': 'men', 'icon': Icons.man},
    {'type': 'children ', 'icon': Icons.child_friendly},
    {'type': 'devices', 'icon': Icons.important_devices_rounded},
    {'type': 'games', 'icon': Icons.videogame_asset},
    {'type': 'computers', 'icon': Icons.computer},
    {'type': 'phones', 'icon': Icons.smartphone_outlined},
  ];

   List<Product> products = [];


@override
  void initState() {
    BlocProvider.of<ProductsBloc>(context).getProducts();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        height: 750.h,
        width: 400.w,
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          top: 25.h,
        ),

        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                 Text('IStore',style: MyTheme.styleLarge.copyWith(color: Colors.redAccent),),
                  Icon(Icons.shopping_cart_outlined,size: 40.r,color: Colors.redAccent,)

                ],
              ),
              SizedBox(
                height: 30.h,
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                height: 90.h,
                child: ListView.separated(
                  separatorBuilder: (ctx, idx) => SizedBox(
                    width: 20.w,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (ctx, idx) {
                    return buildCategory(
                        categories[idx]['icon'], categories[idx]['type']);
                  },
                ),
              ),
              Row(
                children: [
                  Text(
                    'products',
                    style: MyTheme.styleMedium,
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  Text(
                    'See all >',
                    style: MyTheme.styleSmall,
                  )
                ],
              ),
              Container(
                decoration: BoxDecoration(),
                height: 310.h,
                child: buildProductsSlider(),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 360.h,
                child: Row(
                  children: [
                    buildBestSellsSlider('Best sells', false),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  BlocBuilder buildProductsSlider() {
    return BlocBuilder<ProductsBloc,ProductsStates>(
      builder: (context,states) {
        if(states is ProductsInitialStates){
           return Center(
             child: Image.asset('assets/images/loading2.gif',height: 100,width: 100,),
           );
        }else{
          return CarouselSlider.builder(
            itemCount:(states as ProductsLoadedStates).products.length,
            itemBuilder: (ctx, idx, ridx) {
              List products =  (states as ProductsLoadedStates).products;
              return InkWell(
                onTap: (){
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx)=>BlocProvider.value(
                      value: BlocProvider.of<CartBloc>(context),
                      child: DetailsScreen(
                        product: products[idx],
                      ),
                    )),
                  );
                },
                child: SizedBox(


                height: 310.h,
                width: 200.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(

                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15.r,
                        ),
                      ),
                      child: FadeInImage(
                      width: 200.w,
                        height: 210.h,
                        fit:BoxFit.cover,
                        image: NetworkImage(
                          products[idx].imageUrl,
                        ),
                        placeholder: AssetImage('assets/images/loading.gif'),
                      ),
                    ),
                    SizedBox(height: 7.h,),
                    Text(
                      '${products[idx].name}',
                      style: MyTheme.styleSmall,
                    ),
                    Text(
                      '${products[idx].type}',
                      style: MyTheme.styleSmall
                          .copyWith(fontSize: 20.r, color: Colors.black54),
                    ),
                    Text(
                      '${products[idx].price} \$',
                      style: MyTheme.styleSmall
                          .copyWith(fontSize: 20.r, color: Colors.redAccent),
                    ),
                  ],
                ),
            ),
              );
            },
            options: CarouselOptions(
               enableInfiniteScroll: false,
              viewportFraction: 0.6,
              enlargeFactor: 0.6,
              enlargeStrategy: CenterPageEnlargeStrategy.zoom,
              enlargeCenterPage: true,
              height: 260.h,
            ),
          );
        }

      }
    );
  }

  Expanded buildBestSellsSlider(String text, bool top) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                text,
                style: MyTheme.styleMedium.copyWith(color: Colors.black),
              ),
              Expanded(child: Container()),
              Icon(
                Icons.arrow_forward_ios,
                size: 25.r,
                color: Colors.black54,
              )
            ],
          ),
          SizedBox(
            height: 4.h,
          ),
          CarouselSlider.builder(
            itemCount: 10,
            itemBuilder: (ctx, idx, idx2) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 6.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
                      height: 80.h,
                      width: 200.h,
                      child: Image.asset(
                        'assets/images/${top ? 'shoes' : 'shoes2'}.jpg',
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      'Sports shoes',
                      style: MyTheme.styleSmall.copyWith(color: Colors.black),
                    ),
                    Row(
                      children: [
                        Text(
                          'Nike',
                          style: MyTheme.styleSmall
                              .copyWith(color: Colors.black45),
                        ),
                        Expanded(child: Container()),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 25.r,
                          color: Colors.redAccent,
                          weight: 20,
                        ),
                      ],
                    ),
                    Text(
                      '400\$',
                      style: MyTheme.styleSmall.copyWith(
                          fontWeight: FontWeight.w600, color: Colors.redAccent),
                    ),
                  ],
                ),
              );
            },
            options: CarouselOptions(
              height: 160.w,
              viewportFraction: 0.6,
              padEnds: true,

              autoPlay: true,
               autoPlayAnimationDuration: Duration(seconds: 2),
              autoPlayInterval:Duration(seconds: 10),

            ),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(13.r),
      borderSide: BorderSide(color: MyTheme.secondColor, width: 2),
    );
  }

  Column buildCategory(IconData icon, String text) {
    return Column(
      children: [
        Icon(
          icon,
          size: 35.r,
          color: MyTheme.secondColorLighter,
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          text,
          style: MyTheme.styleSmall.copyWith(fontSize: 15.r),
        ),
      ],
    );
  }
}
