import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncov19infor/blocs/blocs.dart';
import 'package:ncov19infor/models/allCountryModel.dart';
import 'package:ncov19infor/utils/WDscreen.dart';
import 'package:ncov19infor/screens/activities.dart';
import 'package:intl/intl.dart';

class CardCountry extends StatefulWidget {

//  final int ourid;
//  final String title;
//  final String code;
//  final String source;
//  final int totalCases;
//  final int totalRecovered;
//  final int totalUnresolved;
//  final int totalDeaths;
//  final int totalNewCasesToday;
//  final int totalNewDeathsToday;
//  final int totalActiveCases;
//  final int totalSeriousCases;
  final Country country;


  CardCountry({this.country});
//  CardCountry(
//      {this.ourid, this.title, this.code, this.source, this.totalCases,
//    this.totalRecovered, this.totalUnresolved, this.totalDeaths, this.totalNewCasesToday,
//    this.totalNewDeathsToday, this.totalActiveCases,this.totalSeriousCases, this.country
//      });
  @override
  _CardCountryState createState() => _CardCountryState();
}

class _CardCountryState extends State<CardCountry> {

  final formatter = new NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryStatBloc, CountryStatState>(
      builder: (context, state){
        return  GestureDetector(
          onTap: (){
            BlocProvider.of<CountryStatBloc>(context)
                .add((WatchDetailCountryStat(country: widget.country)));
//            Future.delayed(const Duration(milliseconds: 400), () {
//              Navigator.push(context, MaterialPageRoute(
//                  builder: (context) {
//
//                    return DetailCountryActivity(countryDetail:  widget.country);
//
//                  }));
//            });
            Navigator.push(context, MaterialPageRoute(
                builder: (context) {

                  return DetailCountryActivity(countryDetail:  widget.country);

                }));

          },
          child: Container(


            child: Column(
//            mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                  width: screenWidth(context),
                  height: 90.0,//screenWidth(context),
                  margin: EdgeInsets.symmetric(horizontal: 25),
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius:  BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.18),
                            blurRadius: 20,
                            spreadRadius: 3.5,
                            offset: Offset(0,13)
                        )
                      ]
                  ),
                  child: Column(
//                crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Container(
//                          height: 40,
                            margin: EdgeInsets.all(0),
                            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 17),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.cyan.shade100,
                                borderRadius: BorderRadius.circular(5)
                            ),
                            child: RichText(
                              text: TextSpan(
                                  text: "${widget.country.title}".toUpperCase(),
                                  style: GoogleFonts.cabin(
                                      textStyle: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold

                                      )
                                  )
                              ),
                            ),
                          ),
//                      Container(
//                        child: IconButton(icon: Icon(Icons.star), padding:EdgeInsets.all(0),alignment: Alignment.topRight,),
//                      )
                        ],
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 5),
                          child: Row(
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    "${formatter.format(widget.country.totalCases)}",
                                    style: GoogleFonts.cabin(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17
                                        )
                                    ),
                                  ),
//                            SizedBox(
//                              height: 5,
//                            ),
                                  Text(
                                    "Cases",
                                    style: GoogleFonts.cabin(
                                        textStyle: TextStyle(
                                            color: Colors.white54,
                                            fontWeight: FontWeight.w300,
                                            fontSize: 17
                                        )
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Text(
                                    "${formatter.format(widget.country.totalDeaths)}",
                                    style: GoogleFonts.cabin(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17
                                        )
                                    ),
                                  ),
//                            SizedBox(height: 10,),
                                  Text(
                                    'Deaths',
                                    style: GoogleFonts.cabin(
                                        textStyle: TextStyle(
                                            color: Colors.white54,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17
                                        )
                                    ),
                                  ),


                                ],
                              ),
                              SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Text(
                                    "${formatter.format(widget.country.totalRecovered)}",
                                    style: GoogleFonts.cabin(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17
                                        )
                                    ),
                                  ),
//                            SizedBox(height: 10,),
                                  Text(
                                    'Recovered',
                                    style: GoogleFonts.cabin(
                                        textStyle: TextStyle(
                                            color: Colors.white54,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17
                                        )
                                    ),
                                  ),


                                ],
                              ),
                              SizedBox(width: 15,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[

                                  Text(
                                    "${formatter.format(widget.country.totalActiveCases)}",
                                    style: GoogleFonts.cabin(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17
                                        )
                                    ),
                                  ),
//                            SizedBox(height: 10,),
                                  Text(
                                    'Active',
                                    style: GoogleFonts.cabin(
                                        textStyle: TextStyle(
                                            color: Colors.white54,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 17
                                        )
                                    ),
                                  ),


                                ],
                              ),
                              Spacer()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10,)

              ],
            ),
          ),
        );
      },
    );
  }
}


