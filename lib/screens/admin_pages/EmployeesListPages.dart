import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/AdminBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/BottomBarSwitch.dart';
import 'package:in_time_applcation/constant/EmpBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';

import 'package:in_time_applcation/constant/SizeConfig.dart';
import 'package:in_time_applcation/constant/adminBottomBarSwitch.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/employeeShortCut.dart';
import 'package:in_time_applcation/constant/initShared.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/constant/myIconButton.dart';
import 'package:in_time_applcation/constant/myTextButton.dart';
import 'package:in_time_applcation/screens/admin_pages/AddEmployeePages.dart';
import 'package:in_time_applcation/screens/admin_pages/EditEmployeePages.dart';




class EmployeesListPages extends StatefulWidget {
  const EmployeesListPages({Key? key}) : super(key: key);

  @override
  State<EmployeesListPages> createState() => _EmployeesListPagesState();
}

class _EmployeesListPagesState extends State<EmployeesListPages> {


List<QueryDocumentSnapshot> employees = [];

final CollectionReference order = FirebaseFirestore.instance.collection('Employee');

  bool f=false;

  delete(id)async{

  await order.doc(id).delete();
  pushNavigatorRepace(EmployeesListPages(),context);

}

final CollectionReference emp = FirebaseFirestore.instance.collection('Employee');

  edit(id)async{

  await emp.doc(id).update(
      {
        'isEnabled': 0,

      }

  );
  pushNavigator(EmployeesListPages(),context);

}
getData() async{
  employees=[];
  QuerySnapshot querySnapshot= await FirebaseFirestore.instance.collection('Employee')
      .where('isAdmin', isEqualTo: 0)
      .where('isEnabled', isEqualTo: 1)
      .get();
  employees.addAll(querySnapshot.docs);
  setState((){

  });

  f=true;

}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }


  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);

    return Scaffold(
      appBar:   myAppBar("إضافة موظف",context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: f==true? Column(
          children: [

            myTextButton("موظف جديد",Icons.add,(){
              pushNavigator(AddEmployeePages(),context);
            },context),


            Container(
              width: SizeOfConfig.widthScreen,
              height: SizeOfConfig.heightScreen,

              child: ListView.builder(
                  itemCount: employees.length,
                  itemBuilder:(_,i){
                    print(employees[i]);
                return Container(

                  margin: EdgeInsets.only(top: 10),

                  child: employeeShortCut(employees[i]['name'],
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [


                          myIconButton(Icons.edit,Colors.orange,40,(){
                            pushNavigator(EditEmployeePages(employee: employees[i],), context);
                          }),
                          SizedBox(height: 10,),
                          myIconButton(Icons.delete,Colors.deepOrange,40,(){
                            _showDeleteConfirmationDialog(employees[i].id,context);
                          }),


                        ],
                      ),context),
                );
              }
              ),
            ),
            SizedBox(height: 20,),




          ],
        ):Container(
          height:  SizeOfConfig.heightScreen-150,
          child: Center(
              child: CircularProgressIndicator(
                backgroundColor: primaryColor,
              )),
        ),

      ),
        bottomNavigationBar:adminBottomNavigationBar(0,(index){
          adminBootomBarSwitch(index,context);

        },context)
    );
  }
Future<void> _showDeleteConfirmationDialog( id,BuildContext context) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('تأكيد الحذف',
                style:TextStyle(
                    color: Colors.redAccent,
                    fontFamily: "Cairo"
                )),
            Icon(Icons.delete,color: Colors.redAccent,size: 30,)
          ],
        ),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text("هل انت متأكد من حذف هذا الموظف",
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
              backgroundColor: Colors.redAccent,

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
              showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context)=>Center(
                    child: CircularProgressIndicator(),
                  ));
              edit(id);
              // secondStateWithPyment();

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



