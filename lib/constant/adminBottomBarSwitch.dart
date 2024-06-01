import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/screens/admin_pages/EmployeesListPages.dart';
import 'package:in_time_applcation/screens/home_screen.dart';
import 'package:in_time_applcation/screens/icons_pages/admin_settings_page.dart';
import 'package:in_time_applcation/screens/orders/AdminOrderListPage.dart';
import 'package:in_time_applcation/screens/orders/CustomerOrderListPage.dart';


void adminBootomBarSwitch(int index,BuildContext context){

    switch(index){
      case 0: pushNavigator(EmployeesListPages(), context);break;
      case 1: pushNavigator(AdminSettingsPage(), context);break;
      case 2: pushNavigator(AdminOrderListPage(), context);break;

    }
}