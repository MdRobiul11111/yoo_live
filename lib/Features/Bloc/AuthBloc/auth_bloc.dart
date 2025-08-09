import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';
import 'package:yoo_live/Features/domain/DataSource/LocalDataSource.dart';

import '../../data/Entity/UserEntity.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthDataRepository authDataRepository;
  final LocalDataSource localDataSource;

  AuthBloc(this.authDataRepository,this.localDataSource) : super(AuthStateInitial()) {
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
    on<SignInWithFacebookRequested>(_onSignInWithFacebookRequested);
    on<CheckUserSignedIn>(_onCheckUserSignedIn);
  }

  FutureOr<void> _onSignInWithGoogleRequested(
    SignInWithGoogleRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    final result = await authDataRepository.signInWithGoogle();
    result.fold(
      (error) => emit(AuthError(error.toString())),
      (userModel) =>
          emit(AuthStateSuccess(userModel, "Google Sign In Successfully")),
    );
  }

  FutureOr<void> _onSignInWithFacebookRequested(
    SignInWithFacebookRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthStateLoading());
    final result = await authDataRepository.signInWithFaceBook();
    result.fold(
      (error) => emit(AuthError(error.toString())),
      (userModel) =>
          emit(AuthStateSuccess(userModel, "Google Sign In Successfully")),
    );
  }

  FutureOr<void> _onCheckUserSignedIn(CheckUserSignedIn event, Emitter<AuthState> emit) async{
    emit(AuthStateLoading());
    final isSignedIn = await localDataSource.isUserSignedIn();
    if(isSignedIn){
      emit(AuthStateSignIn("User is signed in"));
    }else{
      emit(AuthStateSignedOut("User is not signed in"));
    }
  }
}
