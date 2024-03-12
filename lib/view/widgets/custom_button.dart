import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../constants/themes_colors/themes_colors.dart';

class CustomButton extends StatelessWidget {
   CustomButton({Key? key,required this.textColor, required this.onPressed,  required this.text,required this.buttonColor}) : super(key: key);
  final String text ;
  final VoidCallback onPressed ;
  final Color buttonColor ;
  final Color textColor ;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius:BorderRadius.circular(12.r),
        ),
        width: 250.w,
        height:60.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor),
          onPressed: onPressed,
          child: Text(
            text,
            style: MyTheme.styleMedium
                .copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
