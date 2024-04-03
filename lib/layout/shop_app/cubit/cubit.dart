// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/addressModels/address_model.dart';
import 'package:shop_app/models/shop_app/addressModels/newAddress_model.dart';
import 'package:shop_app/models/shop_app/cartsModel/update_delete_carts_model.dart';
import 'package:shop_app/models/shop_app/categoriesModels/categories_details.dart';
import 'package:shop_app/models/shop_app/homeModels/product_detail.dart';
import 'package:shop_app/modules/shop_app/setting/setting_screen.dart';

import '../../../models/shop_app/cartsModel/add_remove_cart_model.dart';
import '../../../models/shop_app/categoriesModels/categories_model.dart';
import '../../../models/shop_app/favoritesModel/change_favorites_model.dart';
import '../../../models/shop_app/cartsModel/get_carts_model.dart';
import '../../../models/shop_app/favoritesModel/get_favorites_model.dart';
import '../../../models/shop_app/homeModels/home_model.dart';
import '../../../models/shop_app/profileModels/log_in_model.dart';
import '../../../models/shop_app/settings/contact_model.dart';
import '../../../models/shop_app/settings/faqs_model.dart';
import '../../../modules/shop_app/carts/carts_screen.dart';
import '../../../modules/shop_app/favorites/favorites_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../shared/Constants/constants.dart';
import '../../../shared/end_point.dart';
import '../../../shared/network/remote/dio_helper.dart';
import '../../../shared/network/local/cache_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const FavoritesScreen(),
    const CartsScreen(),
    const SettingScreen()
  ];
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
        ),
        label: 'Favorites'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.shopping_bag_outlined,
        ),
        label: 'Carts'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.settings,
        ),
        label: 'Settings'),
  ];
  void changeNavIndex({int index = 0}) {
    currentIndex = index;
    emit(ShopChangeNavBarStates());
  }

String language = 'en';
bool isTapped = false;

  void menuListTap() {
    isTapped = !isTapped;
    print(isTapped);
    emit(SocialTappedSuccessState());
  }
  HomeModel? homemodel;
  Map<int, bool> changeFav = {};
  Map<int, bool> changeCarts = {};

  int counter = 0;
  void addQuantity({required int count, required productId}) {
    count++;
    if(count <= 5) {
      updateCarts(cartId: productId, quantity: count);
    }
    print(count);
    emit(ShopAddQuantityStates());
  }

  void minusQuantity({required int count, required productId}) {
    count < 0 ? count = 0 : count--;
    if(count != 0) {
      updateCarts(cartId: productId, quantity: count);
    }

    print(count);
    emit(ShopMinusQuantityStates());
  }

  void getHomeData() {
    emit(ShopHomeLoadingStates());
    DioHelper.getData(url: home, token: token, lang: 'en').then((value) {
      homemodel = HomeModel.fromJson(value.data);
      if (homemodel != null) {
        emit(ShopHomeSuccessStates());
      } else {
        emit(ShopHomeErrorStates());
      }
      // ignore: avoid_function_literals_in_foreach_calls
      homemodel!.data.products.forEach((element) {
        changeFav.addAll({element.id: element.inFav});
        changeCarts.addAll({element.id: element.inCart});
      });
      //print(changeFav);
    }).catchError((e) {
      emit(ShopHomeErrorStates());
    });
  }

  CategoryModel? catmodel;
  void getCategoryData() {
    emit(ShopCategoryLoadingStates());
    DioHelper.getData(url: categories, token: token).then((value) {
      catmodel = CategoryModel.fromJson(value.data);
      if (catmodel != null) {
        emit(ShopCategorySuccessStates());
      } else {
        emit(ShopCategoryErrorStates());
      }
    }).catchError((e) {
      emit(ShopCategoryErrorStates());
    });
  }

////////// Favrites ////////////////
  late ChangeFavoritesModel changeFavModel;
  void changeFavorites(dynamic productId) {
    try {
      changeFav[productId] = !changeFav[productId]!;
      emit(ShopChangeFavoritesStates());

      DioHelper.postData(
          url: favorites,
          token: token,
          data: {'product_id': productId}).then((value) {
        changeFavModel = ChangeFavoritesModel.fromJson(value.data);
        //print(value.data);
        //print(token);
        // print(changeFavModel.status);

        //print(changeFavModel.message);
        if (!changeFavModel.status && token == null) {
          //print(changeFavModel.message);
          changeFav[productId] = !changeFav[productId]!;
          emit(ShopChangeFavoritesErrorStates());
        } else {
          getFavoritesData();
        }

        emit(ShopChangeFavoritesSuccessStates(changeFavModel));
      }).catchError((e) {
        print(e.toString());
        changeFav[productId] = !changeFav[productId]!;

        emit(ShopChangeFavoritesErrorStates());
      });
    } catch (e) {
      print('change fav error${e.toString()}');
    }
  }

  late GetFavModel getFavmodel;
  void getFavoritesData() {
    emit(ShopGetFavLoadingStates());

    DioHelper.getData(url: favorites, token: token).then((value) {
      try {
        getFavmodel = GetFavModel.fromJson(value.data);
        print(value.data);
        // print(getFavmodel!.data!.data!.length);
        if (getFavmodel != null) {
          emit(ShopGetFavSuccessStates());
        }
      } catch (e) {
        print('get fav error${e.toString()}');
        rethrow;
      }
    }).catchError((e) {
      emit(ShopGetFavErrorStates());
    });
  }

