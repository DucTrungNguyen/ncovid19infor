import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:ncov19infor/screens/activities.dart';
import 'package:ncov19infor/theme/light_color.dart';
import 'dart:async';
import 'package:ncov19infor/blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';



class HomeActivity extends StatefulWidget {
  @override
  _HomeActivityState createState() => _HomeActivityState();
}

class _HomeActivityState extends State<HomeActivity> {


  RefreshController _refreshController =
    RefreshController(initialRefresh: false);
  Completer<void> _refreshCompleter;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshCompleter = Completer<void>();
  }

  int selectedIndex = 0;

  PageController _pageController = PageController(
    initialPage: 0,
    keepPage: true
  );

  Widget buildPageView(){
    return PageView(

      controller: _pageController,
      onPageChanged: (index){
        pageChanged(index);
      },
      children: <Widget>[
        GeneralActivity(),
        ListCountryActivity(),
        SettingActivity()

      ],
    );
  }

  void pageChanged(int index){
    setState(() {
      selectedIndex = index;
    });
  }

  void bottomTapped(int index){
    setState(() {
      selectedIndex =index;
      _pageController.animateToPage(index, duration: Duration(milliseconds:  1000),
          curve: Curves.easeInQuad);
    });
  }

  void _onRefresh() async{
    if (selectedIndex == 0){
      await Future.delayed(Duration(milliseconds: 1000));
      BlocProvider.of<GeneralBloc>(context).add(FetchGeneral());
      compete();
//      return _refreshCompleter.future;
    }
//    return _refreshCompleter.future;
  }
  void compete(){
    print('loaded');
    _refreshController.loadComplete();
    print('complete');
    compete();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
//      backgroundColor: Colors.amberAccent,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
//          RaisedButton(
//            onPressed: (){
//              BlocProvider.of<GeneralBloc>(context).add(FetchGeneral());
//              return _refreshCompleter.future;
//            },
//          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              children: <Widget>[
                SizedBox(height: 50),
                Text(
                  'nCovid-19',
                  style: GoogleFonts.cabin(
                    textStyle: TextStyle(
                      fontSize: 22,
                      color: Color(0xff989CAC)
                    )
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Information',
                  style: GoogleFonts.cabin(
                      textStyle: TextStyle(
                          fontSize: 22,
//                          color: Color(0xff989CAC),
                        fontWeight: FontWeight.bold
                      )
                  ),
                )
              ],
            ),

          ),
         SizedBox(height: 4,),
          Expanded(
            child: buildPageView(),
          )
        ],
      ),


      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius:50,
            color: Colors.black.withOpacity(.4))
          ]
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10)
            .add(EdgeInsets.only(top: 5)),
            child: GNav(
              gap:  10,
              activeColor: Colors.white,
              color: Colors.grey[400],
              iconSize: 24,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              duration: Duration(milliseconds: 800),
              tabBackgroundColor: Colors.grey[800],
              tabs: [
                GButton(
                  icon: LineIcons.home,
                  text: 'Home',
                  backgroundColor: CardColors.red,
                ),
                GButton(
                  icon: LineIcons.list_ul,
                  text: 'Detail',
                  backgroundColor: CardColors.blue,
                ),
                GButton(
                  icon: LineIcons.cog ,
                  text: 'Setting',
                  backgroundColor: CardColors.green,
                )
              ],
              selectedIndex: selectedIndex,
              onTabChange: (index){
                print(index);
                setState(() {
                  _pageController.jumpToPage(index);
                });
              },
            ),
          ),
        ),
      ),
    );
  }
}
