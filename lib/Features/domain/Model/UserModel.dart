import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:yoo_live/Features/data/Entity/UserEntity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid,
    required super.name,
    required super.email,
    required super.country,
    required super.imgUrl,
  });

  factory UserModel.fromFirebaseUser(fb_auth.User user, String countryCode) {
    return UserModel(
      uid: user.uid,
      name: user.displayName ?? "No name found",
      email: user.email ?? "No email found",
      country: countryCode,
      imgUrl: user.photoURL ?? "No image found",
    );
  }

  factory UserModel.fromBackendJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['_id'] as String,
      // Assuming your backend sends back 'firebaseUid'
      name: json['name'] as String,
      email: json['email'] as String,
      country: json['country'] as String,
      imgUrl: json['profileImage'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "country": country,
      "profileImage": imgUrl,
    };
  }
}
