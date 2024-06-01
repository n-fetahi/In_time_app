import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/AdminBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/BottomBarSwitch.dart';
import 'package:in_time_applcation/constant/EmpBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/SizeConfig.dart';
import 'package:in_time_applcation/constant/adminBottomBarSwitch.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/constant/myBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/myTextButton.dart';
import 'package:in_time_applcation/constant/section.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/employeeShortCut.dart';

import 'package:in_time_applcation/constant/initShared.dart';



class AdminOrdersDetailsPage extends StatefulWidget {
  const AdminOrdersDetailsPage({Key? key, required this.document}) : super(key: key);
  final document;
  @override
  State<AdminOrdersDetailsPage> createState() => _AdminOrdersDetailsPageState();
}

class _AdminOrdersDetailsPageState extends State<AdminOrdersDetailsPage> {
  List<QueryDocumentSnapshot> employees = [];
  int index=0;
  bool f=false;

  getData() async{
    employees=[];
    QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('Employee').get();
    employees.addAll(querySnapshot.docs);
    setState((){

    });




    for(int i=0;i<employees.length;i++){
      if(employees[i].id.toString() == widget.document.data()!['employee']){
        index=i;
        f=true;
      }


    }

  }
  @override
  void initState() {
    getData();
    // initShared();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);
    // print(emp);
    Map<String, dynamic> data =widget.document.data()!;

    return Scaffold(
      appBar: myAppBar("تفاصيل الطلب",context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: f==true? Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [


                  section('مصدر الطلب ',data['source'],15,15),
                  section('الوجهة المطلوبة',data['destination'],15,15),
                  section('حالة الطلب ',
                      data['state_order'] == "0" ? "قيد الإنتظار"
                      : data['state_order'] == "1" ? "قيد التنفيذ"
                      : data['state_order'] == "2" ? "مكتمل"
                      :  "ملغي"
                      ,15,15),
                  section('تاريخ الطلب ',data['date'],15,15),
                  section('التكلفة',"${data['price']} RY",15,15),


                  section('طريقة الدفع',data['payment_method'],15,15),


                  section('إسم السائق',employees[index]['name'].toString(),15,15),

                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PrimaryButton(
                          Colors.white,
                          primaryColor,
                          'عودة للصفحة السابقة',
                          15,
                          30, 12,() {
                        popNavigator(context);

                      }, context),
                    ],
                  ),
                ],
              ),

            ],
          ):Container(
          height:  SizeOfConfig.heightScreen-150,
          child: Center(
              child: CircularProgressIndicator(
                backgroundColor: primaryColor,
              )),
        ),


      ),
      bottomNavigationBar: adminBottomNavigationBar(2,(index){
        adminBootomBarSwitch(index,context);

      },context)
    );
  }



}


