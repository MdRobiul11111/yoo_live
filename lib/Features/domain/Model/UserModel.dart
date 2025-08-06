import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:yoo_live/Features/data/Entity/UserEntity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.uid, // UID is now required from UserEntity
    required super.name,
    required super.email,
    required super.address,
    required super.country,
    required super.imgUrl,
  });

  // Factory constructor to create UserModel from Firebase User
  factory UserModel.fromFirebaseUser(
    fb_auth.User user,
    String countryCode,
    String city,
  ) {
    return UserModel(
      uid: user.uid,
      // Use Firebase User's UID
      name: user.displayName ?? "No name found",
      email: user.email ?? "No email found",
      address: city,
      country: countryCode,
      imgUrl: user.photoURL ?? "No image found",
    );
  }

  // NEW: Factory constructor to parse JSON response from your backend API
  // This assumes your backend returns a JSON structure similar to your toJson()
  // or whatever structure it uses to represent a saved user.
  factory UserModel.fromBackendJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['_id'] as String,
      // Assuming your backend sends back 'firebaseUid'
      name: json['name'] as String,
      email: json['email'] as String,
      address: json['address'] as String,
      country: json['country'] as String,
      imgUrl: json['profileImage'] as String,
      // If your backend auto-generates its own 'id' and returns it,
      // and you need it in your UserModel, you'd add a field to UserModel
      // and parse it here. Example: 'id': json['id'] as String,
    );
  }

  // Method to convert UserModel to JSON for sending to your backend
  // This is what you pass to `data` in your POST request.
  // It correctly omits an 'id' field as your backend auto-generates it.
  @override // Use @override since UserEntity now has a toJson if you put it there
  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "email": email,
      "address": address,
      "country": country,
      "profileImage": imgUrl,
    };
  }
}
