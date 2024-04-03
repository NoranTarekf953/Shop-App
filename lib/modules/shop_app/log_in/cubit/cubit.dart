// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/log_in/cubit/states.dart';


import '../../../../models/shop_app/profileModels/log_in_model.dart';
import '../../../../shared/end_point.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class LoginShopCubit extends Cubit<LoginShopStates> {
  LoginShopCubit() : super(LoginShopInitialStates());

  static LoginShopCubit get(context) => BlocProvider.of(context);

    late ShopLoginModel loginModel;

  void loginUser(String email, String password) {
    try {
       emit(LoginShopLoadingStates());
    DioHelper.postData(
      url: login,
       data: {
        'email': email,
        'password': password})
        .then((value) {
        loginModel = ShopLoginModel.fromJson(value.data);
       emit(LoginShopSuccessStates(loginModel: loginModel));
       
    }).catchError((error) {
              print(loginModel.message);

      print('error in loginUser ${error.toString()}');
      emit(LoginShopErrorStates(loginModel: loginModel));
    });
    } catch (e) {
      print(e.toString());
    }
   
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisible() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopChangePasswordVisible());
  }
}
