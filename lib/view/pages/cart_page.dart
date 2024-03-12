import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_store/constants/themes_colors/themes_colors.dart';
import 'package:i_store/core/view_model/cart_view_model/cart_bloc.dart';
import 'package:i_store/core/view_model/cart_view_model/cart_states.dart';
import 'package:i_store/view/pages/check_out_page.dart';

import '../../models/product_model.dart';

class CartPage extends StatefulWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late List products;
  double total = 0;

  @override
  void initState() {
    products = BlocProvider.of<CartBloc>(context).addToCartPage();
    getTotalPrice();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(10.r),
        height: 750.h,
        width: 400.w,
        child: BlocBuilder<CartBloc, CartStates>(
          builder: (ctx, states) {
            List<Product> products = (states as CartLoadedStates).products;

            if (products.isEmpty) {
              return Center(
                child: Text(
                  'No Items yet.....',
                  style: MyTheme.styleMedium.copyWith(color: Colors.redAccent),
                ),
              );
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  Row(
                    children: [
                      Text(
                        'My Cart',
                        style: MyTheme.styleLarge,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 40.r,
                      )
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: products.length,
                      itemBuilder: (ctx, idx) {
                        return Container(
                          margin: EdgeInsets.all(5.r),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 200.h,
                                width: 200.w,
                                child: Image.network(
                                  products[idx].imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              SizedBox(
                                width: 20.w,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    products[idx].name,
                                    style: MyTheme.styleMedium,
                                  ),
                                  SizedBox(
                                    height: 20.h,
                                  ),
                                  Text(
                                    '${products[idx].price} \$',
                                    style: MyTheme.styleSmall
                                        .copyWith(color: Colors.redAccent),
                                  ),
                                  SizedBox(height: 30.h),
                                  Row(
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            if (products[idx].numOf!>0) {
                                              products[idx].numOf =
                                                  products[idx].numOf! - 1;
                                            }
                                            getTotalPrice();
                                            setState(() {});
                                          },
                                          child: const CircleAvatar(
                                              backgroundColor: Colors.black26,
                                              child: Icon(
                                                Icons.exposure_minus_1,
                                                color: Colors.redAccent,
                                              ))),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      Text(products[idx].numOf!.toString()),
                                      SizedBox(
                                        width: 10.w,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          if (products[idx].numOf! <
                                              int.parse(
                                                  products[idx].quantity)) {
                                            products[idx].numOf =
                                                products[idx].numOf! + 1;
                                          }
                                          getTotalPrice();
                                          setState(() {});
                                        },
                                        child: const CircleAvatar(
                                          backgroundColor: Colors.black26,
                                          child: Icon(
                                            Icons.plus_one,
                                            color: Colors.green,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: 70.h,
                    child: Row(
                      children: [
                        Column(
                          children: [
                            SizedBox(
                              height: 10.h,
                            ),
                            Text(
                              'total price',
                              style: MyTheme.styleSmall
                                  .copyWith(color: Colors.black),
                            ),
                            Text(
                              '$total \$',
                              style: MyTheme.styleMedium
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                        const Expanded(child: SizedBox()),
                        Container(
                          height: 50.h,
                          width: 150.w,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.redAccent),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(builder: (ctx)=>CheckOutPage(products:products ,)),
                              );
                            },
                            child: const Text('Buy now '),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void getTotalPrice() {
    total = 0;
    for (Product p in products) {
      total += int.parse(p.price) * p.numOf!;
    }
    setState(() {});
  }
}
