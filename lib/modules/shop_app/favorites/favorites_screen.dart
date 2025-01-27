// ignore_for_file: unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/shopApp_component.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context).getFavmodel;
        return ConditionalBuilder(
            condition: cubit.data != null,
            builder: (context) => cubit.data!.data.isNotEmpty &&
                    cubit.data != null
                ? GridView.count(
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    mainAxisSpacing: 3,
                    crossAxisSpacing: 3,
                    childAspectRatio: 1 / 1.6,
                    children: List.generate(
                        cubit.data!.data != null
                            ? ShopCubit.get(context)
                                .getFavmodel
                                .data!
                                .data
                                .length
                            : 0,
                        (index) => productItemBuilder(
                            cubit.data?.data[index].product, context)),
                  )
                : Center(
                    child: Text(
                      'No Favorite product yet ',
                      style: TextStyle(fontSize: 28, color: Colors.grey[400]),
                    ),
                  ),
            fallback: (context) {
              return Center(
                child: Text(
                  'No Favorite product yet ',
                  style: TextStyle(fontSize: 28, color: Colors.grey[400]),
                ),
              );
            });
      },
    );
  }
}
