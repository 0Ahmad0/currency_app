import 'package:flutter/cupertino.dart';

class AppSizer{
  static double getH(context){
    return MediaQuery.of(context).size.height;
  }
  static double getW(context){
    return MediaQuery.of(context).size.width;
  }
}