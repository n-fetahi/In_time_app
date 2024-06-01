import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:in_time_applcation/constant/initShared.dart';
import 'package:in_time_applcation/screens/SignInPage.dart';
import 'package:in_time_applcation/screens/admin_pages/AddEmployeePages.dart';
import 'package:in_time_applcation/screens/admin_pages/EmployeesListPages.dart';
import 'package:in_time_applcation/screens/onboarding_screen.dart';
import 'package:in_time_applcation/screens/orders/AdminOrderListPage.dart';
import 'package:in_time_applcation/screens/orders/CustomerOrderListPage.dart';
import 'package:in_time_applcation/screens/register_screen.dart';
import 'package:in_time_applcation/screens/user%20_pages/ser_pages/taxi_service/FirstPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/option_screen.dart';
import 'package:in_time_applcation/screens/user%20_pages/ser_pages/taxi_service/SecondPage.dart';
import 'screens/home_screen.dart';

import 'package:in_time_applcation/screens/orders/AdminOrdersDetailsPage.dart';
import 'package:in_time_applcation/screens/orders/DriverOrderListPage.dart';
import 'package:firebase_core/firebase_core.dart';




void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  initShared();
  runApp(const InTime());
}
class InTime extends StatelessWidget {
  const InTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: [
        Locale('ar','AE'),
      ],
      debugShowCheckedModeBanner: false,

      home:OnBoardingScreen()
    );
  }
}

