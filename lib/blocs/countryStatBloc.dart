import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncov19infor/blocs/blocs.dart';
import 'package:ncov19infor/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:ncov19infor/repositories/api_repositories.dart';


// Event Country Stat
abstract class CountryStatEvent  extends Equatable{
  const CountryStatEvent();
}

class FetchCountryStat extends CountryStatEvent {

  @override
  // TODO: implement props
  List<Object> get props => [];
}


class FetchSearchCountryStat extends CountryStatEvent {
  final code;
  FetchSearchCountryStat({this.code});

  @override
  // TODO: implement props
  List<Object> get props => [code];
}


class RefreshListCountryStat  extends CountryStatEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RefreshCountryStat extends CountryStatEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class SearchCountryStat extends CountryStatEvent {

  final Country searchCountry;
  SearchCountryStat({this.searchCountry});

  @override
  // TODO: implement props
  List<Object> get props => [searchCountry];
}

class WatchDetailCountryStat extends CountryStatEvent{
  final Country country;

  WatchDetailCountryStat({this.country});
  @override
  // TODO: implement props
  List<Object> get props => [country];
}



class RefreshWatchDetailCountryStat extends CountryStatEvent{
  final Country country;

  RefreshWatchDetailCountryStat({this.country});
  @override
  // TODO: implement props
  List<Object> get props => [country];
}

// State countrystat

abstract class CountryStatState extends Equatable {
  const CountryStatState();
}

class CountryStatLoading extends CountryStatState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class CountryStatLoaded extends CountryStatState {
  final List<Country> allCountry;
  CountryStatLoaded({this.allCountry});

  @override
  // TODO: implement props
  List<Object> get props => [allCountry];
}

class CountryStatSearchLoaded extends CountryStatState{
  final Country  searchCountry;

  CountryStatSearchLoaded({this.searchCountry});
  @override
  // TODO: implement props
  List<Object> get props => [searchCountry];
}

class CountryStatError extends CountryStatState{
 @override
  // TODO: implement props
  List<Object> get props => [];
}

class CountryStatSearching extends CountryStatState{
  @override
  // TODO: implement props
  List<Object> get props => [];

}

class CountryStatEmty extends CountryStatState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class DetailCountryStat extends CountryStatState{
  final Country country;
  final List<TimeLine> listTimeline;

  DetailCountryStat({this.country, this.listTimeline});
  @override
  // TODO: implement props
  List<Object> get props => [country, listTimeline];

}

class LoadingRefreshWatchDetailCountryStat extends CountryStatState{
  @override
  // TODO: implement props
  List<Object> get props => [];
}



// Bloc Country Stat

class CountryStatBloc extends  Bloc<CountryStatEvent, CountryStatState>{

  final ApiRepositories apiRepositories;

  CountryStatBloc({@required this.apiRepositories}) :assert (apiRepositories != null);

  @override
  // TODO: implement initialState
  CountryStatState get initialState => CountryStatEmty();

  @override
  Stream<CountryStatState> mapEventToState(CountryStatEvent event)  async*{
    if ( event is FetchCountryStat){
      print('vao CountryStatEmty');
      yield CountryStatLoading();

      final AllCountry =  await apiRepositories.getAllCountry();
      print(AllCountry);


      yield CountryStatLoaded(allCountry: AllCountry.countryitems[0].listCountry);

    } else if ( event is RefreshCountryStat){

      final AllCountry =  await apiRepositories.getAllCountry();
      print(AllCountry);

//      var all =AllCountry.countryitems[0].listCountry;
      yield CountryStatLoaded(allCountry: AllCountry.countryitems[0].listCountry);
    } else if ( event is SearchCountryStat){

      print('vao SearchCountryStat');

      yield CountryStatSearchLoaded(searchCountry: event.searchCountry);

    } else if ( event is FetchSearchCountryStat){
      print('vap FetchSearchCountryStat');
      final fetchSearchCountry = await apiRepositories.getCountryStatModel(event.code);

      yield CountryStatSearchLoaded(searchCountry: fetchSearchCountry);

    } else if (event is WatchDetailCountryStat){

      final listTimeLine = await apiRepositories.getCountryTimeline(event.country.code);
      yield DetailCountryStat(country: event.country,  listTimeline :  listTimeLine);

    } else if ( event is RefreshWatchDetailCountryStat){
      print('vao refreswatchdetail');
      yield LoadingRefreshWatchDetailCountryStat();

      final listTimeLine = await apiRepositories.getCountryTimeline(event.country.code);
      yield DetailCountryStat(country: event.country,  listTimeline :  listTimeLine);

    }



  }




}

