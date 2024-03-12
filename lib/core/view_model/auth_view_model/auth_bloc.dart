import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_store/core/services/firebase/user_services.dart';
import 'package:i_store/methods.dart';
import 'package:i_store/models/user_model.dart';
import 'package:i_store/core/view_model/auth_view_model/auth_states.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../helper/user_shared_prefenceses.dart';

class AuthBloc extends Cubit<AuthStates> {
  AuthBloc() : super(AuthValidationState());
  UserCredential? user;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  UsersServices firestoreServices = UsersServices();
  LocalStorage localStorage = LocalStorage();
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      user = await FirebaseAuth.instance.signInWithCredential(credential);
      UserModel userModel = UserModel(
          userId: user!.user!.uid,
          name: user!.user!.displayName!,
          email: user!.user!.email!,
//////////// email password
          password: null,
          date: DateTime.now().toString(),
          imageUrl: null,
          token: (await getDeviceToken())!);
       localStorage.setUserModel(userModel);
      firestoreServices.addUserToFirestore(userModel);
      Navigator.of(context).pushNamed('/home_screen');
    } catch (e) {
      print(e);
    }
  }

  Future<UserCredential?> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required context,
  }) async {
    bool complete = true;
    try {
      user = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password)
          .timeout(Duration(seconds: 4), onTimeout: () async {
        complete = false;
        showSnackBar('poor internet connection', context);
        return Future(() => user!);
      });
      if (complete) {
        UserModel userModel = UserModel(
            userId: user!.user!.uid!,
            name: name,
            email: user!.user!.email!,
            password: password,
            date: DateTime.now().toString(),
            imageUrl: null,
            token: (await getDeviceToken())!);
        firestoreServices.addUserToFirestore(userModel);
        FirebaseAuth.instance.currentUser!.sendEmailVerification();

        showSnackBar(
            'verification code sent to your email , please verify it first and login ',
            context);
        emit(AuthValidationState());
      }
      return user;
    } catch (e) {
      switch ((e as FirebaseAuthException).code) {
        case 'email-already-in-use':
          emit(AuthValidationState(
              emailValidator: 'this email is already taken'));
          break;
        case 'invalid-email':
          emit(AuthValidationState(
              emailValidator: 'please enter a valid email'));
          break;
        case 'weak-password':
          emit(AuthValidationState(passwordValidator: 'weak password'));
          break;
        default:
          print(e);
      }
    }
    return null;
  }

  Future<UserCredential?> signInWithEmailAndPassword(
      {required String email,
      required String password,
      required context}) async {
    try {
      bool wasComplete = true;
      user = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password)
          .timeout(const Duration(seconds: 4), onTimeout: () async {
        wasComplete = false;
        showSnackBar('poor internet connection', context);
        return user!;
      });
      if (wasComplete) {
      Map  userData =  await firestoreServices.getUserData(email);
        UserModel userModel = UserModel(
            userId:user!.user!.uid,
            name: userData['name'],
            email: email,
            password: password,
            date: userData['date'],
            token: userData['token'],
        );
        localStorage.setUserModel(userModel);
        Navigator.of(context).pushNamed('/home_screen');
      }
      return user;
    } catch (e) {
      switch ((e as FirebaseAuthException).code) {
        case 'user-not-found':
          emit(AuthValidationState(emailValidator: 'no user with this email'));
          break;
        case 'invalid-email':
          emit(AuthValidationState(
              emailValidator: 'please enter a valid email'));
          break;
        case 'wrong-password':
          emit(AuthValidationState(
              passwordValidator: 'your password in incorrect'));
          break;
        default:
          print(e);
      }
    }
  }
}
