import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:yoo_live/Features/data/Repository/AuthDataRepository.dart';

import '../../domain/Model/SearchProfileResponse.dart';

part 'search_profile_event.dart';

part 'search_profile_state.dart';

class SearchProfileBloc extends Bloc<SearchProfileEvent, SearchProfileState> {
  final AuthDataRepository authDataRepository;

  SearchProfileBloc(this.authDataRepository)
    : super(SearchProfileStateInitial()) {
    on<FetchSearchedProfile>(_onFetchSearchedProfile);
  }

  FutureOr<void> _onFetchSearchedProfile(
    FetchSearchedProfile event,
    Emitter<SearchProfileState> emit,
  ) async {
    emit(SearchProfileStateLoading());
    final searchProfile = await authDataRepository.fetchSearchProfile(
      event.query,
    );
    searchProfile.fold(
      (error) => emit(SearchProfileError(error.toString())),
      (searchProfileResponse) => emit(
        SearchProfileStateSuccess(
          searchProfileResponse,
          "Profile Details Fetched Successfully",
        ),
      ),
    );
  }
}
