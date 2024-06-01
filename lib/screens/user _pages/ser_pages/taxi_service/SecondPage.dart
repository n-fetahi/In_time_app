import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/SizeConfig.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/initShared.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/constant/section.dart';
import 'package:in_time_applcation/screens/orders/CustomerOrderListPage.dart';
import 'package:in_time_applcation/screens/user%20_pages/ser_pages/taxi_service/CustomerDetails.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constant/employeeShortCut.dart';

import 'dart:async';
import 'dart:math';

class SecondPage extends StatefulWidget {
  const SecondPage({Key? key,required this.source,required this.destination,required this.details}) : super(key: key);
  final String source;
  final String destination;
  final String details;
  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {

    String pyment="كاش";
  List<QueryDocumentSnapshot> employees=[];
  bool getComplate=false;
    late SharedPreferences  _preference ;
    int index=0;

  getData() async{
    employees=[];
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('Employee')
        .where('isAdmin', isEqualTo: 0)
        .where('isEnabled', isEqualTo: 1)
        .get();
    employees.addAll(querySnapshot.docs);
    setState((){

    });
    index=generateRandomNumber(0,employees.length-1);
    print(employees.length);
    getComplate=true;

  }

    CollectionReference orders = FirebaseFirestore.instance.collection('Order');



      int minRange = 10; // الحد الأدنى للنطاق
      int maxRange = 30; // الحد الأقصى للنطاق

      // توليد رقم عشوائي في النطاق المحدد
    int randomNumber =0;
    int randomEmp =0;


    int generateRandomNumber(int min, int max) {
      Random random = Random();
      return min + random.nextInt(max - min + 1);
    }

    Future<void> addOrder() {
      String dateNow = DateFormat('yyyy-MM-dd (HH:mm)').format(DateTime.now());

      // Call the user's CollectionReference to add a new user
      return orders
          .add({
        "employee":employees[index].id,
        "customer":_preference.getString("customerID"),
        'source': widget.source,
        "destination" : widget.destination,
        "date" : dateNow,
        "price" : '2000',
        "state_order":"0",
        "state_pyment" : pyment == "كاش" ? "0" : "1",
        "payment_method" : pyment,// John Doe
        "time" : randomNumber,
        "details":widget.details
     // John Doe
        // 42
      })
          .then((value) => print("Employee Added"))
          .catchError((error) => print("Failed to add Employee: $error"));
    }


    Random random = Random();

    Future initShared() async{
      _preference = await SharedPreferences.getInstance();

    }

    @override
  void initState() {
     getComplate=false;
     initShared();
     randomNumber=generateRandomNumber(minRange,maxRange);

     // TODO: implement initState
    super.initState();
    getData();

    }



  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);

    return Scaffold(
      appBar: myAppBar("طلب تاكسي",context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: getComplate == false?Container(
          height:  SizeOfConfig.heightScreen-100,
          child: Center(
              child: CircularProgressIndicator(
            backgroundColor: primaryColor,
          )),
        ): Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  section(' التكلفة : ','2000 ريال',18,17),
                  section(' زمن الوصول : ','$randomNumber:00 دقيقة',18,17),
                  SizedBox(height: 30,),
                  Text("بيانات السائق : ",style: titleStyle(18, primaryColor),),
                  SizedBox(height: 10,),

                  employeeShortCut(employees[index]['name'],
                      PrimaryButton(
                          Colors.white,
                          primaryColor,
                          'عرض',
                          10,
                          15,12,() {

                        pushNavigator(CustomerDetails(
                          car_num: employees[index]["car_number"].toString(),
                          name: employees[index]['name'].toString(),
                          phone: employees[index]['phone'].toString(),

                        ),context);

                      }, context),context),
                  SizedBox(height: 60,),

                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                PrimaryButton(
                    primaryColor,
                    Colors.white,
                    'التالي',
                    15,
                    55, 14,() {

                  showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(

                        padding: EdgeInsets.all(20.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text("أضف طريقة دفع",style: titleStyle(18, primaryColor),),


                            SizedBox(height: 20.0),
                            buymentButton(Colors.black,Colors.white,"كـــــاش",(){
                               pyment="كاش";
                               addOrder();
                              _showDeleteConfirmationDialog(context);
                              // Navigator.of(context).pop();

                            },context),
                            buymentButton(Colors.deepPurple,Colors.white,"الكـــــريمي",(){
                               pyment="الكريمي";
                               addOrder();
                               _showDeleteConfirmationDialog(context);


                            },context),
                            buymentButton(Colors.orange,Colors.white,"ون كاش",(){
                               pyment="ون كاش";
                               addOrder();
                               _showDeleteConfirmationDialog(context);

                            },context),
                            buymentButton(Colors.teal[400]!,Colors.white,"البنطاقة البنكية",(){
                               pyment="البنطاقة البنكية";
                               addOrder();
                               _showDeleteConfirmationDialog(context);

                            },context),
                          ],
                        ),
                      );
                    },
                  );
                }, context),
                PrimaryButton(
                    Colors.white,
                    primaryColor,
                    'السابق',
                    15,
                    55, 14,() {
                      popNavigator(context);


                }, context),

              ],
            ),

          ],
        ),

      ),
    );
  }

