import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ncov19infor/blocs/blocs.dart';
import 'package:ncov19infor/models/models.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ncov19infor/widgets/countryCardWIdget.dart';
import 'package:ncov19infor/widgets/searchSortWidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:search_widget/search_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:responsive_screen/responsive_screen.dart';

class ListCountryActivity extends StatefulWidget {
  @override
  _ListCountryActivityState createState() => _ListCountryActivityState();
}

class _ListCountryActivityState extends State<ListCountryActivity> {
  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  @override
  void didChangeDependencies() {
    BlocProvider.of<CountryStatBloc>(context).add(FetchCountryStat());
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    final Function wp = Screen(context).wp;
    final Function hp = Screen(context).hp;

    return SafeArea(
      child: BlocConsumer<CountryStatBloc, CountryStatState>(
        listener: (context, state){
          if ( state is CountryStatLoaded || state is CountryStatSearchLoaded){
            _refreshController.refreshCompleted();
          }
        },
        builder: (context, state){

         if ( state is CountryStatLoading){
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
         if (state is CountryStatLoaded){
           print('all country loaded');
           final listAllCountry = state.allCountry;
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SearchSortWidget(),
                SizedBox(height: 15,),

                Container(
                  child: Flexible(
                    child: SmartRefresher(
                        onRefresh: (){
                          BlocProvider.of<CountryStatBloc>(context).add(FetchCountryStat());
//                return _refreshCompleter.future;
                        },
                      controller: _refreshController,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
//                          shrinkWrap: true,
                          itemCount: listAllCountry.length,
                          itemBuilder: (context, index){
                            return CardCountry(
                              country: listAllCountry[index],
                            );


                          })
//                  child: SingleChildScrollView(
//                    child: Flexible(
//                      child: ListView.builder(
//                          itemCount: listAllCountry.length,
//                          itemBuilder: (context, index){
//                            return
//                          }),
//                    ),
//                  ),
                    ),
                  ),
                )



              ],
           );

         }

         if (state is CountryStatSearchLoaded){
           print('vao state CountryStatSearchLoaded');
           final searchCountry = state.searchCountry;
           return Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: <Widget>[
               SearchSortWidget(),
               SizedBox(height: 15,),

               Container(
                 child: Flexible(
                   child: SmartRefresher(
                       onRefresh: (){
                         print('vao FetchSearchCountryStat');
                         BlocProvider.of<CountryStatBloc>(context).add(FetchSearchCountryStat(code: searchCountry.code));
                         },
                       controller: _refreshController,
                       child:CardCountry(
                         country: searchCountry,
                       )

                   ),
                 ),
               )



             ],
           );
         }
         if ( state is CountryStatError){
           return Container(
             child: SmartRefresher(
               controller: _refreshController,
               onRefresh: (){
//                 BlocProvider.of<GeneralBloc>(context).add(FetchGeneral());
//                 return _refreshCompleter.future;
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
         return Center(
             child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
               children: <Widget>[
                 CircularProgressIndicator(),
                 SizedBox(height: 10,),
                 Text('Loading Detail Country...')
               ],
             )
         );
       },
     ),
   );
  }
}
