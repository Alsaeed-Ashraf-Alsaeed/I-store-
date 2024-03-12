import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_store/constants/themes_colors/themes_colors.dart';
import 'package:i_store/core/view_model/profile_view_model/profile_bloc.dart';
import 'package:i_store/core/view_model/profile_view_model/profile_states.dart';
import 'package:i_store/helper/user_shared_prefenceses.dart';
import 'package:i_store/models/user_model.dart';

import 'login_screen.dart';

class ProfilePage extends StatefulWidget {
   ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
LocalStorage localStorag = LocalStorage();


@override
  void initState() {
  BlocProvider.of<ProfileBloc>(context).emitUserModel();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   localStorag.getUserModel();
    return BlocBuilder<ProfileBloc,ProfileStates>(
      builder:(ctx,states) {
        if(states is ProfileInitialStates){
          return Container();
        }else if( states is ProfileLoadedStates){
          return Scaffold(
            body: Container(
              padding: EdgeInsets.all(10.r),
              child: Column(
                children: [
                  SizedBox(
                    height: 40.h,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        child: Icon(Icons.person,size: 90.r,color: Colors.black54,),
                        radius: 60.r,
                        backgroundColor: Colors.black26,
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            states.userModel.name,
                            style: MyTheme.styleMedium,
                          ),
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            states.userModel.email,
                            style: MyTheme.styleSmall.copyWith(color: Colors.black54,fontSize: 15.r),
                          ),
                        ],
                      ),
                      Expanded(child: SizedBox()),
                    ],
                  ),
                  SizedBox(height: 100.h,),
                  ListTile(
                    leading: Icon(Icons.edit,size: 30.r,color: Colors.black54, ),
                    title: Text('Edit your profile ',style: MyTheme.styleSmall.copyWith(fontWeight: FontWeight.normal),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(height: 20.h,),
                  ListTile(
                    leading: Icon(Icons.add_location_rounded,size: 30.r,color: Colors.black54, ),
                    title: Text('Edit my location ',style: MyTheme.styleSmall.copyWith(fontWeight: FontWeight.normal),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(height: 20.h,),
                  ListTile(
                    leading: Icon(Icons.credit_card_sharp,size: 30.r,color: Colors.black54, ),
                    title: Text('My cards',style: MyTheme.styleSmall.copyWith(fontWeight: FontWeight.normal),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(height: 20.h,),
                  ListTile(
                    leading: Icon(Icons.done_outline_rounded,size: 30.r,color: Colors.black54, ),
                    title: Text('My purchases',style: MyTheme.styleSmall.copyWith(fontWeight: FontWeight.normal),),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(height: 20.h,),
                  Expanded(child: SizedBox()),
                  SizedBox(
                      height: 40.h,
                      width: 400.w,
                      child: ElevatedButton(
                          style:ElevatedButton.styleFrom(backgroundColor: Colors.redAccent) ,
                          onPressed: ()async{
                            await BlocProvider.of<ProfileBloc>(context).signUserOut();
                            Navigator.of(context).pushReplacementNamed(
                              '/',
                            );
                          }, child: Text('Sign Out'))),
                  SizedBox(height: 20.h,),
                ],
              ),
            ),
          );
        }else{
          return Container();
        }


      },
    );
  }
}
