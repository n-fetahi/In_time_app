import 'package:flutter/material.dart';
import 'package:in_time_applcation/constant/Navigator_Event.dart';
import 'package:in_time_applcation/constant/PrimaryButton.dart';
import 'package:in_time_applcation/constant/constant.dart';

import 'package:in_time_applcation/screens/intro_pages/intro_page1.dart';
import 'package:in_time_applcation/screens/intro_pages/intro_page2.dart';
import 'package:in_time_applcation/screens/intro_pages/intro_page3.dart';
import 'package:in_time_applcation/screens/register_screen.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'option_screen.dart';

class OnBoardingScreen extends StatefulWidget{
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController _controller = PageController();
  bool onLastPage = false;
  @override
  Widget build(BuildContext context) {
    return   Scaffold(

          body: SafeArea(
            child: Stack(
              children: [
                PageView(
                  controller: _controller,
                  onPageChanged:(index){
                    setState(() {
                      onLastPage = (index == 2);
                    });
                  },
                  children: [
                    IntroPage1(),
                    IntroPage2(),
                    IntroPage3(),
                  ],
                ),
                Container(
                    alignment: Alignment(0, 0.78),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // skip
                        PrimaryButton(
                            Colors.yellow,
                            Colors.black,
                            'تخطي',
                            15,
                            25, 14,() {
                          _controller.jumpToPage(2);


                        }, context),

                        SmoothPageIndicator(controller: _controller, count: 3,
                            effect:const SlideEffect( // تأثير SlideEffect يمكنك استخدامه لتخصيص لون الخلفية
                              spacing: 8.0,
                              radius: 20.0,
                              dotWidth: 12.0,
                              dotHeight: 20.0,
                              dotColor: Colors.grey, // لون النقاط الغير محددة
                              paintStyle: PaintingStyle.stroke,
                              strokeWidth: 2.0,
                              activeDotColor:Colors.yellow, // لون النقطة المحددة
                            ),
                        ),
                        onLastPage ?
                        PrimaryButton(
                            Colors.yellow,
                            Colors.black,
                            'إنتهى',
                            15,
                            25, 14,() {
                          pushNavigator(OptionScreen(), context);


                        }, context)
                            :
                        PrimaryButton(
                            Colors.yellow,
                            Colors.black,
                            'التالي',
                            15,
                            25, 14,() {
                          _controller.nextPage(
                            duration: Duration(milliseconds: 500),
                            curve: Curves.easeIn,);

                        }, context),



                        //next
                      ],
                    ))
              ],
            ),
          )
      );
  }
}
