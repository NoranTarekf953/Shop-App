// ignore_for_file: unnecessary_null_comparison, must_be_immutable, avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'layout/shop_app/cubit/cubit.dart';
import 'layout/shop_app/shop_app_screen.dart';
import 'modules/shop_app/log_in/logIn_screen.dart';
import 'modules/shop_app/onBoarding_screen.dart';
import 'shared/Constants/constants.dart';
import 'shared/bloc_observer.dart';
import 'shared/network/local/cache_helper.dart';
import 'shared/network/remote/dio_helper.dart';
import 'shared/styles/themes.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';

void main() async {
  try {
    //يتاكد ان كل حاجة في الميثود خلصت وبعدين يفتح الابليكيشن
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
        //  options: DefaultFirebaseOptions.currentPlatform,

        );

    Bloc.observer = MyBlocObserver();
    DioHelper.init();
    await CacheHelper.init();
    bool isDark = CacheHelper.getData(key: 'isDark') ?? false;
    Widget widget;
    bool onBoarding = CacheHelper.getData(key: 'onBoarding') ?? false;
    print(onBoarding);
    token = CacheHelper.getData(key: 'token') ?? '';
    print(token);

    if (onBoarding == true) {
      if (token.isNotEmpty) {
        widget = const ShopAppScreen();
      } else {
        widget = LogIn_Screen();
      }
    } else {
      widget = const OnBoardingScreen();
    }

    runApp(MyApp(
      isDark: isDark,
      startWidget: widget,
    ));
  } catch (e) {
    print(e.toString());
  }
}

class MyApp extends StatelessWidget {
  late bool isDark;
  late Widget startWidget;

  MyApp({
    super.key,
    required this.isDark,
    required this.startWidget,
  });
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..changeMood(sharedpref: isDark)
            ..getHomeData()
            ..getCategoryData()
            ..getFavoritesData()
            ..getUserData()
            ..getCartsData()
            ..getAddressData()
            ..getFAQSData()
            ..getContactData(),
        ),
      ],
      child: BlocConsumer<ShopCubit, ShopStates>(
          builder: (context, index) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              themeMode:
                  // ThemeMode.light,
                  ShopCubit.get(context).isDark
                      ? ThemeMode.dark
                      : ThemeMode.light,
              darkTheme: darkTheme,
              theme: lightTheme,
              home: Directionality(
                  textDirection: TextDirection.ltr,
                  child: AnimatedSplashScreen(
                    splash: const Icon(
                      Icons.shopping_cart_outlined,
                      color: Colors.white,
                      size: 50,
                    ),
                    nextScreen: startWidget,
                    duration: 3000,
                    splashTransition: SplashTransition.fadeTransition,
                    backgroundColor: defaultColor.shade200,
                  )),
            );
          },
          listener: (context, index) {}),
    );
  }
}
