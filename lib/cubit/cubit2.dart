import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';

import '../share/newtwork/remote/dio_helper.dart';

class NewsCubit extends Cubit<AppNewsStates> {
  NewsCubit() : super(AppNewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  List<dynamic> search = [];
  void searchData(value) {
    DioHelper.getData(url: 'https://newsapi.org/v2/everything', query: {
      'q': '$value',
      'apiKey': '29151f5d5df440aea1663ca099606051',
    }).then((value) {
      search = value.data['articles'];
      emit(AppNewsSearchDataState());
    }).catchError((e) {
      print(" Error is => $e");
      emit(AppNewsSearchErrorDataState(e.toString()));
    });
  }
}
