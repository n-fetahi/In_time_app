import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/screens/home_screen.dart';
import 'package:in_time_applcation/screens/icons_pages/settings_page.dart';
import 'package:in_time_applcation/screens/orders/CustomerOrderListPage.dart';


void BootomBarSwitch(int index,BuildContext context){

    switch(index){
      case 0: pushNavigator(HomePage(), context);break;
      case 1: pushNavigator(SettingsPage(), context);break;
      case 2: pushNavigator(CustomerOrderListPage(), context);break;
    }
}