import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:i_store/core/view_model/profile_view_model/profile_states.dart';
import 'package:i_store/models/user_model.dart';

import '../../../helper/user_shared_prefenceses.dart';

class ProfileBloc extends Cubit<ProfileStates>{
  LocalStorage localStorage = LocalStorage();
  ProfileBloc() : super(ProfileInitialStates());
  Future<void> signUserOut()async {
   await  FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
     await localStorage.deleteUser();
  }

  Future<void> emitUserModel() async {
   UserModel user =await localStorage.getUserModel();
   emit(ProfileLoadedStates(user));

  }
}