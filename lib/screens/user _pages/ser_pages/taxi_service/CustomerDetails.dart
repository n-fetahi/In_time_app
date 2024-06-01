import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/SizeConfig.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/constant/myIconButton.dart';
import 'package:in_time_applcation/constant/myTextButton.dart';
import 'package:in_time_applcation/constant/section.dart';

import '../chat_page.dart';



class CustomerDetails extends StatefulWidget {
  const CustomerDetails({Key? key,required this.name,required this.car_num,required this.phone}) : super(key: key);
  final String name;
  final String car_num;
  final String phone;

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {


  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);

    return Scaffold(
      appBar: myAppBar("بيانات السائق",context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),

                const  CircleAvatar(
                  backgroundColor: primaryColor,
                  radius: 75,
                  backgroundImage: AssetImage('assets/man.png'),
                ),
                SizedBox(height: 40,),

                section('الأسم : ',widget.name,19,17),

                section('رقم السيارة : ',widget.car_num,19,17),

                SizedBox(height: 20,),
                Text("وسيلة التواصل : ",style: titleStyle(19, primaryColor),),
                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    myIconButton(Icons.message,Colors.orange,50,(){}),
                    myIconButton(Icons.call,Colors.green,50,(){}),


                  ],
                ),
                SizedBox(height: 70,),

                PrimaryButton(
                    Colors.white,
                    primaryColor,
                    'عودة للصفحة السابقة',
                    15,
                    30, 12,() {
                  popNavigator(context);

                }, context)
              ],
            )
          ],
        ),

      ),
    );
  }


}


