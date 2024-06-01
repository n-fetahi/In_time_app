import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/AdminBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/BottomBarSwitch.dart';
import 'package:in_time_applcation/constant/EmpBottomNavigationBar.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/adminBottomBarSwitch.dart';
import 'package:in_time_applcation/constant/constant.dart';
import 'package:in_time_applcation/constant/initShared.dart';
import 'package:in_time_applcation/constant/myAppBar.dart';
import 'package:in_time_applcation/constant/myBottomNavigationBar.dart';

class AdminSettingsPage extends StatefulWidget {
  @override
  _AdminSettingsPageState createState() => _AdminSettingsPageState();
}

class _AdminSettingsPageState extends State<AdminSettingsPage> {
  late TextEditingController _nameController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   myAppBar("إعدادات التطبيق",context),
      bottomNavigationBar:adminBottomNavigationBar(1,(index){
        adminBootomBarSwitch(index,context);

      },context),
          body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'اسم المستخدم',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _phoneController,
              decoration: InputDecoration(
                labelText: 'رقم الهاتف',
              ),
            ),
            SizedBox(height: 46.0),
            PrimaryButton(
                primaryColor,
                Colors.white,
                'حفظ التغييرات',
                15,
                55, 14,() {


            }, context),
          ],
        ),
      ),
    );
  }

  void updateUserInfo(String newName, String newPhone) {
    // تنفيذ العملية لتحديث بيانات المستخدم هنا
    // يمكنك استخدام newName و newPhone لتحديث البيانات بطريقة ملائمة
    print('تم تحديث المعلومات: الاسم: $newName, الهاتف: $newPhone');
  }
}