import 'package:equatable/equatable.dart';

class GoogleSignInTokenResponseEntity extends Equatable{
  final String? sub;
  final String? name;
  final String? givenName;
  final String? familyName;
  final String? picture;
  final String? email;
  final bool? emailVerified;

  const GoogleSignInTokenResponseEntity({this.sub,
    this.name,
    this.givenName,
    this.familyName,
    this.picture,
    this.email,
    this.emailVerified});

  @override
  List<Object?> get props => [sub, name, givenName, familyName, picture, email, emailVerified];
}