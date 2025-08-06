import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  final String name;
  final String email;
  final String address;
  final String country;
  final String imgUrl;

  const UserEntity(this.name, this.email,this.address,this.country,this.imgUrl);

  @override
  List<Object?> get props => [name, email,address,country,imgUrl];


}