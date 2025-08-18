part of 'auth_profile_bloc.dart';


abstract class AuthProfileEvent extends Equatable{
  const AuthProfileEvent();

  @override
  List<Object> get props => [];
}

class FetchAuthProfileDetails extends AuthProfileEvent{}
