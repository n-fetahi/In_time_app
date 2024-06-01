import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/TextForm.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/screens/orders/AdminOrderListPage.dart';
import 'package:in_time_applcation/screens/orders/DriverOrderListPage.dart';
import 'package:in_time_applcation/screens/register_screen.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_time_applcation/main.dart';

import 'home_screen.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  TextEditingController _passController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _verificationCodeController = TextEditingController();

  final _formKey=GlobalKey<FormState>();
  CollectionReference users = FirebaseFirestore.instance.collection('Employee');

  bool done=false;
  List<QueryDocumentSnapshot> data=[];

    getData() async{
      data=[];
      QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('Employee').get();
      data.addAll(querySnapshot.docs);
      setState((){

      });

    }
    late SharedPreferences  _preference ;

  Future initShared() async{
      _preference = await SharedPreferences.getInstance();

    }
    @override
    void initState() {
      initShared();
      // TODO: implement initState
      getData();
      super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(

          backgroundColor: primaryColor,
          title: Center(
            child:   Text("تسجيل الدخول",
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
        body: Form(
          key: _formKey,
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/5.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  IntlPhoneField(
                    controller: _phoneController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      fillColor: Color(0x99BABABD),
                      filled: true,
                      labelText: "رقم الهاتف",
                      labelStyle: const TextStyle(

                        fontSize: 15,
                        color: Color(0xB6061C1C),
                        fontFamily: 'Cairo',
                      ),
                      errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27),
                          borderSide:  BorderSide(
                              width:0,
                              color: Color(0xB6061C1C)
                          )
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(27),
                          borderSide:BorderSide(
                            width: 0,
                            color: Color(0xB6061C1C),

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
                    initialCountryCode: 'SA',
                    onChanged: (phone) {
                    },
                  ),
                  SizedBox(height: 26.0),

                  TextForm(
                    obscureText:  true,
                    myKey: TextInputType.number,
                    controller: _passController,
                    lableText: 'كلمة السر',
                    validation: (value){
                      return "";
                    },
                    press: (value){

                    },
                  ),
                  SizedBox(height: 36.0),
                  PrimaryButton(

                    primaryColor,
                      Colors.white,
                      'دخول',
                    12,
                    100,15, () {
                    int f=0;

                    if(_phoneController.text.toString() =="" || _passController.text.toString() == ""){

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

                    else{

                      data.forEach((item) {
                        if(item["phone"].toString() == _phoneController.text.toString()
                            && item["password"].toString() == _passController.text.toString() && item["isEnabled"] == 1){
                          f=1;
                          _preference.setStringList("EmployeeID", [
                            item.id.toString(),
                            item["isAdmin"].toString()
                          ]);
                          _preference.setBool("loginEm",  true);
                          item["isAdmin"].toString() == "1"?
                          pushNavigator(AdminOrderListPage(),context)
                              :pushNavigator(DriverOrderListPage(),context);

                        }

                      });

                      if(f == 0){
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: Colors.redAccent,
                          content:  Text("رقم الهاتف أو كلمة المرور غير صحيحة",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontFamily: 'Cairo',
                            ),
                          ),
                        ));
                      }
                    }


                    },

                   context),
                ],
              ),
            ),
          ),
        ),
      );
  }
}