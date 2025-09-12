part of 'auth_profile_bloc.dart';

abstract class AuthProfileState extends Equatable{
  const AuthProfileState();

  @override
  List<Object?> get props => [];
}


class AuthProfileStateInitial extends AuthProfileState{}
class AuthProfileStateLoading extends AuthProfileState{}
class AuthProfileStateSuccess extends AuthProfileState{
  final AuthProfile authProfile;
  final String message;

  const AuthProfileStateSuccess(this.authProfile,this.message);

  @override
  List<Object?> get props => [authProfile,message];
}


class AuthProfileError extends AuthProfileState{
  final String message;

  const AuthProfileError(this.message);

  @override
  List<Object?> get props => [message];
}


class SuccessfullyLogout extends AuthProfileState{
  const SuccessfullyLogout();

  @override
  List<Object?> get props => [];
}
