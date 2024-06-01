import 'package:flutter/material.dart';


Widget myIconButton(IconData icon,Color color, double size,Function press) {
  return Container(
    height: size,
    width: size,
    decoration: BoxDecoration(
      color: color, // لون الخلفية
      borderRadius: BorderRadius.circular(60.0), // حواف مدورة
    ),
    child: IconButton(onPressed: press as void Function(),

        icon: Icon(icon,size: size/2,color: Colors.white,)
    ),
  );
}