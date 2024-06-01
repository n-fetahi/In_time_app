
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
import 'package:in_time_applcation/constant/initShared.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
// import 'package:in_time_applcation/constant/initShared.dart';
import 'package:in_time_applcation/constant/orderSection.dart';
import 'package:in_time_applcation/screens/SignInPage.dart';
import 'package:in_time_applcation/screens/option_screen.dart';
import 'package:in_time_applcation/screens/orders/AdminOrdersDetailsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constant/lists.dart';
import '../../constant/section.dart';
import 'package:in_time_applcation/main.dart' as main;
class AdminOrderListPage extends StatefulWidget {
  const AdminOrderListPage({Key? key}) : super(key: key);

  @override
  State<AdminOrderListPage> createState() => _AdminOrderListPageState();
}

class _AdminOrderListPageState extends State<AdminOrderListPage> {

  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Order').snapshots(includeMetadataChanges: true);


  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);
    // getItem();
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
                                return  Card(
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
                                          pushNavigator(AdminOrdersDetailsPage(document: document,),context);



                                        }, context)
                                      ],
                                    ),
                                  ),
                                );
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
      bottomNavigationBar:adminBottomNavigationBar(2,(index){
        adminBootomBarSwitch(index,context);

      },context),

    );
  }



}


