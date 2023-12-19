// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/Register/cubit/states.dart';


import '../../../../models/shop_app/log_in_model.dart';
import '../../../../shared/Constants/constants.dart';
import '../../../../shared/end_point.dart';
import '../../../../shared/network/remote/dio_helper.dart';

class RegisterShopCubit extends Cubit<RegisterShopStates> {
  RegisterShopCubit() : super(RegisterShopInitialStates());

  static RegisterShopCubit get(context) => BlocProvider.of(context);

   ShopLoginModel? loginModel;

  void registerUser({
    required String name,
    required String email,
    required String password,
    required String phone,
    }) {
    emit(RegisterShopLoadingStates());
    DioHelper.postData(
      url: register,
      token: token,
       data: {
        'name':name,
        'email': email,
        'password': password,
        'phone':phone})
        .then((value) {
         loginModel = ShopLoginModel.fromJson(value.data);

          if(loginModel!.data != null){
 print(value.data);
      emit(RegisterShopSuccessStates(loginModel: loginModel!));
          }else{
            emit(RegisterShopErrorStates(loginModel: loginModel!));
          }
     
    }).catchError((error) {
      print('error in RegisterUser ${error.toString()}');
      emit(RegisterShopErrorStates(loginModel: loginModel!));
    });
  }

  bool isPassword = true;
  IconData suffix = Icons.visibility_outlined;

  void changePasswordVisible() {
    isPassword = !isPassword;
    suffix =
        isPassword ? Icons.visibility_outlined : Icons.visibility_off_outlined;
    emit(ShopRegisterChangePasswordVisible());
  }
}
