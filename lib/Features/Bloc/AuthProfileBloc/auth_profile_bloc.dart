import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';
import 'package:yoo_live/Features/domain/Model/AuthProfile.dart';

part 'auth_profile_event.dart';
part 'auth_profile_state.dart';

class AuthProfileBloc extends Bloc<AuthProfileEvent, AuthProfileState> {
  final AuthDataRepository authDataRepository;
  AuthProfileBloc(this.authDataRepository) : super(AuthProfileStateInitial()) {
    on<FetchAuthProfileDetails>(_onFetchAuthProfileDetails);
  }

  FutureOr<void> _onFetchAuthProfileDetails(FetchAuthProfileDetails event, Emitter<AuthProfileState> emit) async{
    emit(AuthProfileStateLoading());
    final profileDetails = await authDataRepository.fetchProfileDetails();
    profileDetails.fold(
      (error) => emit(AuthProfileError(error.toString())),
      (authProfile) => emit(AuthProfileStateSuccess(authProfile, "Profile Details Fetched Successfully")),
    );
  }
}
