import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/AdminBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/BottomBarSwitch.dart';
import 'package:in_time_applcation/constant/EmpBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';

import 'package:in_time_applcation/constant/SizeConfig.dart';
import 'package:in_time_applcation/constant/TextForm.dart';
import 'package:in_time_applcation/constant/adminBottomBarSwitch.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/employeeShortCut.dart';
import 'package:in_time_applcation/constant/initShared.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/constant/myIconButton.dart';
import 'package:in_time_applcation/screens/admin_pages/EmployeesListPages.dart';




class EditEmployeePages extends StatefulWidget {
  const EditEmployeePages({Key? key,required this.employee}) : super(key: key);
  final employee;
  @override
  State<EditEmployeePages> createState() => _EditEmployeePagesState();
}

class _EditEmployeePagesState extends State<EditEmployeePages> {

  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _carNumController = TextEditingController();
  TextEditingController _idController = TextEditingController();
  TextEditingController _addController = TextEditingController();

  final CollectionReference emp = FirebaseFirestore.instance.collection('Employee');

  edit()async{

    await emp.doc(widget.employee.id).update(
        {
        'name': _nameController.text,
        "address" : _addController.text,
        "car_number" : _carNumController.text,
        "id":_idController.text,
        "phone" : _phoneController.text,
        }

    );
    pushNavigator(EmployeesListPages(),context);

  }


  final _formKey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    SizeOfConfig().init(context);
    var employee=widget.employee;

    _nameController.text=employee['name'].toString();
    _phoneController.text=employee['phone'].toString();
    _carNumController.text=employee['car_number'].toString();
    _idController.text=employee['id'].toString();
    _addController.text=employee['address'].toString();
    // getItem();
    return Scaffold(
      appBar:   myAppBar(" الموظفين",context),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const  CircleAvatar(
                backgroundColor: primaryColor,
                radius: 75,
                backgroundImage: AssetImage('assets/man.png'),
              ),
              SizedBox(height: 20,),
              TextForm(
                obscureText: false,
                controller: _nameController,
                myKey: TextInputType.name,
                lableText: 'اسم الموظف',

                validation: (value){

                  return "";
                },
                press: (value){

                },
              ),
              SizedBox(height: 20,),
              TextForm(
                obscureText: false,
                controller: _phoneController,
                myKey: TextInputType.number,
                lableText: 'رقم الهاتف',
                validation: (value){
                  return "";
                },
                press: (value){

                },
              ),

              SizedBox(height: 20,),
              TextForm(
                obscureText: false,
                controller: _carNumController,
                myKey: TextInputType.number,
                lableText: 'رقم السيارة',
                validation: (value){
                  return "";
                },
                press: (value){

                },
              ),

              SizedBox(height: 20,),
              TextForm(
                obscureText: false,
                controller: _idController,
                myKey: TextInputType.number,
                lableText: 'رقم الهوية',
                validation: (value){
                  return "";
                },
                press: (value){

                },
              ),

              SizedBox(height: 20,),
              TextForm(
                obscureText: false,
                myKey: TextInputType.text,
                controller: _addController,
                lableText: 'العنوان',
                validation: (value){
                  return "";
                },
                press: (value){

                },
              ),
              SizedBox(height: 20,),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  PrimaryButton(
                      primaryColor,
                      Colors.white,
                      'تعديل',
                      15,
                      55, 14,() {
                    showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context)=>Center(
                          child: CircularProgressIndicator(),
                        ));
                    edit();


                  }, context),
                  PrimaryButton(
                      Colors.white,
                      primaryColor,
                      'إلغاء',
                      15,
                      55, 14,() {
                    popNavigator(context);

                  }, context)
                ],
              )
            ],
          ),
        ),

      ),
      bottomNavigationBar:adminBottomNavigationBar(0,(index){
        adminBootomBarSwitch(index,context);

      },context),
    );
  }


}



