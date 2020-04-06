import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncov19infor/models/models.dart';
import 'package:ncov19infor/widgets/widgets.dart';
import 'package:ncov19infor/blocs/blocs.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:responsive_screen/responsive_screen.dart';
import 'package:ncov19infor/utils/WDscreen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncov19infor/utils/calculate.dart';
import 'package:url_launcher/url_launcher.dart';


class DetailCountryActivity extends StatefulWidget {

  final Country countryDetail;
  DetailCountryActivity({this.countryDetail});

  @override
  _DetailCountryActivityState createState() => _DetailCountryActivityState();
}

class _DetailCountryActivityState extends State<DetailCountryActivity> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
//      color: Colors.greenAccent,

        child: BlocConsumer<CountryStatBloc,CountryStatState >(
          listener: (context, state){
            if ( state is DetailCountryStat){
              print('vao if');
              _refreshController.refreshCompleted();
            }

          },

          buildWhen: (context, state){
            if ( state is DetailCountryStat){
              _refreshController.loadComplete();
              return true;

            }
            return false;
          },
          builder: (context, state){

            if ( state is DetailCountryStat){
              print('state is DetailCountryStat');
              return Scaffold(

                body: Column(
                  children: <Widget>[

                    Row(
                      children: <Widget>[
                        Container(
                            alignment: Alignment.centerLeft,
                            width: screenWidth( context),
                            height: 50,
                            color: Colors.cyan,
                            child: Row(
                              children: <Widget>[
                                IconButton(

                                  icon : Icon(Icons.arrow_back),
                                  onPressed: (){
                                    BlocProvider.of<CountryStatBloc>(context).add(FetchCountryStat());
                                    Navigator.pop(context);

                                  },
                                ),
                                Text(
                                  '${widget.countryDetail.title} information',
                                  style: GoogleFonts.cabin(
                                      textStyle: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold
                                      )
                                  ),

                                )
                              ],
                            )
                        ),

                      ],
                    ),
                    Flexible(
                      child: SmartRefresher(
                        controller: _refreshController,
                        onRefresh: (){
                          BlocProvider.of<CountryStatBloc>(context)
                              .add((RefreshWatchDetailCountryStat(country: widget.countryDetail)));


                        },
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              SizedBox(height: 20,),
                              DetailCountryCardWidget(
                                title: 'Cases',
                                country: state.country,
                                colorCard: Colors.blueAccent,
                                newData: state.country.totalNewCasesToday,
                                currentData: state.country.totalCases,
                              ),
                              SizedBox(height: 20,),
                              DetailCountryCardWidget(
                                title: 'Deaths',
                                country: state.country,
                                colorCard: Colors.red,
                                newData: state.country.totalNewDeathsToday,
                                currentData: state.country.totalDeaths,
                              ),
                              SizedBox(height: 20,),
                              DetailCountryCardWidget(
                                title: 'Recovered',
                                country: state.country,
                                colorCard: Colors.green,
                                newData: state.country.totalNewDeathsToday,
                                currentData: state.country.totalRecovered,
                                hasPercent: false,
                              ),
                              SizedBox(height: 20,),

                              DetailCountryCardWidget(
                                title: 'Actives',
                                country: state.country,
                                colorCard: Colors.teal,
                                newData: state.country.totalNewDeathsToday,
                                currentData: state.country.totalDeaths,
                                hasPercent: false,
                              ),
                              SizedBox(height: 20,),
                              DetailCountryCardWidget(
                                title: 'Deaths',
                                country: state.country,
                                colorCard: Colors.orange,
                                newData: state.country.totalNewDeathsToday,
                                currentData: state.country.totalDeaths,
                                hasPercent: false,
                              ),
                              Container(
                                child: PointsLineChart(
                                  listTimeLine: state.listTimeline,
                                  id: 'Cases' ,
                                  colorChart: Colors.blue,
                                  type: 'C',
                                ),

                              ),
                              Text(
                                'Chart Cases',
                                style: GoogleFonts.cabin(
                                  textStyle: TextStyle(
                                    fontSize: 15,
                                    fontStyle: FontStyle.italic
                                  )
                                ) ,
                              ),
                              Container(
                                child: PointsLineChart(
                                  listTimeLine: state.listTimeline,
                                  id: 'Deaths' ,
                                  colorChart: Colors.blue,
                                  type: 'D',
                                ),

                              ),
                              Text(
                                'Chart Deaths',
                                style: GoogleFonts.cabin(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic
                                    )
                                ) ,
                              ),
                              Container(
                                child: PointsLineChart(
                                  listTimeLine: state.listTimeline,
                                  id: 'recovered' ,
                                  colorChart: Colors.blue,
                                  type: 'R',
                                ),

                              ),
                              Text(
                                'Chart Recovered',
                                style: GoogleFonts.cabin(
                                    textStyle: TextStyle(
                                        fontSize: 15,
                                        fontStyle: FontStyle.italic
                                    )
                                ) ,
                              ),
                             SizedBox(
                              height: 20,
                             ),
                              Text(
                                'Source',
                                style: GoogleFonts.cabin(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22
                                  )
                                ),


                              ),
                              InkWell(
                                onTap: () async {
                                  if ( await canLaunch(state.country.source) ){
                                    await launch(
                                      state.country.source,
                                      forceSafariVC: true,
                                      forceWebView: true
                                    );
                                  }
                                },
                                child: Container(
                                  margin: const EdgeInsets.only(left: 0, right: 0, bottom: 10),
//                                  padding: const EdgeInsets.all(20),

//                                width: Screen(context),
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: Colors.cyan.withOpacity(0.3),
                                    borderRadius: BorderRadius.circular(10),
                                    
                                      
                                  ),
                                  child: Text(
                                    'Tap to see more information of ${state.country.title}',
                                    style: GoogleFonts.cabin(
                                      textStyle: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        color: Colors.red,
                                        fontSize:16


                                      )
                                    ),
                                  ),

                                ),
                              )


                            ],
                          ),
                        )
                        
                      ),
                    )
                  ],
                ),
              );
            }
            if ( state is LoadingRefreshWatchDetailCountryStat){
              return Scaffold(
                body: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                        SizedBox(height: 10,),
                        Text('Loading Detail Country...')
                      ],
                    )
                ),
              );
            }
            return Scaffold(
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(),
                    SizedBox(height: 10,),
                    Text('Loading Detail Country...')
                  ],
                )
              ),
            );
          },
        )


    );
  }
}
