import 'package:i_store/models/user_model.dart';

class ProfileStates{}
class ProfileInitialStates extends ProfileStates{}
class ProfileLoadedStates extends ProfileStates{
  UserModel userModel;

  ProfileLoadedStates(this.userModel);
}