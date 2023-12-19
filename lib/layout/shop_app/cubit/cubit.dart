// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/product_detail.dart';

import '../../../models/shop_app/add_remove_cart_model.dart';
import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/get_carts_model.dart';
import '../../../models/shop_app/get_favorites_model.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../models/shop_app/log_in_model.dart';
import '../../../modules/shop_app/categoris/categories_screen.dart';
import '../../../modules/shop_app/favorites/favorites_screen.dart';
import '../../../modules/shop_app/products/products_detail_screen.dart';
import '../../../modules/shop_app/products/products_screen.dart';
import '../../../modules/shop_app/settings/settings_screen.dart';
import '../../../shared/Constants/constants.dart';
import '../../../shared/components/taskCard.dart';
import '../../../shared/end_point.dart';
import '../../../shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialStates());

  static ShopCubit get(context) => BlocProvider.of(context);

  var currentIndex = 0;
  List<Widget> bottomScreens = [
    const ProductsScreen(),
    const CategoriesScreen(),
    const FavoritesScreen(),
    SettingsScreen()
  ];
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: 'Home'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.apps,
        ),
        label: 'Categories'),
    BottomNavigationBarItem(
        icon: Icon(
          Icons.favorite,
        ),
        label: 'Favorites'),
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

   HomeModel? homemodel;
  Map<int, bool> changeFav = {};
    Map<int, bool> changeCarts = {};



  void getHomeData() {
    emit(ShopHomeLoadingStates());
    DioHelper.getData(url: home, token: token).then((value) {
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

  void addRemoveCarts(dynamic productId) {
    try {
      changeCarts[productId] = !changeCarts[productId]!;
      emit(ShopChangeCartsStates());

      DioHelper.postData(
          url: carts,
          token: token,
          data: {
            'product_id': productId}).then((value) {
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

   GetProductDetailModel? getProductDetail;
  void getProductDetails({dynamic productId,context}) {
    emit(ShopGetProductDetailLoadingStates());

    DioHelper.getData(
      url:'products/$productId' ,
       token: token)
       .then((value) {
        print (value.data);
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
}
