import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:yoo_live/Features/data/Entity/UserEntity.dart';

class UserModel extends UserEntity {
  const UserModel(
    super.name,
    super.email,
    super.address,
    super.country,
    super.imgUrl,
  );

  factory UserModel.fromFirebaseUser(
    fb_auth.User user,
    String country,
    String address,
  ) {
    return UserModel(
      user.displayName ?? "No name found",
      user.email ?? "No email found",
      address,
      country,
      user.photoURL ?? "No image found",
    );
  }

  Map<String,dynamic> toJson(){
    return {
      "name":name,
      "email":email,
      "address":address,
      "country":country,
      "imgUrl":imgUrl,
    };
  }
}