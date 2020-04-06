import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ncov19infor/utils/calculate.dart';
import 'package:ncov19infor/models/models.dart';
import 'package:intl/intl.dart';


class DetailCountryCardWidget extends StatelessWidget {

  final Country country;
  final Color colorCard;
  final bool  hasPercent;
  final int currentData;
  final int newData;
  final String title;
  DetailCountryCardWidget({
    this.title,this.country,
    this.colorCard,
    this.hasPercent = true,
    this.newData,
    this.currentData
  });
  final formatter = new NumberFormat("#,###");
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: 70,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(horizontal: 10),
//                                color: Colors.blue,
          decoration: BoxDecoration(
            color: colorCard,
            borderRadius:  BorderRadius.circular(10),

          ),
          child: Row(
            children: <Widget>[
//              Spacer(),

              SizedBox(width: 110,),
              Column(
                children: <Widget>[
                  Text(
                    'Total',
                    style: GoogleFonts.cabin(
                        textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500
                        )
                    ),
                  ),
                  SizedBox(height: 5,),
                  Text(
                    '${formatter.format(currentData)}',
                    style: GoogleFonts.cabin(
                        textStyle: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        )
                    ),
                  )

                ],
              ),
//              SizedBox(width: 30,),
            Spacer(),
              Visibility(
                visible: hasPercent,
                child: Column(
                  children: <Widget>[
                    Text(
                      'New',
                      style: GoogleFonts.cabin(
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          )
                      ),
                    ),
                    SizedBox(height: 5,),
                    Text(
                      '${formatter.format(newData)}',
                      style: GoogleFonts.cabin(
                          textStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white
                          )
                      ),
                    ),


                  ],
                ),
              ),
//              SizedBox(width: 30,),
              Spacer(),

              Visibility(
                visible: hasPercent,
                child: Column(
                  children: <Widget>[
                    Text(
                      'Percent',
                      style: GoogleFonts.cabin(
                          textStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500
                          )
                      ),
                    ),
                    SizedBox(height: 5,),
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.arrow_upward,
                          color: Colors.white,
                          size: 17,),
                        Text(
                          '${calcuate(currentData,
                              newData)}%',
                          style: GoogleFonts.cabin(
                              textStyle: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white
                              )
                          ),
                        ),
                      ],
                    ),


                  ],
                ),
              )

            ],

          ),

        ),
        Align(
          alignment: Alignment.topLeft,

          child: Container(
            height: 30,
            width: 110,
            margin: EdgeInsets.only(left: 10),

//            margin: EdgeInsets.all(0),
//            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.cyan.shade100,
                borderRadius: BorderRadius.circular(5)
            ),
            child: RichText(
              text: TextSpan(
                  text: "${title}".toUpperCase(),
                  style: GoogleFonts.cabin(
                      textStyle: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 15

                      )
                  )
              ),
            ),
          ),

        )
      ],
    );
  }
}
