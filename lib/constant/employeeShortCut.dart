import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/SizeConfig.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/section.dart';

Widget employeeShortCut(String name,Widget tail, BuildContext context) {
  return Container(
    height: getheightScreen(120),
    padding: EdgeInsets.all(10),

    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFFFFFFF),
        boxShadow: [BoxShadow(
          color: Colors.black.withOpacity(0.5),
          offset: Offset(0,3),
          blurRadius: 7,
        )]
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            const  CircleAvatar(
              backgroundColor: primaryColor,
              radius: 35,
              backgroundImage: AssetImage('assets/man.png'),
            ),
            SizedBox(width: 10,),

            Text("$name",style: titleStyle(16, Colors.black45),),

          ],
        ),

        tail
      ],
    ),
  );
}
