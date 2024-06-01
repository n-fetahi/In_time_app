import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/screens/home_screen.dart';
import 'package:in_time_applcation/screens/icons_pages/driver_settings_page.dart';
import 'package:in_time_applcation/screens/icons_pages/settings_page.dart';
import 'package:in_time_applcation/screens/orders/CustomerOrderListPage.dart';
import 'package:in_time_applcation/screens/orders/DriverOrderListPage.dart';


void empBootomBarSwitch(int index,BuildContext context){

    switch(index){
      case 0: pushNavigator(DriverSettingsPage(), context);break;
      case 1: pushNavigator(DriverOrderListPage(), context);break;

    }
}