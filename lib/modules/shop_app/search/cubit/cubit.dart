// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/cubit/states.dart';


import '../../../../models/shop_app/searchModel/search_model.dart';
import '../../../../shared/Constants/constants.dart';
import '../../../../shared/end_point.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class SearchCubit extends Cubit<SearchStates>{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

   SearchModel? searchModel;

   void searchFun(String text){
    emit(SearchLoadingState());
    DioHelper.postData(
      url: search,
       data: {
        'text':text
       },
       token: token).then(
        (value){
searchModel = SearchModel.fromJson(value.data);
emit(SearchSuccesslState());
       }).catchError((e){
        print(e.toString());
        emit(SearchErrorState());
       });
   }
}