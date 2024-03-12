import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/user_model.dart';

class UsersServices {
  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  checkCurrentUserExistance() async {
    String? currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    bool wasUserExists = (await usersRef.get())
        .docs
        .any((e) => (e.data() as Map)['userId'] == currentUserUid);
    return wasUserExists;
  }

  Future<void> addUserToFirestore(UserModel userModel,) async {
    if (!(await checkCurrentUserExistance())) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userModel.userId)
          .set(
        userModel.toJson(),
      );
    }
  }

 Future<Map> getUserData(String email) async {
    Map? user = (await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()).data();

    return user!;
  }
}
