
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/BottomBarSwitch.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/SizeConfig.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/constant/myBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/orderSection.dart';
import 'package:in_time_applcation/screens/orders/CustomerOrdersDetailsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/section.dart';

class CustomerOrderListPage extends StatefulWidget {
  const CustomerOrderListPage({Key? key}) : super(key: key);

  @override
  State<CustomerOrderListPage> createState() => _CustomerOrderListPageState();
}

class _CustomerOrderListPageState extends State<CustomerOrderListPage> {
  final Stream<QuerySnapshot> _usersStream = FirebaseFirestore.instance.collection('Order').snapshots(includeMetadataChanges: true);

  String cust="";
  bool getComplate=false;

  late SharedPreferences  _preference ;
  Future initShared() async{
    _preference = await SharedPreferences.getInstance();
    cust =  _preference.getString("customerID").toString();
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
      bottomNavigationBar: myBottomNavigationBar(2,(index){
        BootomBarSwitch(index,context);

      },context),
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
                      print(cust);

                      return  data['customer'].toString()
                          == cust ?Card(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 25,vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [

                                    // SizedBox(height: getheightScreen(2),),
                                    orderSection('مصدر الطلب : ',data['source'].toString(),12,12),
                                    orderSection('الوجهة المطلوبة : ',data['destination'].toString(),12,12),
                                    orderSection('حالة الطلب : ',
                                        data['state_order'] == "0" ? "قيد الإنتظار"
                                        : data['state_order'] == "1" ? "قيد التنفيذ"
                                        : data['state_order'] == "2" ? "مكتمل"
                                        :  "ملغي"
                                        ,12,12),
                                    data['state_order'] == "0" ?
                                    orderSection('زمن الوصول : ','${data['time'].toString()}:00 ',12,12)
                                        :  orderSection('تاريخ الطلب ',data['date'],12,12),
                                  ],
                                ),
                                PrimaryButton(
                                    Colors.white,
                                    primaryColor,
                                    'عرض',
                                    10,
                                    15,10,() {
                                  pushNavigator(CustomerOrdersDetailsPage(document: document,),context);



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

    );
  }



}

