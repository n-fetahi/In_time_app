import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/constant.dart';

Widget myTextButton(String title,IconData icon,Function press,BuildContext context) {
  return TextButton(
      onPressed: press as void Function(),
      child:
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon,color: primaryColor,size: 22,),
          SizedBox(width: 5,),

          Text("$title",
            style: TextStyle(
                color: primaryColor,
                fontSize: 16,
                fontFamily: "Cairo"
            ),)
        ],
      )
  );
}