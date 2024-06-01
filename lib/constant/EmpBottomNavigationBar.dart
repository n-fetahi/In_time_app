import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

CurvedNavigationBar empBottomNavigationBar(int index,Function press,BuildContext context) {
  return CurvedNavigationBar(
    backgroundColor: Colors.white, // يمكنك تغيير اللون وفقًا لاحتياجاتك
    color: primaryColor,
    items:<Widget> [
  Icon(Icons.settings,color: Colors.white,),
  Icon(Icons.shopping_bag,color: Colors.white,),
  ],
    index: index,
    onTap:  press as void Function(int),
  );
}
