import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView (
          child: Form(
            child: Column(

              children: [
                const SizedBox(height: 20,),
                Image.asset('assets/images/5.png'),


              ],
            ),
          )
      ),
    );

  }
}
