import 'package:flutter/material.dart';

import 'chat_page.dart';

class CarRentalPage extends StatefulWidget {
  @override
  _CarRentalPageState createState() => _CarRentalPageState();
}

class _CarRentalPageState extends State<CarRentalPage> {
  late String selectedCarType;
  bool withDriver = false;

  List<String> carTypes = ['رافور', 'جي كلاس', ' مرسيدس', 'لاندكروزر'];

  @override
  void initState() {
    super.initState();
    selectedCarType = carTypes.first;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('خدمة استئجار السيارات'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.asset(
              'assets/images/Ser4.png',
              height: 200,
              width: 200,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Text(
              'اختر نوع السيارة:',
              style: TextStyle(fontSize: 18),
              textDirection: TextDirection.rtl,
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: selectedCarType,
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    selectedCarType = newValue;
                  });
                }
              },
              items: carTypes.map((String carType) {
                return DropdownMenuItem<String>(
                  value: carType,
                  child: Text(
                    carType,
                    textDirection: TextDirection.rtl,
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  'مع سائق:',
                  style: TextStyle(fontSize: 18),
                  textDirection: TextDirection.rtl,
                ),
                Checkbox(
                  value: withDriver,
                  onChanged: (bool? newValue) {
                    if (newValue != null) {
                      setState(() {
                        withDriver = newValue;
                      });
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // اتخاذ إجراء عند النقر على الزر
                // يمكنك استخدام selectedCarType و withDriver هنا لاتخاذ إجراء مناسب
              },
              child: Text(
                'احجز السيارة',
                textDirection: TextDirection.rtl,
              ),
            ),
            SizedBox(height: 20),
            FloatingActionButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
              child: Icon(Icons.chat),
              backgroundColor: Colors.orangeAccent,
            ),
          ],
        ),
      ),
    );
  }
}