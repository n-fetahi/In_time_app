import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/initShared.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/screens/home_screen.dart';
import 'package:in_time_applcation/screens/register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignInPage.dart';
class OptionScreen extends StatefulWidget {
  const OptionScreen({Key? key}) : super(key: key);

  @override
  State<OptionScreen> createState() => _OptionScreenState();
}

class _OptionScreenState extends State<OptionScreen> {
  late SharedPreferences  _preference ;

  Future initShared() async{
    _preference = await SharedPreferences.getInstance();
    bool? emp= _preference.getBool('loginEm') ?? false;
    bool? cust= _preference.getBool('loginCu') ?? false;

    if(cust == true){
      print("cu");
      // pushNavigator(HomePage(),context);
    }

    else if(emp == true){
      // pushNavigator(HomePage(),context);
      print("em");
    }


  }
  @override
  void initState() {
    initShared();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: primaryColor,
        title: Center(
          child:   Text("صفحة الدخول",
            style:TextStyle(
                fontFamily: 'Cairo'
            ) ,),
        ),
        actions: [InkWell(

          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(

                child: Directionality(
                    textDirection: TextDirection.rtl,

                    child: Text("         ",
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

      ),
      body: SafeArea(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/5.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PrimaryButton(
                  primaryColor,
                  Colors.white,
                  'دخول كـمـوظف',
                  15,
                  55, 14,() {

                pushNavigator(SignInPage(),context);

              }, context),
              SizedBox(height: 16.0),
              PrimaryButton(
                  primaryColor,
                  Colors.white,
                  'دخول كمستخدم',
                  15,
                  55, 14,() {
                pushNavigator(RegisterScreen(),context);


              }, context),
            ],
          ),
        ),
      ),
    );
  }
}