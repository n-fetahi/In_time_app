import 'package:flutter/material.dart';

class SizeOfConfig {
  static late MediaQueryData _mediaQueryData;
  static late double heightScreen;
  static late double widthScreen;
  static double?defultSize;
  //قبلت لانها التدوير ليس اجباري
  static Orientation? _orientation;

  void init (BuildContext context){
    _mediaQueryData =MediaQuery.of(context);
    widthScreen =_mediaQueryData.size.width;
    heightScreen=_mediaQueryData.size.height;
    _orientation=_mediaQueryData.orientation;
  }
}
double getWidthScreen(double inputWidth){
  double widthScreen =SizeOfConfig.widthScreen;
  return (inputWidth / 315.0 )*widthScreen;
}

double getheightScreen(double inputHeight){
  double heightScreen =SizeOfConfig.heightScreen;
  return (inputHeight / 815)*heightScreen;
}




