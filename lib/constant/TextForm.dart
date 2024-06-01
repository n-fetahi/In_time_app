import 'package:in_time_applcation/constant/SizeConfig.dart';
import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/constant.dart';


class TextForm extends StatelessWidget {
  TextForm({Key? key, this.lableText, this.myKey, required this.obscureText,
  this.icon, this.controller, this.validation, this.press, this.hint,  this.error}) : super(key: key);

  final String ?lableText;
  final TextInputType ?myKey;
  late final bool obscureText;
  final IconData ?icon;
  final TextEditingController ?controller;
  final Function ?validation;
  final Function ?press;
  final String ?hint;
  final bool ?error;

  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);
    return Container(
      // height: getheightScreen(57),
      child: TextFormField(

        cursorColor: primaryColor,
        keyboardType: myKey,
        validator: validation as String ? Function(String?),
        onChanged: press as void  Function(String?),
        controller: controller,
        obscureText: obscureText,
        style: const TextStyle(
          height: 1.4,
          fontSize: 16,
            fontFamily: 'Cairo',

            color: Color(0xB6061C1C)
        ),
        decoration: InputDecoration(
          fillColor: Color(0x99BABABD),
          filled: true,
          hintText: hint,
          labelText: lableText,
          labelStyle: const TextStyle(

            fontSize: 15,
            color: Color(0xB6061C1C),
            fontFamily: 'Cairo',
          ),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(27),
                borderSide:  BorderSide(
                    width: error==true? 2:0,
                    color: error==true? Color(0xFFFF0000):Color(0xB6061C1C)
                )
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(27),
                borderSide:BorderSide(
                    width: error==true? 2:0,
                    color: error==true? Color(0xFFFF0000):Color(0xB6061C1C),

                )
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(27),
              borderSide: const BorderSide(
                width: 2,
                color:primaryColor
              )
            ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(27),
          borderSide: const BorderSide(
              width: 0,
          )

      ),

        ),
      ),
    );
  }
}
