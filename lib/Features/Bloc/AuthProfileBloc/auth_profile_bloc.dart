import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';
import 'package:yoo_live/Features/domain/Model/AuthProfile.dart';

import '../../../Constants/ApiConstants.dart';
import '../../../Core/Error/Failure.dart';

part 'auth_profile_event.dart';
part 'auth_profile_state.dart';

class AuthProfileBloc extends Bloc<AuthProfileEvent, AuthProfileState> {
  final AuthDataRepository authDataRepository;
  final SharedPreferences sharedPreferences;
  AuthProfileBloc(this.authDataRepository,this.sharedPreferences) : super(AuthProfileStateInitial()) {
    on<FetchAuthProfileDetails>(_onFetchAuthProfileDetails);
    on<LogOutUser>(_onLogout);
  }

  FutureOr<void> _onFetchAuthProfileDetails(FetchAuthProfileDetails event, Emitter<AuthProfileState> emit) async{
    emit(AuthProfileStateLoading());
    final profileDetails = await authDataRepository.fetchProfileDetails();
    profileDetails.fold(
      (error) => emit(AuthProfileError(error.toString())),
      (authProfile) => emit(AuthProfileStateSuccess(authProfile, "Profile Details Fetched Successfully")),
    );
  }

  Future<void> _onLogout(LogOutUser event, Emitter<AuthProfileState> emit) async{
    emit(AuthProfileStateLoading());
    try {
      await Future.wait([
        sharedPreferences.remove(ApiConstants.accessTokenKey),
        sharedPreferences.remove(ApiConstants.refreshTokenKey),
        sharedPreferences.remove(ApiConstants.userDataKey),
        sharedPreferences.remove(ApiConstants.issuedAtKey),
        sharedPreferences.remove(ApiConstants.UserServerId)
      ]);

      emit(SuccessfullyLogout());

    } catch (e) {
      throw CacheFailure( message:'Failed to clear user data');
    }
  }
}
