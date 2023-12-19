
import '../../../models/shop_app/add_remove_cart_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates{}
class ShopChangeNavBarStates extends ShopStates{}

class ShopHomeLoadingStates extends ShopStates{}
class ShopHomeSuccessStates extends ShopStates{}
class ShopHomeErrorStates extends ShopStates{}

class ShopCategoryLoadingStates extends ShopStates{}
class ShopCategorySuccessStates extends ShopStates{}
class ShopCategoryErrorStates extends ShopStates{}

class ShopChangeFavoritesStates extends ShopStates{}

class ShopChangeFavoritesSuccessStates extends ShopStates{
  final ChangeFavoritesModel model;

  ShopChangeFavoritesSuccessStates(this.model);
}
class ShopChangeFavoritesErrorStates extends ShopStates{}

class ShopGetFavLoadingStates extends ShopStates{}
class ShopGetFavSuccessStates extends ShopStates{}
class ShopGetFavErrorStates extends ShopStates{}

class ShopGetUserDataLoadingStates extends ShopStates{}
class ShopGetUserDataSuccessStates extends ShopStates{}
class ShopGetUserDataErrorStates extends ShopStates{}

class ShopUpdateUserDataLoadingStates extends ShopStates{}
class ShopUpdateUserDataSuccessStates extends ShopStates{}
class ShopUpdateUserDataErrorStates extends ShopStates{}

class ShopGetCartsLoadingStates extends ShopStates{}
class ShopGetCartsSuccessStates extends ShopStates{}
class ShopGetCartsErrorStates extends ShopStates{}


class ShopChangeCartsStates extends ShopStates{}

class ShopChangeCartsSuccessStates extends ShopStates{
  final AddRemoveCartModel model;

  ShopChangeCartsSuccessStates(this.model);
}
class ShopChangeCartsErrorStates extends ShopStates{}

class ShopGetProductDetailLoadingStates extends ShopStates{}
class ShopGetProductDetailSuccessStates extends ShopStates{}
class ShopGetProductDetailErrorStates extends ShopStates{}