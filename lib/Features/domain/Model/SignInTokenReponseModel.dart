import 'package:yoo_live/Features/data/Entity/SignInTokenReponseEntity.dart';

class GoogleSignInTokenResponseModel extends GoogleSignInTokenResponseEntity {
  const GoogleSignInTokenResponseModel({
    required super.sub,
    required super.name,
    required super.givenName,
    required super.familyName,
    required super.picture,
    required super.email,
    required super.emailVerified,
  });

  GoogleSignInTokenResponseModel.fromJson(Map<String, dynamic> json) {
     GoogleSignInTokenResponseModel(
        sub: json['sub'] as String,
        name: json['name'] as String,
        givenName: json['given_name'] as String,
        familyName: json['family_name'] as String,
        picture: json['picture'] as String,
        email: json['email'] as String,
        emailVerified: json['email_verified'] as bool);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sub'] = this.sub;
    data['name'] = this.name;
    data['given_name'] = this.givenName;
    data['family_name'] = this.familyName;
    data['picture'] = this.picture;
    data['email'] = this.email;
    data['email_verified'] = this.emailVerified;
    return data;
  }

}
