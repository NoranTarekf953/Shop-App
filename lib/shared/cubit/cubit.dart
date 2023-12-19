// ignore_for_file: avoid_print
/*
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/modules/business_screen/business_screen.dart';
import 'package:udemy/modules/science_screen/science_screen.dart';
import 'package:udemy/modules/sports_screen/sports_screen.dart';

import '../layout/News_app/cubit/states.dart';
import '../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialStates());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentindex = 0;
  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.business), label: 'Business'),
    const BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    const BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports')
  ];
  List<Widget> screens = [
    const BusinessScreen(),
    const ScienceScreen(),
    const SportsScreen()
  ];

  void changeNavBar(int index) {
    currentindex = index;
    if (currentindex == 1) {
      getScience();
    } else if (currentindex == 2) {getSports();}
    emit(NewsNavBarStates());
  }

//https://newsapi.org/
//v2/top-headlines
//?country=us&category=business&apiKey=8e78ef5c00dd432a95848f72f45ead2e

  List<dynamic> business = [];
  void getBusiness() {
    emit(LoadingBusinessState());

    if (business.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'business',
        'apiKey': '8e78ef5c00dd432a95848f72f45ead2e'
      }).then((value) {
        business = value.data['articles'];
        //print(value.data['totalResults']);
        //  print(value.data['articles']);

        emit(NewsGetBusinessSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetBusinessErrorState(error: e));
      });
    } else {
      emit(NewsGetBusinessSuccessState());
    }
  }

  List<dynamic> science = [];
  void getScience() {
    emit(LoadingScienceState());

    if (science.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': '8e78ef5c00dd432a95848f72f45ead2e'
      }).then((value) {
        science = value.data['articles'];
        //print(value.data['totalResults']);
        //    print(value.data['articles']);

        emit(NewsGetScienceSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetScienceErrorState(error: e));
      });
    } else {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> sports = [];
  void getSports() {
    emit(LoadingSportsState());

    if (sports.isEmpty) {
      DioHelper.getData(url: 'v2/top-headlines', query: {
        'country': 'us',
        'category': 'sports',
        'apiKey': '8e78ef5c00dd432a95848f72f45ead2e'
      }).then((value) {
        sports = value.data['articles'];
        //print(value.data['totalResults']);
        //      print(value.data['articles']);

        emit(NewsGetSportsSuccessState());
      }).catchError((e) {
        print(e.toString());
        emit(NewsGetSportsErrorState(error: e));
      });
    } else {
      emit(NewsGetSportsSuccessState());
    }
  }

 /* bool isDark = false;

  void changeMood({bool? sharedpref}) {
    if (sharedpref != null) {
      isDark = sharedpref;
      emit(NewsChangeMoodState());
    } else {
      isDark = !isDark;
       CacheHelper.putData(key: 'isDark', value: isDark).then((value) {
      emit(NewsChangeMoodState());
    });
    }
   
  }*/
}
*/