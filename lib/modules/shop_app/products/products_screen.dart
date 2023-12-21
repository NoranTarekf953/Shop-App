// ignore_for_file: unnecessary_null_comparison

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/categoris/categories_detail_screen.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../models/shop_app/categories_model.dart';
import '../../../models/shop_app/home_model.dart';
import '../../../shared/Constants/constants.dart';
import '../../../shared/components/shopApp_component.dart';
import '../../../shared/components/taskCard.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopChangeFavoritesSuccessStates) {
          if (state.model.status == false && token == null) {
            flutterToast(msg: state.model.message, state: ToastState.error);
          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
            condition: ShopCubit.get(context).homemodel != null &&
                ShopCubit.get(context).catmodel != null,
            builder: (context) => productHomeBuilder(
                ShopCubit.get(context).homemodel,
                context,
                ShopCubit.get(context).catmodel),
            fallback: (context) => const Center(
                  child: CircularProgressIndicator(),
                ));
      },
    );
  }

  Widget productHomeBuilder(
      HomeModel? model, context, CategoryModel? categoryModel) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                CarouselSlider(
                    items: model!.data.banners
                        .map((e) => Image(
                              image: NetworkImage(e.image),
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ))
                        .toList(),
                    options: CarouselOptions(
                        height: 250,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        viewportFraction: 1.0,
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration: const Duration(seconds: 1),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal)),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  'Categories',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                ),
                Container(
                  height: MediaQuery.of(context).size.width * 0.3,
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => InkWell(
                          onTap: () {
                            ShopCubit.get(context).getCategoriesDetails(
                                categoryId: categoryModel.data.data[index].id);
                            state is! ShopGetCategoryDetailLoadingStates
                                ? navigateTo(context, CategoriesDetailScreen( categoryName: categoryModel.data.data[index].name,))
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                          child: categoriesHomeItems(
                              context, categoryModel.data.data[index])),
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 5,
                          ),
                      itemCount: categoryModel!.data.data.length),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text(
                  'New Products',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 24),
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  mainAxisSpacing: MediaQuery.of(context).size.width * 0.029,
                  crossAxisSpacing: MediaQuery.of(context).size.width * 0.029,
                  childAspectRatio: 1 / 1.6,
                  children: List.generate(
                      model.data.products.length,
                      (index) => productItemBuilder(
                          model.data.products[index], context)),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget categoriesHomeItems(context, CatDataDataModel model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
          image: NetworkImage(model.image),
          fit: BoxFit.cover,
          height: MediaQuery.of(context).size.width * 0.3,
          width: MediaQuery.of(context).size.width * 0.38,
        ),
        Container(
          width: MediaQuery.of(context).size.width * 0.38,
          color: Colors.grey[400],
          child: Text(
            model.name,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        )
      ],
    );
  }
}
