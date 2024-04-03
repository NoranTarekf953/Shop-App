
import '../../../../models/shop_app/profileModels/log_in_model.dart';

abstract class LoginShopStates{}

class LoginShopInitialStates extends LoginShopStates{}

class LoginShopLoadingStates extends LoginShopStates{}

class LoginShopSuccessStates extends LoginShopStates{
  ShopLoginModel loginModel;
  LoginShopSuccessStates({required this.loginModel});
}

class LoginShopErrorStates extends LoginShopStates{
  ShopLoginModel loginModel;
  LoginShopErrorStates({required this.loginModel});
 
}

class ShopChangePasswordVisible extends LoginShopStates{}
class LastScreenOnBoardng extends LoginShopStates{}