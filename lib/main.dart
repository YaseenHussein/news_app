import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/cubit/cubit2.dart';
import 'package:news_app/share/newtwork/local/cache_helper.dart';
import 'package:news_app/share/newtwork/remote/dio_helper.dart';

import 'cubit/cubit.dart';
import 'cubit/observer.dart';
import 'cubit/states.dart';
import 'layout/home_news.dart';

void main() async {
  ////////
  WidgetsFlutterBinding.ensureInitialized();
  //////
  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  ////////////
  await CacheHelper.init();
  bool? isDark =CacheHelper.getBool(key: "isDark");
///////////
  runApp(MyApp(isDark));
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  MyApp(this.isDark);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppNewsCubit()
            ..getDataBusiness()
            ..changMode(isShared: isDark),
        ),
        BlocProvider(
          create: (context) => NewsCubit()
        ),
      ],
      child: BlocConsumer<AppNewsCubit, AppNewsStates>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          var cubit = AppNewsCubit.get(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            //////////////////////////////////////////////////////////////
            theme: ThemeData(
              primarySwatch: Colors.deepOrange,
              //*********************bottomNavigationBarThem**************************** */
              bottomNavigationBarTheme: const BottomNavigationBarThemeData(
                type: BottomNavigationBarType
                    .fixed, //هذا من اجل ان يطلع ال نفجيش بار بسبب ان الايقون بيضاء
                selectedItemColor: Colors.deepOrange,
                unselectedItemColor: Colors.grey,
                elevation: 20,
              ),
              /****************this for Scaffold background******************/
              scaffoldBackgroundColor: Colors.white,
              /***************AppBarForAllProject*******************/
              appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                iconTheme: IconThemeData(
                  color: Colors.black,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                /***************this is for states bar*****************/
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                /********************************/
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
            ),
            //////////////////////////////////////////////
            darkTheme: ThemeData(
              inputDecorationTheme:
                  InputDecorationTheme(fillColor: Colors.white),
              primarySwatch: Colors.deepOrange,
              //*********************bottomNavigationBarThem**************************** */
              bottomNavigationBarTheme: BottomNavigationBarThemeData(
                type: BottomNavigationBarType
                    .fixed, //هذا من اجل ان يطلع ال نفجيش بار بسبب ان الايقون بيضاء
                selectedItemColor: Colors.deepOrange,
                elevation: 20,
                backgroundColor: HexColor('333739'),
                unselectedItemColor: Colors.grey,
              ),
              /****************this for Scaffold background******************/
              scaffoldBackgroundColor: HexColor("333739"),
              /***************AppBarForAllProject*******************/
              appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                iconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                titleTextStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                /***************this is for states bar*****************/
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: HexColor("333739"),
                  statusBarIconBrightness: Brightness.light,
                ),
                /********************************/
                backgroundColor: HexColor("333739"),
              ),
            ),
            themeMode: cubit.isDark ? ThemeMode.dark : ThemeMode.light,
            home: /* const Directionality(
                  textDirection: TextDirection.rtl,
                  child:*/
                HomeNews(),
            // ),
          );
        },
      ),
    );
  }
}
