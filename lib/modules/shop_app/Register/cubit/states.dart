
import '../../../../models/shop_app/log_in_model.dart';

abstract class RegisterShopStates{}

class RegisterShopInitialStates extends RegisterShopStates{}

class RegisterShopLoadingStates extends RegisterShopStates{}

class RegisterShopSuccessStates extends RegisterShopStates{
  ShopLoginModel loginModel;
  RegisterShopSuccessStates({required this.loginModel});
}

class RegisterShopErrorStates extends RegisterShopStates{
    ShopLoginModel loginModel;
  RegisterShopErrorStates({ required this.loginModel});
}

class ShopRegisterChangePasswordVisible extends RegisterShopStates{}
class LastScreenOnBoardng extends RegisterShopStates{}