import 'package:flutter/material.dart';

import 'constant.dart';


Widget PrimaryButton (Color buttonColor ,Color textColor,buttonData,
    double height,double width,double fontSize,Function press ,BuildContext context){
  return TextButton(
      style: TextButton.styleFrom(
          backgroundColor:buttonColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
              side: BorderSide(
                  width: 2,
                  color: primaryColor
              )
          ),
          padding: EdgeInsets.symmetric(horizontal: width,vertical: height)
      ),
      onPressed:  press as void Function(),
      child: buttonData is IconData? Icon(buttonData,size: 30,color: textColor,):Text(buttonData,
      style: TextStyle(
        fontSize: fontSize,
          fontWeight: FontWeight.bold,
        color: textColor,
        fontFamily: 'Cairo'
      ),

      )
  );
}
