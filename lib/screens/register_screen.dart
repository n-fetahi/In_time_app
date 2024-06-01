import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/TextForm.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/initShared.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/screens/orders/DriverOrderListPage.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'home_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();

  TextEditingController _verificationCodeController = TextEditingController();
  String _phoneNumber = '';

  final _formKey=GlobalKey<FormState>();
  CollectionReference customer = FirebaseFirestore.instance.collection('Customer');
  late SharedPreferences  _preference ;

  List<QueryDocumentSnapshot> data=[];

  getData() async{
    data=[];
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('Customer').get();
    data.addAll(querySnapshot.docs);
    setState((){

    });

  }

  Future<void> addCustomer() {
    // Call the user's CollectionReference to add a new user
    return customer
        .add({
      'name': _nameController.text,
      "id":"6575647",
      "phone" : _phoneController.text// John Doe
      // 42
    })
        .then((value) { print("Customer Added");
    _preference.setString("customerID", value.id);
    _preference.setBool("login",  true);

    }
    )
        .catchError((error) => print("Failed to add Customer: $error"));
  }

  var added_id;





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
        appBar:  AppBar(

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
                  TextForm(
                    obscureText: false,
                    controller: _nameController,
                    myKey: TextInputType.text,
                    lableText: 'الإسم',
                    validation: (value){
                      return "";
                    },
                    press: (value){

                    },
                  ),
                  SizedBox(height: 36.0),
                  IntlPhoneField(
                    controller: _phoneController,

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
                      _phoneNumber = phone.completeNumber;
                    },
                  ),
                  SizedBox(height: 36.0),
                  PrimaryButton(

                    primaryColor,
                      Colors.white,
                      'دخول',
                    12,
                    100,15, () {
                      bool flage=false;
                      if(_phoneController.text.toString() =="" || _nameController.text.toString() == ""){

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
                              && item["name"].toString() == _nameController.text.toString()){

                            _preference.setString("customerID", item.id.toString());
                            _preference.setBool("loginCu",  true);
                            flage=true;
                          }

                        });

                        if(flage == false){
                          addCustomer();
                        }



                        String name = _nameController.text;
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('رمز التحقق'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    controller: _verificationCodeController,
                                    decoration: InputDecoration(
                                      labelText: 'رمز التحقق',
                                      filled: true,
                                      fillColor: Colors.transparent,
                                    ),
                                  ),
                                  SizedBox(height: 16.0),
                                  ElevatedButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor:primaryColor,
                                    ),
                                    onPressed: () {
                                      String verificationCode =
                                          _verificationCodeController.text;
                                      // هنا يمكنك التحقق من صحة رمز التحقق المدخل
                                      print('رمز التحقق: $verificationCode');
                                      pushNavigator(HomePage(),context);

                                    },
                                    child: const Text('تأكيد',
                                    style: TextStyle(
                                      fontFamily: "Cairo"
                                    ),
                                    ),
                                  ),
                                ],
                              ),
                            );

                          },
                        );
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

// ربط Firestore
// const firestore = firebase.firestore();
//
// // إنشاء معرف للمستند
// const docRef = firestore.collection('collectionName').doc();
//
// // تحديد بيانات المستند
// const data = {
//   // بيانات المستند
//   // ...
// };
//
// // إضافة المستند باستخدام المعرف المخصص
// docRef.set(data)
// .then(() => {
// // الـ ID الخاص بالمستند الجديد
// console.log("Document ID:", docRef.id);
// })
// .catch((error) => {
// console.error("Error adding document:", error);
// });
