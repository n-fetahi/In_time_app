import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/initShared.dart';
import 'package:in_time_applcation/screens/option_screen.dart';


AppBar myAppBar(String title,BuildContext context) {
  return AppBar(

    backgroundColor: primaryColor,
    title: Center(
      child:   Text(title,
        style:TextStyle(
            fontFamily: 'Cairo'
        ) ,),
    ),
    actions: [InkWell(
      onTap: (){
        logout();
        pushNavigator(OptionScreen(), context);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Center(

            child: Directionality(
                textDirection: TextDirection.rtl,

                child: Text("خروج",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Cairo",
                      color: Colors.yellowAccent
                  ),
                )
            )),
      ),
    )],

  );
}
