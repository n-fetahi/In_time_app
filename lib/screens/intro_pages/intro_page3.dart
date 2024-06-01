import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/SizeConfig.dart';

class IntroPage3 extends StatelessWidget {
  const IntroPage3({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);
    return  Scaffold(
      backgroundColor: Colors.yellow[200],
      body:SingleChildScrollView (
          child: Form(
            child: Column(

              children: [
                Image.asset('assets/images/3.png',),


              ],
            ),
          )
      ),
    );

  }
}
