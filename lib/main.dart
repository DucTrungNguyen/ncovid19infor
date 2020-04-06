import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncov19infor/repositories/repositories.dart';
import 'package:ncov19infor/screens/activities.dart';
import 'package:ncov19infor/simple_bloc_delegate.dart';
import 'package:ncov19infor/blocs/blocs.dart';


void main()  async{

  final ApiRepositories apiRepository = ApiRepositories(apiClient: ApiClient());
  BlocSupervisor.delegate = SimpleBlocDelegate();

  runApp(
    MultiBlocProvider(providers: [
      BlocProvider<GeneralBloc>(
        create: (context) => GeneralBloc(apiRepositories:  apiRepository),
      ),
      BlocProvider<CountryStatBloc>(
        create: (context) => CountryStatBloc(apiRepositories:  apiRepository),
      )
    ],
      child: MyApp(apiRepositories:  apiRepository,),
    ),

  );
}

class MyApp extends StatelessWidget {

  final ApiRepositories apiRepositories;

  const MyApp({Key key, @required this.apiRepositories}) : assert ( apiRepositories != null);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GeneralBloc,GeneralState >(
      builder: (BuildContext context, GeneralState state){

        return MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:HomeActivity()
//            home:BlocProvider(
//              create: (context) =>GeneralBloc(apiRepositories:  apiRepositories),
//              child: HomeActivity(),
//            )
        );
      }
      );
  }
}

