part of 'search_profile_bloc.dart';

abstract class SearchProfileEvent extends Equatable{

   const SearchProfileEvent();

   @override
   List<Object> get props => [];

}


class FetchSearchedProfile extends SearchProfileEvent{
  final String query;

  const FetchSearchedProfile(this.query);

  @override
  List<Object> get props => [query];

}


class ResetSearchPage extends SearchProfileEvent{

  const ResetSearchPage();

  @override
  List<Object> get props => [];
}
