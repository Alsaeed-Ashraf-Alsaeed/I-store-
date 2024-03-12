import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_store/constants/themes_colors/themes_colors.dart';
import 'package:i_store/models/product_model.dart';
import 'package:i_store/view/widgets/custom_form_field.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';

class CheckOutPage extends StatefulWidget {
  List<Product> products;
  CheckOutPage({Key? key,required this.products}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {



  int currentPageIndex = 0;
  int gvalue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Container(
            height: 760.h,
            width: 400.w,
            child: Column(
              children: [
                SizedBox(
                  height: 50.h,
                ),
                IconStepper(
                  onStepReached: (idx) {
                    currentPageIndex = idx;
                    setState(() {});
                  },
                  activeStep: currentPageIndex,
                  lineLength: 70.w,
                  lineDotRadius: 1.5.r,
                  stepRadius: 20.r,
                  activeStepBorderColor: Colors.redAccent,
                  lineColor: Colors.redAccent,
                  stepColor: Colors.black26,
                  activeStepColor: Colors.redAccent,
                  icons: const [
                    Icon(Icons.date_range),
                    Icon(Icons.add_location_rounded),
                    Icon(Icons.access_alarm),
                  ],
                ),
                Column(
                  children: [
                    AnimatedSwitcher(
                        duration: const Duration(milliseconds: 600),
                        child: currentPageIndex == 0
                            ? buildPage1()
                            : currentPageIndex == 1
                                ? buildPage2()
                                : currentPageIndex == 2
                                    ? buildPage3()
                                    : Container()),
                  ],
                ),
                Expanded(child: SizedBox()),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (currentPageIndex == 1 || currentPageIndex == 2)
                      Container(
                        width: 150.w,
                        child: ElevatedButton(
                          child: Text('<   previous  '),
                          onPressed: () {
                            currentPageIndex--;
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent),
                        ),
                      ),
                    SizedBox(
                      width: 30.w,
                    ),
                    if (currentPageIndex == 0 || currentPageIndex == 1)
                      Container(
                        width: 150.w,
                        child: ElevatedButton(
                          child: Text('next   >'),
                          onPressed: () {
                            currentPageIndex++;
                            setState(() {});
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.redAccent),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RadioListTile<int> buildRadioListTile(
      int value, String title, String subTitle) {
    return RadioListTile(
      activeColor: Colors.redAccent,
      title: Text(
        title,
        style: MyTheme.styleSmall.copyWith(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subTitle),
      value: value,
      groupValue: gvalue,
      onChanged: (val) {
        gvalue = val as int;
        print(gvalue);
        setState(() {});
      },
    );
  }

  Container buildPage1() {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 40.h,
          ),
          Text(
            'Delivery Strategy',
            style: MyTheme.styleMedium,
          ),
          SizedBox(
            height: 30.h,
          ),
          buildRadioListTile(0, 'Normal delivery ',
              '\nThis order will be delivered between 3 to 5 dayes '),
          SizedBox(
            height: 25.h,
          ),
          buildRadioListTile(1, 'next day delivery ',
              '\nThis order will be delivered next day after completing purchasing '),
          SizedBox(
            height: 25.h,
          ),
          buildRadioListTile(2, 'nominated  delivery ',
              '\n Choose the day you want to receive the order at'),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }

  Widget buildPage2() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 30.h,
          ),
          Text(
            'Where do you want to receive the order at ?',
            style: MyTheme.styleSmall.copyWith(color: Colors.redAccent),
          ),
          SizedBox(height: 40.h),
          CustomFormField(
              icon: Icon(
                Icons.route,
                color: Colors.black,
              ),
              hint: 'Street 1 '),
          SizedBox(height: 40.h),
          CustomFormField(
              icon: Icon(
                Icons.route,
                color: Colors.black,
              ),
              hint: 'Street 2'),
          SizedBox(height: 40.h),
          CustomFormField(
              icon: Icon(
                Icons.location_city,
                color: Colors.black,
              ),
              hint: 'city'),
           SizedBox(height: 40.h,),
          Container(
            height: 50.h,
            width: 400.w,
            child: Row(
             children: [
               SizedBox(
                 width: 170.w,
                   child: CustomFormField(icon: Icon(Icons.account_balance_rounded,color: Colors.black,), hint: 'State')),
               Expanded(child: SizedBox()),
               SizedBox(
                 width: 170.w,
                 child: CustomFormField(icon: Icon(Icons.maps_home_work_outlined,color: Colors.black,),hint: 'Country',),
               ),

             ],
          ),),

        ],
      ),
    );
  }

  Container buildPage3() {
    return Container(
      width: double.infinity,
      height: 550.h,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
        Center(
          child: SizedBox(
            width: 350.w,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent
              ),
              onPressed: () {  },
              child: Text('Confirm'),

            ),
          ),
        ),
          ],
      ),
    );
  }
}
