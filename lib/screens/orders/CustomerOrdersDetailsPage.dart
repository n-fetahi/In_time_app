import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/BottomBarSwitch.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/SizeConfig.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/constant/myBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/section.dart';
import 'package:in_time_applcation/screens/orders/CustomerOrderListPage.dart';
import 'package:in_time_applcation/screens/user%20_pages/ser_pages/taxi_service/CustomerDetails.dart';
import '../../constant/employeeShortCut.dart';




class CustomerOrdersDetailsPage extends StatefulWidget {
  const CustomerOrdersDetailsPage({Key? key, required this.document}) : super(key: key);
  final document;
  @override
  State<CustomerOrdersDetailsPage> createState() => _CustomerOrdersDetailsPageState();
}

class _CustomerOrdersDetailsPageState extends State<CustomerOrdersDetailsPage> {
  final CollectionReference order = FirebaseFirestore.instance.collection('Order');
  String docID='';
  int index=0;

  cancel(){


    order.doc(docID).update(
        {
          "state_order":"3"
        }

    );
    pushNavigator(CustomerOrderListPage(),context);


  }
  bool f=false;
  List<QueryDocumentSnapshot> employees = [];

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
    docID=widget.document.id;

    getData();
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);
    Map<String, dynamic> data =widget.document.data()!;

    return Scaffold(
      appBar: myAppBar("تفاصيل الطلب",context),
      bottomNavigationBar: myBottomNavigationBar(2,(index){
        BootomBarSwitch(index,context);

      },context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: f==true? Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // section('رقم الطلب',data[''],15,15),

                section('مصدر الطلب ',data['source'],15,15),
                section('الوجهة المطلوبة',data['destination'],15,15),
                section('حالة الطلب ',
                         data['state_order'] == "0" ? "قيد الإنتظار"
                        : data['state_order'] == "1" ? "قيد التنفيذ"
                        : data['state_order'] == "2" ? "مكتمل"
                        :  "ملغي"
                    ,15,15),
                section('تاريخ الطلب ',data['date'],15,15),
                data['state_order'] == "0" ?
                section(' زمن الوصول ','${data['time']}:00 دقيقة',15,15):SizedBox(),
                section('التكلفة',"${data['price']} RY",15,15),
                section('طريقة الدفع',data['payment_method'],15,15),
                SizedBox(height: 10,),
                Text("بيانات السائق : ",style: titleStyle(17, primaryColor),),
                SizedBox(height: 10,),
                employeeShortCut(employees[index]['name'].toString(),
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
                SizedBox(height: 40,),

                data['state_order'] == "0" ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  children: [
                    PrimaryButton(
                        Colors.white,
                        primaryColor,
                        'عودة للصفحة السابقة',
                        15,
                        30, 12,() {
                      popNavigator(context);

                    }, context),
                    PrimaryButton(
                        primaryColor,
                        Colors.white,
                        'الغاء الطلب',
                        15,
                        40, 12,() {
                      _showDeleteConfirmationDialog(context);
                    }, context)
                  ],
                ) :Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
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
            )
          ],
        ):Container(
          height:  SizeOfConfig.heightScreen-150,
          child: Center(
              child: CircularProgressIndicator(
                backgroundColor: primaryColor,
              )),
        ),

      ),
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
              Text('الغاء الطلب',
                  style:TextStyle(
                      color: Colors.redAccent,
                      fontFamily: "Cairo"
                  )),
              // Icon(Icons.check,color: Colors.green,size: 40,)
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('هل انت متأكد من رغبتك بالغاء الحجز ؟',
                  style: TextStyle(
                      fontFamily: "Cairo",
                      fontWeight: FontWeight.bold,
                      fontSize: 15
                  ),),
              ],
            ),
          ),
          actions: <Widget>[

            ElevatedButton(
              style: TextButton.styleFrom(
                backgroundColor:Colors.white,
                side: BorderSide(
                  color: primaryColor,
                )

              ),

              child: Text('تراجع',
                style: TextStyle(

                    fontFamily: "Cairo",
                    fontSize: 13,
                  color: primaryColor
                ),),
              onPressed: () {
                // Add your delete logic here
                Navigator.of(context).pop();
              },
            ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                  backgroundColor:Colors.redAccent,

            ),

                  child: Text('نعم',
                    style: TextStyle(

                        fontFamily: "Cairo",
                        fontSize: 14
                    ),),
                  onPressed: () {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context)=>Center(
                          child: CircularProgressIndicator(),
                        ));
                    cancel();
                    // Add your delete logic here
                  },
                ),
          ],
        );
      },
    );
  }
}


