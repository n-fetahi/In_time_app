import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

SharedPreferences ? _preference ;
List emp=[];

Future initShared() async{
  _preference = await SharedPreferences.getInstance();
}



void getItem(){
  emp=[];
  emp.addAll(_preference!.getStringList("Employee")!.toList());
}


logout() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
}
