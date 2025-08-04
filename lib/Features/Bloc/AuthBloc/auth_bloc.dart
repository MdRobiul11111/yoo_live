import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';

import '../../data/Entity/UserEntity.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthDataRepository authDataRepository;

  AuthBloc(this.authDataRepository) : super(AuthStateInitial()) {
    on<SignInWithGoogleRequested>(_onSignInWithGoogleRequested);
    on<SignInWithFacebookRequested>(_onSignInWithFacebookRequested);
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
}
