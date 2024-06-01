import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/SizeConfig.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/screens/user%20_pages/ser_pages/taxi_service/SecondPage.dart';
import '../../../../constant/Navigator_Event.dart';
import '../chat_page.dart';



class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TextEditingController _detController = TextEditingController();

  String source_value='موقعك الحالي';
  String destination_value='وجهتك المطلوبة';
  bool source_isChange=false;
  bool destination_isChange=false;


  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);

    return Scaffold(
      appBar:myAppBar("طلب تاكسي",context),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [

            buildTextsField(item:
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                width: double.infinity,
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(20),
                  underline: SizedBox(),
                  hint: Container(
                    padding: EdgeInsets.only(left: 20),
                    width: getWidthScreen(240),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_drop_down_sharp,size: 30,color: primaryColor,),

                        Text(
                          '$source_value',
                          style: alarmTextStyle(source_isChange),
                        ),
                      ],
                    ),
                  ),
                  icon: SizedBox(),


                  items: [' سيتي مارت','الزبيري','هائل','حدة','الأصبحي'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {
                    setState((){
                      source_isChange=true;
                      source_value=_.toString();
                    });
                  },
                ),
              ),
            ),
            ),
            buildTextsField(item:
            Directionality(
              textDirection: TextDirection.ltr,
              child: Container(
                width: double.infinity,
                child: DropdownButton<String>(
                  borderRadius: BorderRadius.circular(20),
                  underline: SizedBox(),
                  hint: Container(
                    padding: EdgeInsets.only(left: 20),
                    width: getWidthScreen(240),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.arrow_drop_down_sharp,size: 30,color: primaryColor,),

                        Text(
                          '$destination_value',
                          style: alarmTextStyle(destination_isChange),
                        ),
                      ],
                    ),
                  ),
                  icon: SizedBox(),


                  items: <String>[' سيتي مارت','الزبيري','هائل','حدة','الأصبحي'].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (_) {
                    setState((){
                      destination_isChange=true;
                      destination_value=_.toString();
                    });
                  },
                ),
              ),
            ),
            ),

            buildTextsField(item:Directionality(
              textDirection: TextDirection.rtl,
              child:   TextFormField(
                controller: _detController,
                cursorColor: primaryColor,
                style: alarmTextStyle(true),
                maxLines: 7,

                decoration: InputDecoration(

                  border: InputBorder.none,
                  hintText: 'تفاصيل (اختياري) ',
                  hintStyle: alarmTextStyle(false),
                ),
                onTap: (){},
              ),

            )),
            SizedBox(height: 20,),
            PrimaryButton(
                primaryColor,
                Colors.white,
               'التالي',
                15,
                55,14, () {
                  if(destination_value != 'وجهتك المطلوبة' && source_value != 'موقعك الحالي'){
                    pushNavigator(SecondPage(destination: destination_value,
                      source: source_value,details: _detController.text.toString(),),context);
                  }

                  else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      backgroundColor: Colors.redAccent,
                      content:  Text('رجاءً قم بملء جميع الحقول',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Cairo',
                        ),
                      ),
                    ));
                  }



            }, context)
          ],
        ),
      ),
    );
  }
  Widget detailsTextField() {
    return TextFormField(
      cursorColor: primaryColor,
      style: alarmTextStyle(true),
      maxLines: 7,

      decoration: InputDecoration(

        border: InputBorder.none,
        hintText: 'تفاصيل ... ',
        hintStyle: alarmTextStyle(false),
      ),
      onTap: (){},
    );
  }
  TextStyle alarmTextStyle(bool isChange) {
    return TextStyle(
        fontFamily: 'Cairo',
        fontSize: 14,
        color: isChange==true?Colors.black: Colors.black38,
        fontWeight: FontWeight.bold
    );
  }
}

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



// Image.asset(
//   'assets/images/Ser1.png',
//   height: 200,
//   width: double.infinity,
//   fit: BoxFit.cover,
// ),
// DropdownButtonFormField<String>(
//   value: selectedOption1,
//   onChanged: (newValue) {
//     setState(() {
//       selectedOption1 = newValue;
//     });
//   },
//   items: const [
//     DropdownMenuItem(
//       value: ' سيتي مارت',
//       child: Text('سيتي مارت'),
//     ),
//     DropdownMenuItem(
//       value: 'الزبيري',
//       child: Text(' الزبيري'),
//     ),
//     DropdownMenuItem(
//       value: ' حدة',
//       child: Text('حدة '),
//     ),
//     DropdownMenuItem(
//       value: ' هائل',
//       child: Text('هائل '),
//     ),
//     DropdownMenuItem(
//       value: ' الحصبة',
//       child: Text('الحصبة '),
//     ),
//     DropdownMenuItem(
//       value: ' الأصبحي',
//       child: Text('الأصبحي '),
//     ),
//   ],
//   decoration: const InputDecoration(
//     labelText: '  موقعك',
//     border: OutlineInputBorder(),
//   ),
// ),
// DropdownButtonFormField<String>(
//   value: selectedOption2,
//   onChanged: (newValue) {
//     setState(() {
//       selectedOption2 = newValue;
//     });
//   },
//   items: const [
//     DropdownMenuItem(
//       value: ' سيتي مارت',
//       child: Text('سيتي مارت'),
//     ),
//     DropdownMenuItem(
//       value: 'الزبيري',
//       child: Text(' الزبيري'),
//     ),
//     DropdownMenuItem(
//       value: ' حدة',
//       child: Text('حدة '),
//     ),
//     DropdownMenuItem(
//       value: ' هائل',
//       child: Text('هائل '),
//     ),
//     DropdownMenuItem(
//       value: ' الحصبة',
//       child: Text('الحصبة '),
//     ),
//     DropdownMenuItem(
//       value: ' الأصبحي',
//       child: Text('الأصبحي '),
//     ),
//   ],
//   decoration: const InputDecoration(
//     labelText: 'وجهتك  ',
//     border: OutlineInputBorder(),
//   ),
// ),
// TextField(
//   controller: textEditingController,
//   decoration: const InputDecoration(
//     labelText: 'أدخل نصًا',
//     border: OutlineInputBorder(),
//   ),
// ),

// ElevatedButton(
//   onPressed: () => selectDate(context),
//   child: const Text('احجز في وقت لاحق'),
// ),
// IconButton(
//   onPressed: () {
//     Navigator.push(
//       context,
//       MaterialPageRoute(builder: (context) => ChatPage()),
//     );
//   },
//   icon: const Icon(Icons.chat),
//   tooltip: 'فتح الدردشة',
// ),