import 'package:flutter/material.dart';

class IntroPage1 extends StatelessWidget {
  const IntroPage1 ({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body:SingleChildScrollView (
            child: SafeArea(
              bottom: true,
              child: Form(
                child: Column(

                  children: [

                    Image.asset('assets/images/1.png',



                    ),


                  ],
                ),
              ),
            )
        ),

    );

  }
}