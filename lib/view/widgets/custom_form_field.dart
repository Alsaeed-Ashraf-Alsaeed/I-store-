import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_store/constants/themes_colors/themes_colors.dart';

class CustomFormField extends StatelessWidget {
  CustomFormField(
      {Key? key,
      required this.icon,
      required this.hint,
      this.validator,
      this.controller})
      : super(key: key);
  Widget? icon;
  String hint;
  TextEditingController? controller;
  String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: controller,
            validator: validator,
            style: MyTheme.styleSmall
                .copyWith(color: Colors.black87, fontWeight: FontWeight.normal),
            cursorColor: Colors.black54,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(color: Colors.black45),
              prefixIcon: icon,
              enabledBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: BorderSide(width: 3, color: MyTheme.secondColor),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: BorderRadius.circular(20.r),
                borderSide: BorderSide(width: 3, color: MyTheme.secondColor),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
