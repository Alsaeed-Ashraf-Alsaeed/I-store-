import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_store/constants/themes_colors/themes_colors.dart';
import 'package:i_store/core/services/firebase/admin_Services.dart';
import 'package:i_store/models/product_model.dart';

class AdminPage extends StatefulWidget {
  AdminPage({Key? key}) : super(key: key);

  @override
  State<AdminPage> createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  TextEditingController nameController = TextEditingController();

  TextEditingController typeController = TextEditingController();

  TextEditingController detailsController = TextEditingController();

  TextEditingController priceController = TextEditingController();

  TextEditingController quantityController = TextEditingController();

  AdminServices adminServices = AdminServices();

  String? imageUrl;

  bool wasAdding = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Admin'),
        toolbarHeight: 40.h,
        elevation: 0,
        backgroundColor: Colors.redAccent,
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(10.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              decoration: BoxDecoration(),
              width: 300.w,
              height: 40.h,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                ),
                onPressed: () {
                  showDialog(
                      context: context,
                      barrierColor: Colors.black45.withOpacity(0.6),
                      builder: (ctx) => AlertDialog(
                            scrollable: true,
                            insetPadding: EdgeInsets.only(
                              left: 20.w,
                              right: 20.w,
                            ),
                            elevation: 0,
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            backgroundColor: Colors.cyanAccent.withOpacity(0),
                            content: buildAddProductForm(context),
                          ));
                },
                child: Text(
                  'Add Product',
                  style: MyTheme.styleSmall.copyWith(color: Colors.white),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Material buildAddProductForm(BuildContext context) {
    return Material(
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.redAccent,
        ),
        padding: EdgeInsets.only(
          left: 10.w,
          right: 10.w,
          top: 10.h,
          bottom: MediaQuery.of(context).viewInsets.bottom + 40.h,
        ),
        child: SingleChildScrollView(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20.h,
                ),
                InkWell(
                  onTap: () {
                    print(MediaQuery.of(context).viewInsets.bottom);
                  },
                  child: Text(
                    'Add New Products here',
                    style: MyTheme.styleSmall.copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 150.w,
                            child: buildTextFormField(
                                hint: 'name',
                                controller: nameController,
                                icon: Icons.production_quantity_limits),
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Container(
                            width: 150.w,
                            child: buildTextFormField(
                                hint: 'type',
                                controller: typeController,
                                icon: Icons.sort_outlined),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 10.w),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            'Pick product Image',
                            style: MyTheme.styleSmall.copyWith(
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                          InkWell(
                            onTap: () async {
                              imageUrl =
                                  await adminServices.addImageToStorage();
                            },
                            child: Icon(
                              Icons.image_search_sharp,
                              size: 100.r,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                buildTextFormField(
                  hint: 'Details ',
                  controller: detailsController,
                  icon: Icons.description_outlined,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Row(
                  children: [
                    Expanded(
                      child: buildTextFormField(
                        hint: 'price',
                        controller: priceController,
                        icon: Icons.attach_money_sharp,
                        validator: (val) {
                          if (val != int) {
                            return 'numbers only';
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      width: 15.w,
                    ),
                    Expanded(
                      child: buildTextFormField(
                        hint: 'quantity',
                        controller: quantityController,
                        icon: Icons.format_list_numbered_rtl_sharp,
                        validator: (val) {
                          if (val != int) {
                            return 'numbers only';
                          }
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                wasAdding == false
                    ? SizedBox(
                        height: 40.h,
                        width: 400.w,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white),
                            onPressed: () {
                              wasAdding = true;
                              if (imageUrl != null) {
                                Product product = Product(
                                  name: nameController.text,
                                  type: typeController.text,
                                  details: detailsController.text,
                                  price: priceController.text,
                                  quantity: quantityController.text,
                                  imageUrl: imageUrl!,
                                  date: DateTime.now().toString(),
                                );
                                AdminServices.addProduct(product);
                                wasAdding = false;
                                Navigator.of(context).pop();
                              }
                            },
                            child: Text(
                              'Add product',
                              style: MyTheme.styleSmall
                                  .copyWith(color: Colors.redAccent),
                            )),
                      )
                    : Image.asset('assets/images/loading2.gif'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container buildTextFormField(
      {required String hint,
      required TextEditingController controller,
      required icon,
      validator}) {
    return Container(
      height: 50.h,
      child: TextFormField(
        validator: validator,
        controller: controller,
        style: MyTheme.styleSmall
            .copyWith(color: Colors.white, fontWeight: FontWeight.normal),
        cursorColor: Colors.white30,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            size: 20.r,
            color: Colors.white,
          ),
          hintText: hint,
          hintStyle: MyTheme.styleSmall.copyWith(color: Colors.white54),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(width: 2.w, color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.r),
            borderSide: BorderSide(width: 2.w, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
