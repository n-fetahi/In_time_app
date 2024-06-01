import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:in_time_applcation/constant/BottomBarSwitch.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/constant/myBottomNavigationBar.dart';

import 'package:in_time_applcation/screens/icons_pages/info_page.dart';
import 'package:in_time_applcation/screens/icons_pages/services_page.dart';
import 'package:in_time_applcation/screens/icons_pages/settings_page.dart';
import 'package:in_time_applcation/screens/orders/CustomerOrderListPage.dart';
import 'package:in_time_applcation/screens/user%20_pages/ser_pages/about_app.dart';
import 'package:in_time_applcation/screens/user%20_pages/ser_pages/bus_service.dart';
import 'package:in_time_applcation/screens/user%20_pages/ser_pages/car_rental_service.dart';
import 'package:in_time_applcation/screens/user%20_pages/ser_pages/mechanical_service.dart';
import 'package:in_time_applcation/screens/user%20_pages/ser_pages/motor_service.dart';
import 'package:in_time_applcation/screens/user%20_pages/ser_pages/taxi_service/FirstPage.dart';



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  myAppBar("الرئيسية",context),
      body: GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.all(16.0),
        children: [
          ServiceItem(
            title: ' طلب تاكسي',
            imagePath: 'assets/images/Ser1.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>FirstPage(),
                ),
              );
            },
          ),
          ServiceItem(
            title: 'طلب حافلة ',
            imagePath: 'assets/images/Ser2.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BusService(),
                ),
              );
            },
          ),
          ServiceItem(
            title: 'طلب دراجة نارية ',
            imagePath: 'assets/images/Ser3.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MotorService(),
                ),
              );
            },
          ),
          ServiceItem(
            title: 'تأجير سيارة ',
            imagePath: 'assets/images/Ser4.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CarRentalPage(),
                ),
              );
            },
          ),
          ServiceItem(
            title: 'طلب ميكانيكي ',
            imagePath: 'assets/images/Ser5.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>  MechSer(),
                ),
              );
            },
          ),
          ServiceItem(
            title: ' عن التطبيق',
            imagePath: 'assets/images/Ser6.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutApp(),
                ),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: myBottomNavigationBar(0,(index){
        BootomBarSwitch(index,context);

      },context),
    );
  }

}
class ServiceItem extends StatelessWidget {
  final String title;
  final String imagePath;
  final VoidCallback onPressed;

  ServiceItem({required this.title, required this.imagePath, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 120,
              height: 120,
            ),
            SizedBox(height: 8.0),
            Text(
              title,
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}