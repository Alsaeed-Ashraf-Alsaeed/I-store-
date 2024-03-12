
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_store/constants/themes_colors/themes_colors.dart';
import 'package:i_store/core/view_model/cart_view_model/cart_bloc.dart';
import '../../models/product_model.dart';

class DetailsScreen extends StatefulWidget {
  DetailsScreen({Key? key, required this.product}) : super(key: key);
  Product product;
  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  List products = [];
  @override
  void initState() {
    products = BlocProvider.of<CartBloc>(context).products;
   widget.product = !products.any((p) => p.date==widget.product.date)? widget.product: products.firstWhere((element) => element.date==widget.product.date);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.white,
            expandedHeight: 400.h,
            pinned: true,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 20.r,
                color: Colors.black,
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                widget.product.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.r),
                  topLeft: Radius.circular(30.r),
                ),
                color: Colors.black26,
              ),
              padding: EdgeInsets.symmetric(
                vertical: 20.h,
                horizontal: 20.w,
              ),
              height: 760.h,
              width: 370.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        widget.product.name,
                        style: MyTheme.styleMedium,
                      ),
                      Expanded(child: Container()),
                      Text(
                        '${widget.product.price} \$',
                        style: MyTheme.styleMedium
                            .copyWith(color: Colors.redAccent),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Text(
                    widget.product.details,
                    style: MyTheme.styleSmall
                        .copyWith(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 80.h,
        color: Colors.black26,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            buildBottomNavBarButtons(context),
          ],
        ),
      ),
    );
  }

  Container buildBottomNavBarButtons(BuildContext context) {
    return Container(
      width: 350.w,
      height: 40.h,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              widget.product.addedToCart! ? CupertinoColors.systemGreen : Colors.white,
        ),
        onPressed: () {

          if(widget.product.addedToCart==false){
            widget.product.addedToCart=true;
            BlocProvider.of<CartBloc>(context).addToCart(widget.product);
            setState(() {});
          }else{
            widget.product.addedToCart=false;
            BlocProvider.of<CartBloc>(context).removeFromCart(widget.product);
            setState(() {});
          }

        },
        child: !widget.product.addedToCart!
            ? Text(
                'add to cart ',
                style: MyTheme.styleSmall.copyWith(color: Colors.deepOrange),
              )
            : Icon(
                Icons.add_task,
                size: 30.r,
                color: Colors.white,
              ),
      ),
    );
  }
}
