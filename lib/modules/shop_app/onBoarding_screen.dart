// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/taskCard.dart';
import '../../shared/network/local/cache_helper.dart';
import '../../shared/styles/colors.dart';
import 'log_in/logIn_screen.dart';


class OnBoardingModel {
  String img;
  String title;
  String body;
  OnBoardingModel({required this.img, required this.title, required this.body});
}

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingModel> list = [
    OnBoardingModel(
        img: 'assets/images/onboarding2.jpg',
        title: 'On boarding title 1',
        body: 'On boarding body 1'),
    OnBoardingModel(
        img: 'assets/images/onboarding2.jpg',
        title: 'On boarding title 2',
        body: 'On boarding body 2'),
    OnBoardingModel(
        img: 'assets/images/onboarding2.jpg',
        title: 'On boarding title 3',
        body: 'On boarding body 3'),
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
                    effect: const ExpandingDotsEffect(
                      spacing: 8,
                      dotWidth: 20,
                      dotHeight: 16,
                      dotColor: Colors.grey,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //'assets/images/onboarding2.jpg'
        Expanded(child: Image.asset(item.img)),
        const SizedBox(
          height: 20,
        ),
        Text(
          item.title,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          item.body,
          style: const TextStyle(fontSize: 20),
        ),
      ],
    );
  }
}
