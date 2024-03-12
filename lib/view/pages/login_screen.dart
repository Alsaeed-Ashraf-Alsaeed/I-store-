import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:i_store/constants/themes_colors/themes_colors.dart';
import 'package:i_store/view/widgets/custom_form_field.dart';
import 'package:i_store/core/view_model/auth_view_model/auth_bloc.dart';
import 'package:i_store/core/view_model/auth_view_model/auth_states.dart';

import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool wasLogin = false;
  bool wasSignUp = false;
  bool wasMainPage = true;
  GlobalKey<FormState> loginFormKey = GlobalKey();
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  late AuthBloc authBloc;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
   User? currentUser  ;
   bool wasloading =false;
   bool wasloadingGoogle =false;
  @override
  void initState() {
    authBloc = BlocProvider.of<AuthBloc>(context);
    currentUser= FirebaseAuth.instance.currentUser;
    super.initState();
  }
   @override
  void dispose() {
    if(currentUser!=null){
      if(!currentUser!.emailVerified){
        currentUser!.delete();
      }
    }
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: 800.h,
          width: 400.w,
          decoration: const BoxDecoration(
            color: MyTheme.mainColor,
          ),
          padding: EdgeInsets.all(10.r),
          child: Container(
            child: BlocBuilder<AuthBloc, AuthStates>(buildWhen: (pre, current) {

              return (current as AuthValidationState).emailValidator == null &&
                  (current).passwordValidator == null;
            }, builder: (ctx, widget) {
              print('BB built');
              return Column(
                children: [
                  AnimatedContainer(
                    duration: Duration(milliseconds: 900),
                    height: wasMainPage ? 200.h : 80.h,
                  ),
                  InkWell(
                    onTap: (){

                    },
                    child: Icon(
                      Icons.shopping_cart,
                      size: 90.r,
                      color: MyTheme.secondColor,
                    ),
                  ),
                  Text(
                    'I-Store ',
                    style: MyTheme.styleLarge,
                  ),
                  AnimatedContainer(
                    duration: Duration(milliseconds: 900),
                    height: 40.h,
                  ),
                  AnimatedSwitcher(
                    transitionBuilder: (w, ani) {
                      return SizeTransition(
                        sizeFactor: ani,
                        child: w,
                      );
                    },
                    duration: Duration(milliseconds: 900),
                    switchInCurve: Curves.linear,
                    child: wasMainPage
                        ? buildMainContainer()
                        : wasSignUp
                            ? buildSignUpContainer()
                            : wasLogin
                                ? buildLoginContainer()
                                : Container(),
                  )
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget buildLoginContainer() {
    print('login built');
    return Container(
      height: 520.h,
      decoration: BoxDecoration(
        color: MyTheme.mainColor,
        borderRadius: BorderRadius.circular(
          10.r,
        ),
      ),
      child: Container(
        margin: EdgeInsets.all(10.r),
        child: Form(
          key: loginFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text('Login', style: MyTheme.styleMedium),
              SizedBox(height: 10.h),
              CustomFormField(
                controller: emailController,
                validator: (val){
                  return (authBloc.state as AuthValidationState).emailValidator;
                },
                icon: Icon(
                  Icons.email,
                  size: 30.r,
                  color: MyTheme.secondColor,
                ),
                hint: 'email address',
              ),
              SizedBox(
                height: 25.h,
              ),
              CustomFormField(
                controller: passwordController,
                validator: (val){
                  return (authBloc.state as AuthValidationState).passwordValidator;
                },
                icon: Icon(
                  Icons.lock,
                  size: 30.r,
                  color: MyTheme.secondColor,
                ),
                hint: 'password',
              ),
              SizedBox(
                height: 30.h,
              ),
              !wasloading?
              CustomButton(
                textColor: Colors.white,
                onPressed: () async {
                 wasloading = true;
                 setState(() {

                 });
                  await authBloc.signInWithEmailAndPassword(email: emailController.text,
                      password: passwordController.text, context: context);
                  wasloading = false;
                  loginFormKey.currentState!.validate();
                  setState(() {

                  });
                },
                text: 'Login now',
                buttonColor: MyTheme.secondColor,
              ):
              Center(child: CircularProgressIndicator(color: MyTheme.secondColor,),),
              SizedBox(
                height: 20.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'don\'t have an account ?',
                    style: MyTheme.styleSmall,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  TextButton(
                      onPressed: () {
                        wasLogin = false;
                        wasMainPage = true;
                        setState(() {});
                      },
                      child: Text(
                        'click here',
                        style: MyTheme.styleSmall
                            .copyWith(fontWeight: FontWeight.bold),
                      )),
                ],
              ),
              Center(
                  child: Text(
                '- or -',
                style: MyTheme.styleSmall,
              )),
              buildSocialIcons(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMainContainer() {
    return SingleChildScrollView(
      child: Column(
        children: [
          CustomButton(
            textColor: Colors.white,
            buttonColor: MyTheme.secondColor,
            text: 'login',
            onPressed: () {
              wasLogin = true;
              wasMainPage = false;
              wasSignUp = false;
              print(wasLogin);
              print(wasMainPage);
              setState(() {});
            },
          ),
          SizedBox(
            height: 30.h,
          ),
          CustomButton(
            buttonColor: MyTheme.secondColor,
            text: 'Sign up ',
            onPressed: () {
              wasLogin = false;
              wasMainPage = false;
              wasSignUp = true;
              setState(() {});
            },
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  Container buildSignUpContainer() {
    return Container(
        margin: EdgeInsets.all(10.r),
        child: Form(
          key: signUpFormKey,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 8.h,
                ),
                Text('Sign Up ', style: MyTheme.styleMedium),
                SizedBox(
                  height: 20.h,
                ),
                CustomFormField(
                  controller: firstNameController,
                  icon: Icon(
                    Icons.person,
                    size: 30.r,
                    color: MyTheme.secondColor,
                  ),
                  hint: 'first name ',
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomFormField(
                  validator: (value) {
                    return (authBloc.state as AuthValidationState).emailValidator;
                  },
                  controller: emailController,
                  icon: Icon(
                    Icons.email,
                    size: 30.r,
                    color: MyTheme.secondColor,
                  ),
                  hint: 'email adress',
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomFormField(
                  icon: Icon(
                    Icons.lock,
                    size: 30.r,
                    color: MyTheme.secondColor,
                  ),
                  hint: 'password',
                  controller: passwordController,
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomFormField(
                  controller: confirmPasswordController,
                  icon: Icon(
                    Icons.lock,
                    size: 30.r,
                    color: MyTheme.secondColor,
                  ),
                  hint: 'confirm password',
                  validator: (value) {
                    if (passwordController.text !=
                        confirmPasswordController.text) {
                      return 'different passwords';
                    }
                  },
                ),
                SizedBox(
                  height: 20.h,
                ),
                !wasLogin?
                CustomButton(
                  textColor: Colors.white,
                  onPressed: () async {
                    wasLogin = true;
                    setState(() {

                    });
                    if (passwordController.text ==
                        confirmPasswordController.text) {
                      await authBloc.createUserWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text,
                        context: context,
                        name: firstNameController.text
                      ).then((value) {
                        wasMainPage=true;
                        wasLogin=false;
                        wasSignUp=false;
                        setState(() {
                        });
                      });
                      wasLogin = false;
                      setState(() {

                      });
                    }

                    signUpFormKey.currentState!.validate();
                  },
                  text: 'SignUp now',
                  buttonColor: MyTheme.secondColor,
                ):
                Center(child: CircularProgressIndicator(color: MyTheme.secondColor,)),
                SizedBox(
                  height: 8.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account ?',
                      style: MyTheme.styleSmall,
                    ),
                    SizedBox(
                      width: 5.h,
                    ),
                    TextButton(
                        onPressed: () {
                          wasLogin = false;
                          wasMainPage = true;
                          setState(() {});
                        },
                        child: Text(
                          'click here',
                          style: MyTheme.styleSmall
                              .copyWith(fontWeight: FontWeight.bold),
                        )),
                  ],
                ),
              ],
            ),
          ),
        ),
    );
  }

  Row buildSocialIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        InkWell(
          onTap: () {
            print(FirebaseAuth.instance.currentUser);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.facebook,
                size: 50.r,
                color: MyTheme.secondColor,
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'facebook',
                style: MyTheme.styleSmall,
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            FirebaseAuth.instance.signOut();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.phone,
                size: 50.r,
                color: MyTheme.secondColor,
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'phone number ',
                style: MyTheme.styleSmall,
              ),
            ],
          ),
        ),
        wasloadingGoogle == false?
        InkWell(
          onTap: () async {
            wasloadingGoogle=true;
            setState(() {

            });
            await context.read<AuthBloc>().signInWithGoogle(context);
            wasloadingGoogle = false;
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                Icons.android,
                size: 50.r,
                color: MyTheme.secondColor,
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Google',
                style: MyTheme.styleSmall,
              ),
            ],
          ),
        ):
            Center(child: CircularProgressIndicator(color: MyTheme.secondColor,)),
      ],
    );
  }
}
