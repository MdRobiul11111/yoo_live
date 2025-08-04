part of 'auth_bloc.dart';

abstract class AuthState extends Equatable{
  const AuthState();

  @override
  List<Object?> get props => [];
}


class AuthStateInitial extends AuthState{}

class AuthStateLoading extends AuthState{}

class AuthStateSuccess extends AuthState{
  final UserEntity user;
  final String message;

  const AuthStateSuccess(this.user,this.message);

  @override
  List<Object?> get props => [user,message];

}

class AuthError extends AuthState{
  final String message;

  const AuthError(this.message);

  @override
  List<Object?> get props => [message];

}

