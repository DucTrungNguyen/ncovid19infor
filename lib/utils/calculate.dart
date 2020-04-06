
import 'package:flutter/material.dart';
calcuate(int currentData, int newData){
  var percent =( newData / ( currentData - newData)  ) * 100;
  print(percent);
//  var x = percent.isInfinite   ? 0.000 : percent;
  var x = double.parse( percent.toStringAsFixed(2)) ;
  print('Day la x: $x' );
  return x;


}