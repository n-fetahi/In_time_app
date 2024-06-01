import 'package:flutter/material.dart';

class AboutApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('خدماتنا'),
      ),
      body: ListView(
        padding: EdgeInsets.all(12.0),
        children: [
          ServiceCard(
            image:'assets/images/Ser1.png',
            title: 'طلب تاكسي اونلاين',
            description: 'نحن نقدم خدمة النقل السريع للبضائع والشحنات الكبيرة باستخدام أحدث التقنيات وأسطول الشاحنات المجهزة.',
          ),
          SizedBox(height: 20.0),
          ServiceCard(
            image:'assets/images/Ser2.png',
            title: 'طلب حافلة',
            description: 'مع خدمة التوصيل المنزلي لدينا، يمكنك طلب المنتجات والطعام والأشياء الأخرى وتوصيلها مباشرة إلى باب منزلك.',
          ),
          SizedBox(height: 20.0),
          ServiceCard(
            image:'assets/images/Ser3.png',
            title: ' طلب دراجة نارية',
            description: 'نحن نوفر خدمة الصيانة والإصلاح للأجهزة الإلكترونية والأجهزة المنزلية والمعدات الصناعية بفريق فنيين متخصصين.',
          ),
          SizedBox(height: 20.0),
          ServiceCard(
            image:'assets/images/Ser4.png',
            title: 'إستئجار سيارة',
            description: 'مع خدمة الاستشارات المالية، يمكنك الحصول على نصائح وتوجيهات خبراء ماليين لإدارة أموالك واستثماراتك بشكل فعال.',
          ),
          SizedBox(height: 20.0),
          ServiceCard(
            image:'assets/images/Ser5.png',
            title: 'طلب ميكانيكي',
            description: 'نحن نقدم خدمة التصميم الداخلي للمنازل والمكاتب والمحلات التجارية، مع فريق متخصص من المصممين لتحقيق بيئة جميلة ووظيفية.',
          ),
        ],
      ),
    );
  }
}

class ServiceCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;

  ServiceCard({
    required this.image,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            image,
            fit: BoxFit.cover,
            height: 200,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  description,
                  style: TextStyle(fontSize: 16.0),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}