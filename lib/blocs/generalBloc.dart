import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncov19infor/blocs/blocs.dart';
import 'package:ncov19infor/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:ncov19infor/repositories/api_repositories.dart';


// Event
abstract class GeneralEvent  extends Equatable {
  const GeneralEvent();
}

class FetchGeneral extends GeneralEvent {
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class RefreshGeneral extends GeneralEvent{
  @override
  // TODO: implement props
  List<Object> get props => [];
}


// State

abstract class GeneralState extends Equatable {
  const GeneralState();
  @override
  // TODO: implement props
  List<Object> get props => [];
}

class GeneralEmty extends GeneralState{}

class GeneralLoading extends GeneralState{}

class GeneralError extends GeneralState{}

class GeneralLoaded extends GeneralState{
  final Results  currentGeneral;

  GeneralLoaded({@required this.currentGeneral});
  @override
  // TODO: implement props
  List<Object> get props => [currentGeneral];
}


//Bloc

class GeneralBloc extends Bloc<GeneralEvent, GeneralState>{
  final ApiRepositories apiRepositories;

  GeneralBloc({@required this.apiRepositories}) :assert (apiRepositories != null);

  @override
  // TODO: implement initialState
  GeneralState get initialState => GeneralEmty();

  @override
  Stream<GeneralState> mapEventToState(GeneralEvent event) async* {
    try{

      if (event is FetchGeneral){
        yield GeneralLoading();

        final generalData = await apiRepositories.getGeneralData();

        yield GeneralLoaded(currentGeneral: generalData.results[0]);

      } else if (event is RefreshGeneral){
//        yield GeneralLoading();
      print('vao refresh');

        final generalData = await apiRepositories.getGeneralData();

        yield GeneralLoaded(currentGeneral: generalData.results[0]);

      }

    }catch (_){
      yield GeneralError();
    }
  }

}