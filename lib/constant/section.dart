import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/SizeConfig.dart';
import '../constant/constant.dart';

Widget section(String title,String subTitle,double title_size,double subTitle_size) {
  return Column(
    children: [
      Row(

        // crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(title,style: titleStyle(title_size, primaryColor),),
          SizedBox(width: 10,),
          Container(
            margin: EdgeInsets.only(top: 4),
            width: SizeOfConfig.widthScreen/1.7,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  // color: Color(0xFFFFFFFF),

              ),
              // width: double.infinity,
              child: Text(subTitle,style: titleStyle(subTitle_size, Colors.black45),)

          ),
          // Text(subTitle,style: titleStyle(subTitle_size, Colors.black45),),

        ],
      ),
      SizedBox(height: 10,),

    ],
  );
}


TextStyle titleStyle(double fontSize,Color color) {
  return TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      fontFamily: 'Cairo',
      color: color
  );
}