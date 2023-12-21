import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';

import '../../modules/shop_app/carts/carts_screen.dart';
import '../../modules/shop_app/search/search_screen.dart';
import '../../shared/components/taskCard.dart';
import '../../shared/styles/colors.dart';

class ShopAppScreen extends StatelessWidget {
  const ShopAppScreen({super.key});
  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).currentIndex = 0;

    return BlocConsumer<ShopCubit, ShopStates>(
        builder: (context, state) {
          var cubit = ShopCubit.get(context);
          return Scaffold(
              appBar: AppBar(
                toolbarHeight: 90,
                backgroundColor: Colors.white,
                title: Row(
                  children: [
                    Icon(Icons.shopping_cart_outlined, color: defaultColor,size: 50,),
                    const SizedBox(width: 5,),
                    Text(
                      'Sala',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                          color: defaultColor,
                          fontWeight: FontWeight.w700,
                          fontSize: 50),
                    ),
                  ],
                ),
                actions: [
                  IconButton(
                      iconSize: 30,
                      color: defaultColor.shade900,
                      onPressed: () => navigateTo(context, ShopSearchScreen()),
                      icon: const Icon(Icons.search)),
                  IconButton(
                      iconSize: 30,
                      color: defaultColor.shade900,
                      onPressed: () => navigateTo(context, const CartsScreen()),
                      icon: const Icon(Icons.shopping_bag_outlined))
                ],
              ),
              bottomNavigationBar: BottomNavigationBar(
                backgroundColor: Colors.white,
                unselectedItemColor: Colors.grey[500],
                unselectedLabelStyle: TextStyle(color: Colors.grey[600],
                fontWeight: FontWeight.w400),
                elevation: 5,
                  onTap: (index) {
                    cubit.changeNavIndex(index: index);
                  },
                  currentIndex: cubit.currentIndex,
                  items: cubit.items),
              body: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.03),
                child: cubit.bottomScreens[cubit.currentIndex],
              ));
        },
        listener: (context, state) {});
  }
}