///////////// Carts ////////////////
  late GetCartsModel getCartsmodel;
  void getCartsData() {
    emit(ShopGetCartsLoadingStates());

    DioHelper.getData(
      url: carts,
      token: token).then((value) {
      try {
        getCartsmodel = GetCartsModel.fromJson(value.data);
        // print(value.data);
        if (getCartsmodel != null) {
          emit(ShopGetCartsSuccessStates());
        }
      } catch (e) {
        print('get carts error${e.toString()}');
        rethrow;
      }
    }).catchError((e) {
      emit(ShopGetCartsErrorStates());
    });
  }

  AddRemoveCartModel? changeCartsModel;

  void addRemoveCarts(dynamic productId,) {
    try {
      changeCarts[productId] = !changeCarts[productId]!;
      emit(ShopChangeCartsStates());

      DioHelper.postData(
          url: carts,
          token: token,
          data: {
            'product_id': productId}
            ).then((value) {
              print(productId);
        changeCartsModel = AddRemoveCartModel.fromJson(value.data);

        print(changeCartsModel!.message);
        if (!changeCartsModel!.status! && token == null) {
          //print(changeFavModel.message);
          changeCarts[productId] = !changeCarts[productId]!;
          emit(ShopChangeCartsErrorStates());
        } else {
          getCartsData();
        }

        emit(ShopChangeCartsSuccessStates(changeCartsModel!));
      }).catchError((e) {
        print(e.toString());
        changeCarts[productId] = !changeCarts[productId]!;

        emit(ShopChangeCartsErrorStates());
      });
    } catch (e) {
      print('change carts error${e.toString()}');
    }
  }

UpdateDeleteCartModel? updateDeleteCartModel;
void updateCarts({required dynamic cartId,required int quantity}) {
           DioHelper.putData(
          url: 'carts/$cartId',
          token: token,
          data: {
            'quantity':quantity
          }
            ).then((value) {
               updateDeleteCartModel = UpdateDeleteCartModel.fromJson(value.data);
    if(updateDeleteCartModel!.status==true) {
      getCartsData();
    } else{
      showToast(updateDeleteCartModel!.message);
    }
    print(updateDeleteCartModel!.message);
    emit(ShopUpdateCartsSuccessStates());
      }).catchError((e) {
        print(e.toString());
    emit(ShopUpdateCartsErrorStates());
      });
    
  }


void deleteCarts({required int cartId}){
DioHelper.deleteData(
    url: 'carts/$cartId',
  token: token, )
  .then((value){
    updateDeleteCartModel = UpdateDeleteCartModel.fromJson(value.data);
    if(updateDeleteCartModel!.status==true) {
      getCartsData();
    } else{
      showToast(updateDeleteCartModel!.message);
    }
    print(updateDeleteCartModel!.message);
    emit(ShopDeleteCartsSuccessStates());
  }).catchError((e){
    print('delete cart ${e.toString()}');
    emit(ShopDeleteCartsErrorStates());
  });

}
///////////// Addresses ///////////////
 AddressModel? addressModel;
  void getAddressData() {
    emit(ShopGetAddressLoadingStates());

    DioHelper.getData(
      url: address,
      token: token).then((value) {
      try {
        addressModel = AddressModel.fromJson(value.data);
        // print(value.data);
        if (addressModel != null) {
          emit(ShopGetAddressSuccessStates());
        }
      } catch (e) {
        print('get address error${e.toString()}');
        rethrow;
      }
    }).catchError((e) {
      emit(ShopGetAddressErrorStates());
    });
  }

late NewAddressModel newAddressModel;

void addNewAddressData({
  required String name,
  required String city,
  required String region,
  required String details,
  required String notes,
  double latitude = 30.0616863,
  double longitude = 31.3260088
}){
emit(ShopAddNewAddressLoadingStates());
DioHelper.postData(
  url: address,
  token: token,
   data: {
    'name':name,
    'city':city,
    'region':region,
    'details':details,
    'notes':notes,
    'latitude':latitude,
    'longitude':longitude
   }).then((value) {
    newAddressModel = NewAddressModel.fromJson(value.data);
    if(newAddressModel.status==true) {
      getAddressData();
    } else{
      showToast(newAddressModel.message);
    }
    emit(ShopAddNewAddressSuccessStates());
   }).catchError((e){
print('error in add new address ${e.toString()}');
emit(ShopAddNewAddressErrorStates());
   });
}

