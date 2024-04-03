
import '../../../models/shop_app/cartsModel/add_remove_cart_model.dart';
import '../../../models/shop_app/favoritesModel/change_favorites_model.dart';

abstract class ShopStates {}

class ShopInitialStates extends ShopStates{}
class ShopChangeNavBarStates extends ShopStates{}

class ShopAddQuantityStates extends ShopStates{}
class ShopMinusQuantityStates extends ShopStates{}

class SocialTappedSuccessState extends ShopStates{}
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

class ShopDeleteCartsSuccessStates extends ShopStates{}
class ShopDeleteCartsErrorStates extends ShopStates{}

class ShopUpdateCartsSuccessStates extends ShopStates{}
class ShopUpdateCartsErrorStates extends ShopStates{}
class ShopAddQuantitySuccessStates extends ShopStates{

}
class ShopAddQuantityErrorStates extends ShopStates{}
class ShopGetProductDetailLoadingStates extends ShopStates{}
class ShopGetProductDetailSuccessStates extends ShopStates{}
class ShopGetProductDetailErrorStates extends ShopStates{}

class ShopGetAddressLoadingStates extends ShopStates{}
class ShopGetAddressSuccessStates extends ShopStates{}
class ShopGetAddressErrorStates extends ShopStates{}

class ShopAddNewAddressLoadingStates extends ShopStates{}
class ShopAddNewAddressSuccessStates extends ShopStates{}
class ShopAddNewAddressErrorStates extends ShopStates{}

class ShopUpdateAddressLoadingStates extends ShopStates{}
class ShopUpdateAddressSuccessStates extends ShopStates{}
class ShopUpdateAddressErrorStates extends ShopStates{}

class ShopDeleteAddressSuccessStates extends ShopStates{}
class ShopDeleteAddressErrorStates extends ShopStates{}

class ShopGetFAQSSuccessStates extends ShopStates{}
class ShopGetContactSuccessStates extends ShopStates{}


class ShopGetCategoryDetailLoadingStates extends ShopStates{}
class ShopGetCategoryDetailSuccessStates extends ShopStates{}
class ShopGetCategoryDetailErrorStates extends ShopStates{}

class NewsChangeMoodState extends ShopStates{}