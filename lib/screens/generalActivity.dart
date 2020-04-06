import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncov19infor/blocs/blocs.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:ncov19infor/widgets/widgets.dart';
import 'package:ncov19infor/utils/calculate.dart';

class GeneralActivity extends StatefulWidget {
  @override
  _GeneralActivityState createState() => _GeneralActivityState();
}

class _GeneralActivityState extends State<GeneralActivity> with AutomaticKeepAliveClientMixin {

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  @override
  void didChangeDependencies() {
    BlocProvider.of<GeneralBloc>(context).add(FetchGeneral());
    //do whatever you want with the bloc here.
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return SafeArea(
      //padding: EdgeInsets.only(top: 20),
      child: BlocConsumer<GeneralBloc, GeneralState>(
        listener: (context, state){
          _refreshCompleter?.complete();
          _refreshCompleter = Completer();
          if( state is GeneralLoaded)
            _refreshController.loadComplete();
        },
        builder: (BuildContext context, GeneralState state){
          if ( state is GeneralLoading){
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: hp(9.0),),
                Center(
                  child: Column(
                    children: <Widget>[
                      SpinKitSquareCircle(
                        color: Colors.green,
                        size: 50.0,
                      ),
                      SizedBox( height: 15,),
                      Text('Is loading',
                        style: GoogleFonts.cabin(
                            textStyle: TextStyle(
                                fontSize: 16,
//                          color: Color(0xff989CAC),
                                fontWeight: FontWeight.bold))
                      )
                    ],
                  )
                )
              ],
            );
          }
          if ( state is GeneralLoaded){
            final currentGeneral = state.currentGeneral;
            print( 'so case ${state.currentGeneral.totalCases}');
            return Container(
              //color: Colors.green,
              child: SmartRefresher(
                controller: _refreshController,

                onRefresh: (){
                  BlocProvider.of<GeneralBloc>(context).add(FetchGeneral());
//                return _refreshCompleter.future;
                },
                child: Column(
                  mainAxisSize:  MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 30, right: 20, bottom: 15),
                      child:Text(
                          'The coronavirus COVID-19 is affecting ${currentGeneral.totalAffectedCountries} '
                              'countries and territories',
                        style: GoogleFonts.cabin(
                            textStyle: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontStyle:  FontStyle.italic

                            )
                        ),

                      ),
                    ),

                    GeneralCardWidget(
                      cardTitle: "Total Cases",
                      caseTitle: "Total",
                      currentData: currentGeneral.totalCases,
                      newData: currentGeneral.totalNewCasesToday,
                      cardCorlor: Colors.blueAccent,
                      icon: Icon(Icons.arrow_upward),
                      color: Colors.yellowAccent,
                      percentChange: calcuate(currentGeneral.totalCases, currentGeneral.totalNewCasesToday),
                    ),
                    GeneralCardWidget(
                      cardTitle: "Total Recovered",
                      caseTitle: "Total",
                      currentData: currentGeneral.totalRecovered,
                      //newData: currentGeneral.totalRecovered,
                      cardCorlor: Colors.green,
                      icon: Icon(Icons.arrow_upward),
                      color: Colors.yellowAccent,
                      percentChange: 0,
                      hasPercent: false,
                    ),
                    SizedBox(height: 20,),
                    GeneralCardWidget(
                      cardTitle: "Total Deaths",
                      caseTitle: "Total",
                      currentData: currentGeneral.totalDeaths,
                      newData: currentGeneral.totalNewDeathsToday,
                      cardCorlor: Colors.red,
                      icon: Icon(Icons.arrow_upward),
                      color: Colors.yellowAccent,
                      percentChange: calcuate(currentGeneral.totalDeaths, currentGeneral.totalNewDeathsToday),
                    ),
                    GeneralCardWidget(
                      cardTitle: "Active cases",
                      caseTitle: "Total",
                      currentData: currentGeneral.totalActiveCases,
//                      newData: currentGeneral.totalNewDeathsToday,
                      cardCorlor: Colors.teal,
                      icon: Icon(Icons.arrow_upward),
                      color: Colors.yellowAccent,
                      //percentChange: calcuate(currentGeneral.totalDeaths, currentGeneral.totalNewDeathsToday),
                      hasPercent: false,
                    ),
                    SizedBox(height: 20,),
                    GeneralCardWidget(
                      cardTitle: "serious Cases",
                      caseTitle: "Total",
                      currentData: currentGeneral.totalDeaths,
//                      newData: currentGeneral.totalNewDeathsToday,
                      cardCorlor: Colors.orange,
                      icon: Icon(Icons.arrow_upward),
                      color: Colors.yellowAccent,
//                      percentChange: calcuate(currentGeneral.totalDeaths, currentGeneral.totalNewDeathsToday),
                      hasPercent: false,
                    ),



                    ],

                )
              ),
            );
          }
          if ( state is GeneralError){
            return Container(
              child: SmartRefresher(
                controller: _refreshController,
                onRefresh: (){
                  BlocProvider.of<GeneralBloc>(context).add(FetchGeneral());
                  return _refreshCompleter.future;
                },
                child: Center(
                  child: Text(
                    'Have error, pull to raload',
                    style: GoogleFonts.cabin(
                      textStyle: TextStyle(
                        color: Colors.red
                      )
                    ),
                  ),
                ),
              ),
            );
          }
          return Container(
            child: SmartRefresher(
                controller: _refreshController,
                child: Center(
                  heightFactor: 20,
                  child: Text('Pull to refresh information'),
                ),
                onRefresh: (){
                  print('Have pull');
                  BlocProvider.of<GeneralBloc>(context).add(FetchGeneral());
                  return _refreshCompleter.future;
                }

            ),
          );
        },
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