void updateAddressData({
  required int id ,
  required String name,
  required String city,
  required String region,
  required String details,
  required String notes,
  double latitude = 30.0616863,
  double longitude = 31.3260088
}){
emit(ShopUpdateAddressLoadingStates());
DioHelper.putData(
  url: 'addresses/$id',
  token: token,
   data: {
    'name':name,
    'city':city,
    'region':region,
    'details':details,
    'notes':notes,
    'latitude':latitude,
    'longitude':longitude
   }).then((value) {
    newAddressModel = NewAddressModel.fromJson(value.data);
    if(newAddressModel.status==true) {
      getAddressData();
    } else{
      showToast(newAddressModel.message);
    }
    emit(ShopUpdateAddressSuccessStates());
   }).catchError((e){
print('error in update address ${e.toString()}');
emit(ShopUpdateAddressErrorStates());
   });
}

void deleteAddressData({required addressId}){
  DioHelper.deleteData(
    url: 'addresses/$addressId',
  token: token, )
  .then((value){
    newAddressModel = NewAddressModel.fromJson(value.data);
    if(newAddressModel.status==true) {
      getAddressData();
    } else{
      showToast(newAddressModel.message);
    }
    emit(ShopDeleteAddressSuccessStates());
  }).catchError((e){
    print('delete address ${e.toString()}');
    emit(ShopDeleteAddressErrorStates());
  });
}
  
  ///////////// product detail ///////////////
  GetProductDetailModel? getProductDetail;
  void getProductDetails({
    dynamic productId,
  }) {
    emit(ShopGetProductDetailLoadingStates());

    DioHelper.getData(url: 'products/$productId', token: token).then((value) {
      print(value.data);
      getProductDetail = GetProductDetailModel.fromJson(value.data);
//navigateTo(context, ProductDetailScreen());
      print(getProductDetail!.data!.id);
      if (getProductDetail != null) {
        emit(ShopGetProductDetailSuccessStates());

        //print(value.data);
      }
    }).catchError((e) {
      emit(ShopGetProductDetailErrorStates());
    });
  }

  CatDetailsModel? getCatDetail;

  void getCategoriesDetails({
    dynamic categoryId,
  }) {
    emit(ShopGetCategoryDetailLoadingStates());

    DioHelper.getData(url: 'products?category_id=$categoryId', token: token)
        .then((value) {
      print(value.data);
      getCatDetail = CatDetailsModel.fromJson(value.data);
//navigateTo(context, ProductDetailScreen());
      print(getCatDetail!.data!.data.length);
      if (getCatDetail != null) {
        emit(ShopGetCategoryDetailSuccessStates());

        //print(value.data);
      }
    }).catchError((e) {
      emit(ShopGetCategoryDetailErrorStates());
    });
  }

//// settings //////////

FAQsModel? faqsModel;

void getFAQSData(){
  DioHelper.getData(
    url: faqs,
    token: token).then((value){
      faqsModel = FAQsModel.fromJson(value.data);
      emit(ShopGetFAQSSuccessStates());
    }).catchError((e){
      print(e.toString());
    });
} 

ContactModel? contactModel;

void getContactData(){
  DioHelper.getData(
    url: contacts,
    token: token).then((value){
      contactModel = ContactModel.fromJson(value.data);
      emit(ShopGetFAQSSuccessStates());
    }).catchError((e){
      print(e.toString());
    });
} 

/////// User  ////////////
  late ShopLoginModel userData;
  void getUserData() {
    try {
      emit(ShopGetUserDataLoadingStates());
      DioHelper.getData(url: profile, token: token).then((value) {
        userData = ShopLoginModel.fromJson(value.data);
        // print(value.data);
        // print(userData.data);
        print(userData.message);

        if (userData != null) {
          emit(ShopGetUserDataSuccessStates());
        } else {
          emit(ShopGetUserDataErrorStates());
        }
      }).catchError((e) {
        print('error in get user data ${e.toString()}');
        emit(ShopGetUserDataErrorStates());
      });
    } catch (e) {
      print(e.toString());
    }
  }

  void updateUserData(String name, String email, String phone) {
    emit(ShopUpdateUserDataLoadingStates());
    DioHelper.putData(
            url: updatePprofile,
            data: {'name': name, 'email': email, 'phone': phone},
            token: token)
        .then((value) {
      userData = ShopLoginModel.fromJson(value.data);
      emit(ShopUpdateUserDataSuccessStates());
    }).catchError((e) {
      print('error in update user data ${e.toString()}');
      emit(ShopUpdateUserDataErrorStates());
    });
  }

  bool isDark = false;

  void changeMood({bool? sharedpref}) {
    if (sharedpref != null) {
      isDark = sharedpref;
      emit(NewsChangeMoodState());
    } else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeMoodState());
      });
    }
  }
}
