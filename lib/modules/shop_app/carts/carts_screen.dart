import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/shopApp_component.dart';

class CartsScreen extends StatelessWidget {
  const CartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
              condition: state is! ShopGetCartsLoadingStates,
              builder: (context) =>
                  ShopCubit.get(context).getCartsmodel.data != null
                      ? GridView.count(
                          padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisCount: 2,
                          mainAxisSpacing: 3,
                          crossAxisSpacing: 3,
                          childAspectRatio: 1 / 1.6,
                          children: List.generate(
                              ShopCubit.get(context).getCartsmodel.data != null
                                  ? ShopCubit.get(context)
                                      .getCartsmodel
                                      .data!
                                      .cart_items
                                      .length
                                  : 0,
                              (index) => productItemBuilder(
                                  ShopCubit.get(context)
                                      .getCartsmodel
                                      .data!
                                      .cart_items[index]
                                      .product,
                                  context)),
                        )
                      : Container(),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  ));
     
      },
    );
  }
}
