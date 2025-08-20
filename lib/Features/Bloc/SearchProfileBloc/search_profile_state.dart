part of 'search_profile_bloc.dart';

abstract class SearchProfileState extends Equatable{

  const SearchProfileState();

  @override
  List<Object> get props => [];
}

class SearchProfileStateInitial extends SearchProfileState{}
class SearchProfileStateLoading extends SearchProfileState{}
class SearchProfileStateSuccess extends SearchProfileState{
  final SearchProfileResponse searchProfileResponse;
  final String message;

  const SearchProfileStateSuccess(this.searchProfileResponse,this.message);

  @override
  List<Object> get props => [searchProfileResponse,message];
}

class SearchProfileError extends SearchProfileState{
  final String message;

  const SearchProfileError(this.message);

  @override
  List<Object> get props => [message];
}



