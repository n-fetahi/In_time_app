import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/SizeConfig.dart';

class buildTextsField extends StatelessWidget {
  const buildTextsField({Key? key, required this.item}) : super(key: key);

  final Widget item;

  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);

    return Container(
      // height: getheightScreen(50),
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.only(right: 30),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [BoxShadow(
            color: Colors.black.withOpacity(0.5),
            offset: Offset(0,3),
            blurRadius: 7,
          )]

      ),
      child: item,
    );
  }

}