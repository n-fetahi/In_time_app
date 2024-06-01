
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:in_time_applcation/constant/EmpBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/SizeConfig.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/empBottomBarSwitch.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';

import 'package:in_time_applcation/constant/orderSection.dart';
import 'package:in_time_applcation/screens/orders/DriverOrdersDetailsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';



class DriverOrderListPage extends StatefulWidget {
  const DriverOrderListPage({Key? key}) : super(key: key);

  @override
  State<DriverOrderListPage> createState() => _DriverOrderListPageState();
}

class _DriverOrderListPageState extends State<DriverOrderListPage> {

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Order').snapshots(includeMetadataChanges: true);
  String? emp;
  bool getComplate=false;

  late SharedPreferences  _preference ;
  Future initShared() async{
    _preference = await SharedPreferences.getInstance();
    emp =  _preference.getStringList("EmployeeID")![0];
  }

  @override
  void initState() {
    initShared();


    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);
    return Scaffold(
      appBar: myAppBar("سجل الطلبات",context),
      body: SafeArea(
        child:SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.only(left: 10,right: 20,top: 20),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  StreamBuilder<QuerySnapshot>(
                      stream: _usersStream,
                      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return Text('Something went wrong');
                        }

                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return Container(
                            height:  SizeOfConfig.heightScreen-150,
                            child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: primaryColor,
                                )),
                          );
                        }

                        return Container(
                            height: SizeOfConfig.heightScreen-100,
                            child:  ListView(
                              children: snapshot.data!.docs.map((DocumentSnapshot document) {

                                Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                // print(emp!);
                                return  data['employee'].toString()
                                    == emp! ?Card(
                                  child: Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [

                                            orderSection('مصدر الطلب : ',data['source'].toString(),13,13),
                                            orderSection(' الوجهة المطلوبة : ',data['destination'].toString(),12,12),
                                            orderSection('حالة الطلب : ',
                                                data['state_order'] == "0" ? "قيد الإنتظار"
                                                    : data['state_order'] == "1" ? "قيد التنفيذ"
                                                    : data['state_order'] == "2" ? "مكتمل"
                                                    :  "ملغي"
                                                ,12,12),
                                          ],
                                        ),
                                        PrimaryButton(
                                            Colors.white,
                                            primaryColor,
                                            'عرض',
                                            10,
                                            15,10,() {
                                          pushNavigator(DriverOrdersDetailsPage(document:  document),context);



                                        }, context)
                                      ],
                                    ),
                                  ),
                                ):SizedBox();
                              }).toList(),
                            )
                        );

                      }
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar:empBottomNavigationBar(1,(index){
        empBootomBarSwitch(index,context);

      },context),

    );
  }




}


