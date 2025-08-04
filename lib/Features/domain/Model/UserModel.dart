import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:yoo_live/Features/data/Entity/UserEntity.dart';

class UserModel extends UserEntity{

  const UserModel(super.UId, super.name, super.email, super.imgUrl);

  factory UserModel.fromFirebaseUser(fb_auth.User user){
    return UserModel(user.uid, user.displayName ?? "No Name", user.email ?? "No Email", user.photoURL ?? "");
  }

}