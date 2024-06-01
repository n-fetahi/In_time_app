import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/BottomBarSwitch.dart';
import 'package:in_time_applcation/constant/EmpBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/SizeConfig.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/empBottomBarSwitch.dart';
import 'package:in_time_applcation/constant/initShared.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/constant/myBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/myIconButton.dart';
import 'package:in_time_applcation/constant/section.dart';
import 'package:in_time_applcation/screens/orders/DriverOrderListPage.dart';
import '../../constant/employeeShortCut.dart';




class DriverOrdersDetailsPage extends StatefulWidget {
  const DriverOrdersDetailsPage({Key? key,required this.document}) : super(key: key);
  final document;

  @override
  State<DriverOrdersDetailsPage> createState() => _DriverOrdersDetailsPageState();
}

class _DriverOrdersDetailsPageState extends State<DriverOrdersDetailsPage> {
  final CollectionReference order = FirebaseFirestore.instance.collection('Order');
  String docID='';
firstState()async{


  await order.doc(docID).update(
    {
      "state_order":"1"
    }

  );

  pushNavigator(DriverOrderListPage(),context);



}

  secondState(){


     order.doc(docID).update(
        {
          "state_order":"2",
        }

    );

     pushNavigator(DriverOrderListPage(),context);



  }

  secondStateWithPyment(){
    order.doc(docID).update(
        {
          "state_order":"2",
          "state_pyment":"1"
        }

    );

    pushNavigator(DriverOrderListPage(),context);

  }

  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);
     Map<String, dynamic> data =widget.document.data()!;
      docID=widget.document.id;
    return Scaffold(
      appBar: myAppBar("تفاصيل الطلب",context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
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

                SizedBox(height: 15,),

                Text("وسيلة التواصل : ",style: titleStyle(17, primaryColor),),
                SizedBox(height: 20,),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    myIconButton(Icons.message,Colors.orange,50,(){}),
                    myIconButton(Icons.call,Colors.green,50,(){}),


                  ],
                ),
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
                            'تأكيد اللقاء',
                            15,
                            40, 12,() {
                          showDialog(
                              barrierDismissible: false,
                              context: context,
                              builder: (context)=>Center(
                                child: CircularProgressIndicator(),
                              ));
                          firstState();
                        }, context)
                      ],
                    ) : data['state_order'] == "1"? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,

                      children: [PrimaryButton(
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
                            'تأكيد التوصيل',
                            15,
                            40, 12,() {
                              if(data['state_pyment'] == "0"){
                                _showDeleteConfirmationDialog(data['price'],context);
                              }
                              else{
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context)=>Center(
                                      child: CircularProgressIndicator(),
                                    ));
                                secondState();

                              }

                        }, context)],
                    ):Row(
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
        ),

      ),
      bottomNavigationBar: empBottomNavigationBar(1,(index){
        empBootomBarSwitch(index,context);

      },context)
    );
  }
  Future<void> _showDeleteConfirmationDialog(String price,BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('تأكيد الدفع',
                  style:TextStyle(
                      color: Colors.orange,
                      fontFamily: "Cairo"
                  )),
              // Icon(Icons.check,color: Colors.green,size: 40,)
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('هل انت متاكد من استلام المبلغ ($price RY) من العميل',
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
                      color: primaryColor
                  )


              ),

              child: Text('لا',
                style: TextStyle(

                    fontFamily: "Cairo",
                    fontSize: 14,
                    color: primaryColor
                ),),
              onPressed: () {
              popNavigator(context);

                // Add your delete logic here
                // Navigator.of(context).pop();
              },
            ),
                ElevatedButton(
                  style: TextButton.styleFrom(
                  backgroundColor:primaryColor,

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
                    secondStateWithPyment();

                    // Add your delete logic here
                    // Navigator.of(context).pop();
                  },
                ),

          ],
        );
      },
    );
  }

}


