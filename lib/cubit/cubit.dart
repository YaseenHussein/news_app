import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/moduls/setting/setting.dart';
import 'package:news_app/moduls/sport/sport.dart';
//import 'package:news_app/share/newtwork/local/cache_helper.dart';
import 'package:news_app/share/newtwork/remote/dio_helper.dart';

import '../moduls/business/business.dart';
import '../moduls/science/science.dart';
import '../share/newtwork/local/cache_helper.dart';

class AppNewsCubit extends Cubit<AppNewsStates> {
  AppNewsCubit() : super(AppNewsInitialState());
  static AppNewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;

  void setCurrentIndex(int index) {
    currentIndex = index;
    if (index == 1) {
      getSportData();
    } else if (index == 2) {
      getDataScience();
    }
    emit(AppNewsNavBarState());
  }

  List<BottomNavigationBarItem> NavItem = const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business_center,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sport',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
  ];
  List<Widget> screens = const [
    BusinessScreen(),
    SportScreen(),
    ScienceScreen(),
  ];
  List<dynamic> business = [];
  List<dynamic> sport = [];
  List<dynamic> science = [];
  void getDataBusiness() {
    emit(AppNewsDetBusinessLoadingState());
    DioHelper.getData(url: 'https://newsapi.org/v2/top-headlines', query: {
      'country': 'us',
      'category': 'business',
      'apiKey': '29151f5d5df440aea1663ca099606051',
    }).then((value) {
      business = value.data['articles'];
      print(business[0]['title']);
      emit(AppNewsDetBusinessDataState());
    }).catchError((e) {
      print(" Error is => $e");
      emit(AppNewsDetBusinessErrorDataState(e.toString()));
    });
  }

  void getSportData() {
    if (sport.isEmpty) {
      emit(AppNewsDetSportLoadingState());
      DioHelper.getData(url: 'https://newsapi.org/v2/top-headlines', query: {
        'country': 'us',
        'category': 'sport',
        'apiKey': '29151f5d5df440aea1663ca099606051',
      }).then((value) {
        sport = value.data['articles'];
        emit(AppNewsDetSportDataState());
      }).catchError((e) {
        print(" Error is => $e");
        emit(AppNewsDetSportErrorDataState(e.toString()));
      });
    } else {
      emit(AppNewsDetSportDataState());
    }
  }

  void getDataScience() {
    if (science.isEmpty) {
      emit(AppNewsDetBusinessLoadingState());
      DioHelper.getData(url: 'https://newsapi.org/v2/top-headlines', query: {
        'country': 'us',
        'category': 'science',
        'apiKey': '29151f5d5df440aea1663ca099606051',
      }).then((value) {
        science = value.data['articles'];
        emit(AppNewsDetBusinessDataState());
      }).catchError((e) {
        print(" Error is => $e");
        emit(AppNewsDetBusinessErrorDataState(e.toString()));
      });
    } else {
      emit(AppNewsDetBusinessDataState());
    }
  }

  bool isDark = false;

  void changMode({bool? isShared}) {
    if (isShared != null) {
      isDark = isShared;
      emit(AppChangModeState());
    } else {
      isDark = !isDark;
      CacheHelper.putBool(key: "isDark", isDark: isDark).then(
        (value) {
          emit(AppChangModeState());
        },
      );
    }
  }
}
