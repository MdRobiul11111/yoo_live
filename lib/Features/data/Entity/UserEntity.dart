import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String uid; // Added UID to UserEntity as it's a core identifier
  final String name;
  final String email;
  final String country;
  final String imgUrl;

  const UserEntity({
    required this.uid,
    required this.name,
    required this.email,
    required this.country,
    required this.imgUrl,
  });

  @override
  List<Object?> get props => [uid, name, email, country, imgUrl];
}