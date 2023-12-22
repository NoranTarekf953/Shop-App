// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/taskCard.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import 'log_in/logIn_screen.dart';


class OnBoardingModel {
  String img;
  String title;
  String body;
  OnBoardingModel({required this.img,
   required this.title,
    required this.body});
 
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> list = [
    OnBoardingModel(
        img: 'assets/images/OnlineShop.png',
        title: 'Make Order',
        body: 'Choose Whatever the Product you wish for with the easiest way possible using ShopMart'),
    OnBoardingModel(
        img: 'assets/images/Payment.png',
        title: 'Choose Payment',
        body: 'Pay with the safest way possible either by cash or credit cards'),
    OnBoardingModel(
        img: 'assets/images/Delivery.png',
        title: 'Fast Delivery',
        body: 'Yor Order will be shipped to you as fast as possible by our carrier'),
  ];
  bool isLast = false;
  var controller = PageController();

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value)navigateAndFinish(context,  LogIn_Screen());

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () =>submit(),
                child: Text(
                  'Skip',
                  style: TextStyle(color: defaultColor, fontSize: 18),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: controller,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => onBoardingItem(list[index]),
                  itemCount: list.length,
                  onPageChanged: (value) {
                    if (value == list.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: list.length,
                    effect:  ExpandingDotsEffect(
                      activeDotColor: defaultColor.shade100,
                      spacing: 8,
                      dotWidth: 20,
                      dotHeight: 16,
                      dotColor: Colors.grey.shade400,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    backgroundColor: defaultColor.shade100,
                      onPressed: () {
                        isLast == true
                            ? submit()
                            : controller.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn);
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios,
                      ))
                ],
              )
            ],
          ),
        ));
  }

  Widget onBoardingItem(OnBoardingModel item) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        //'assets/images/onboarding2.jpg'
        Expanded(child: Image.asset(item.img)),
        const SizedBox(
          height: 20,
        ),
        Text(
          item.title,
          style:  GoogleFonts.notoSerif(
            
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: defaultColor),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          item.body,
          style:  GoogleFonts.notoSerif(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.grey[800]),
        ),
      ],
    );
  }
}
