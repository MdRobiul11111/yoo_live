part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class SignInWithGoogleRequested extends AuthEvent {}
class SignInWithFacebookRequested extends AuthEvent {}
class CheckUserSignedIn extends AuthEvent {}
class AuthNavigation extends AuthEvent{
  final BuildContext context;
  const AuthNavigation(this.context);
}
