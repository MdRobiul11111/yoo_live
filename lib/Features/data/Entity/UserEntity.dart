import 'package:equatable/equatable.dart';

class UserEntity extends Equatable{

  final String UId;
  final String name;
  final String email;
  final String imgUrl;

  const UserEntity(this.UId, this.name, this.email, this.imgUrl);

  @override
  List<Object?> get props => [UId, name, email, imgUrl];


}