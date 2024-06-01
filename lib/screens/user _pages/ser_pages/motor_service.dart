import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'chat_page.dart';

class MotorService extends StatelessWidget {
  const MotorService ({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'طلب دراجة نارية ',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: OrderPage(),
    );
  }
}

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {
  String? selectedOption1;
  String? selectedOption2;
  TextEditingController textEditingController = TextEditingController();
  DateTime? selectedDate;

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  void submitOrder() {
    if (selectedOption1 != null && selectedOption2 != null) {
      // يمكنك هنا استخدام القيم المحددة والنص المدخل لاتخاذ إجراءات أخرى، مثل إرسال طلب الشراء
      print('تم اختيار العنصر الأول: $selectedOption1');
      print('تم اختيار العنصر الثاني: $selectedOption2');
    } else {
      print('لم يتم اختيار أحد العناصر.');
    }
  }

  void reserveLater() {
    if (selectedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(selectedDate!);
      print('تم تحديد التاريخ: $formattedDate');
    } else {
      print('لم يتم تحديد تاريخ.');
    }
  }

  void cancelReservation() {
    print('تم إلغاء الحجز.');
  }

  void navigateToChatPage() {
    // انتقل إلى صفحة الدردشة
  }

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(' طلب دراجة نارية '),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Image.asset(
              'assets/images/Ser3.png',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedOption1,
              onChanged: (newValue) {
                setState(() {
                  selectedOption1 = newValue;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: ' سيتي مارت',
                  child: Text('سيتي مارت'),
                ),
                DropdownMenuItem(
                  value: 'الزبيري',
                  child: Text(' الزبيري'),
                ),
                DropdownMenuItem(
                  value: ' حدة',
                  child: Text('حدة '),
                ),
                DropdownMenuItem(
                  value: ' هائل',
                  child: Text('هائل '),
                ),
                DropdownMenuItem(
                  value: ' الحصبة',
                  child: Text('الحصبة '),
                ),
                DropdownMenuItem(
                  value: ' الأصبحي',
                  child: Text('الأصبحي '),
                ),
              ],
              decoration: const InputDecoration(
                labelText: '  موقعك',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: selectedOption2,
              onChanged: (newValue) {
                setState(() {
                  selectedOption2 = newValue;
                });
              },
              items: const [
                DropdownMenuItem(
                  value: ' سيتي مارت',
                  child: Text('سيتي مارت'),
                ),
                DropdownMenuItem(
                  value: 'الزبيري',
                  child: Text(' الزبيري'),
                ),
                DropdownMenuItem(
                  value: ' حدة',
                  child: Text('حدة '),
                ),
                DropdownMenuItem(
                  value: ' هائل',
                  child: Text('هائل '),
                ),
                DropdownMenuItem(
                  value: ' الحصبة',
                  child: Text('الحصبة '),
                ),
                DropdownMenuItem(
                  value: ' الأصبحي',
                  child: Text('الأصبحي '),
                ),
              ],
              decoration: const InputDecoration(
                labelText: 'وجهتك  ',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: textEditingController,
              decoration: const InputDecoration(
                labelText: 'أدخل نصًا',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitOrder,
              child: const Text('إرسال الطلب'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => selectDate(context),
              child: const Text('احجز في وقت لاحق'),
            ),
            if (selectedDate != null)
              Text('تم تحديد التاريخ: ${DateFormat('dd/MM/yyyy').format(
                  selectedDate!)}'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: cancelReservation,
              child: const Text('إلغاء الحجز'),
            ),
            const SizedBox(height: 20),
            SizedBox(height: 20),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChatPage()),
                );
              },
              icon: const Icon(Icons.chat),
              tooltip: 'فتح الدردشة',
            ),
          ],
        ),
      ),
    );
  }
}
