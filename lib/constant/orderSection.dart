import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/section.dart';


Widget orderSection(String title,String subTitle,double title_size,double subTitle_size) {
  return Row(

    // crossAxisAlignment: CrossAxisAlignment.start,

    children: [
      SizedBox(height: 20,),

      Text(title,style: titleStyle(title_size, primaryColor),),

      Text(subTitle,style: titleStyle(subTitle_size, Colors.black45),),

    ],
  );
}