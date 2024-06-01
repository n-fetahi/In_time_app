import 'package:flutter/material.dart';

class IntroPage2 extends StatelessWidget {
  const IntroPage2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],

      body:SingleChildScrollView (
            child: Form(
              child: Column(

                children: [
                  Image.asset('assets/images/2.png'),


                ],
              ),
            )
        ),

    );

  }
}