Widget buymentButton(Color buttonColor ,Color textColor,String text,Function press,BuildContext context){
    return Column(
      children: [
        TextButton(

            style: TextButton.styleFrom(

                backgroundColor:buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: BorderSide(
                        width: 2,
                        color: buttonColor
                    )
                ),

                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5)
            ),
            onPressed:  press as void Function(),
            child: Container(
              width: getWidthScreen(200),
              child:  Center(
                child: Text(text,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                      fontFamily: 'Cairo'
                  ),

                ),
              ),
            )
        ),
        SizedBox(height: 10,)
      ],
    );
}

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('تم الحجز',
                  style:TextStyle(
                      color: Colors.green,
                      fontFamily: "Cairo"
                  )),
              Icon(Icons.check,color: Colors.green,size: 40,)
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('يرجى مراجعة سجل الطلبات لمتابعة تفاصيل طلبك',
                style: TextStyle(
                    fontFamily: "Cairo",
                  fontWeight: FontWeight.bold,
                  fontSize: 15
                ),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(

              child: Text('سجل الطلبات',
                style: TextStyle(
                  color: Colors.orange,
                    fontFamily: "Cairo",
                  fontSize: 14
                ),),
              onPressed: () {
                pushNavigator(CustomerOrderListPage(), context);
              },
            ),
        //     ElevatedButton(
        //       style: TextButton.styleFrom(
        //       backgroundColor:primaryColor,
        //
        // ),
        //
        //       child: Text('موافق',
        //         style: TextStyle(
        //
        //             fontFamily: "Cairo",
        //             fontSize: 14
        //         ),),
        //       onPressed: () {
        //         // Add your delete logic here
        //         Navigator.of(context).pop();
        //       },
        //     ),
          ],
        );
      },
    );
  }
}



// final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('ali').snapshots(includeMetadataChanges: true);
// CollectionReference users = FirebaseFirestore.instance.collection('ali');
// Future<void> addUser() {
//   // Call the user's CollectionReference to add a new user
//   return users
//       .add({
//     'full_name': "noor", // John Doe
//     // 42
//   })
//       .then((value) => print("User Added"))
//       .catchError((error) => print("Failed to add user: $error"));
// }
//
// List<QueryDocumentSnapshot> data=[];
//
// getData() async{
//   data=[];
//   QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('users').get();
//   data.addAll(querySnapshot.docs);
//   setState((){
//
//   });
//
// }
//
// @override
// void initState() {
//   // TODO: implement initState
//   getData();
//   super.initState();
// }

//         StreamBuilder<QuerySnapshot>(
//           stream: _usersStream,
// builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//   if (snapshot.hasError) {
//     return Text('Something went wrong');
//   }
//
//   if (snapshot.connectionState == ConnectionState.waiting) {
//     return Text("Loading");
//   }
//
//  return Container(
//     width: 300,
//     height: 200,
//     child:  ListView(
//  children: snapshot.data!.docs.map((DocumentSnapshot document) {
//     Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
//     return ListTile(
//       title: Text('${data['full_name']} ${document.id}'),
//
//     );
//   }).toList(),
//   )
//   );
//
// }
//         )