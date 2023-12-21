// ignore_for_file: unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/shopApp_component.dart';

class CategoriesDetailScreen extends StatelessWidget {
 final  String categoryName;
  const CategoriesDetailScreen({super.key,required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            backgroundColor: Colors.white,
            title: Text(
              categoryName
            ),
          ),
          body: ConditionalBuilder(
              condition: state is! ShopGetCategoryDetailLoadingStates,
              builder: (context) => ShopCubit.get(context)
                          .getCatDetail!
                          .data!
                          .data !=
                      null
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.03),
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                        mainAxisSpacing: 4,
                        crossAxisSpacing: 4,
                        childAspectRatio: 1 / 1.6,
                        children: List.generate(
                            ShopCubit.get(context).getCatDetail!.data!.data !=
                                    null
                                ? ShopCubit.get(context)
                                    .getCatDetail!
                                    .data!
                                    .data
                                    .length
                                : 0,
                            (index) => productItemBuilder(
                                ShopCubit.get(context)
                                    .getCatDetail!
                                    .data!
                                    .data[index],
                                context)),
                      ),
                    )
                  : Container(),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  )),
        );
      },
    );
  }
}
