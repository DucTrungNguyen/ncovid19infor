import 'package:flutter/material.dart';

class SortWidget extends StatefulWidget {

  final String title;
  final bool isChoosed;
  final Icon icon;
  final double width;


  SortWidget({this.title, this.isChoosed, this.icon, this.width});


  @override
  _SortWidgetState createState() => _SortWidgetState();
}

class _SortWidgetState extends State<SortWidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: 23,
      child:RaisedButton(
          shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(18.0),
//              side: BorderSide(color: Colors.red)
          ),

        onPressed: (){

        },
        color: widget.isChoosed ? Colors.green : Colors.lightGreen,
        child: Row(
          children: <Widget>[
            Text(
              '${widget.title}',
            ),
            Icon(widget.icon.icon)
          ],
        ),
      )
    );
  }
}
