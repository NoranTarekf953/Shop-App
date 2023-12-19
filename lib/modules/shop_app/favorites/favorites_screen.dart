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
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return ConditionalBuilder(
        condition: state is !ShopGetFavLoadingStates &&  ShopCubit.get(context).getFavmodel.data!.data != [],
         builder: (context)=> 
           ShopCubit.get(context).getFavmodel.data!.data != null?
          GridView.count(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              mainAxisSpacing: 3,
              crossAxisSpacing: 3,
              childAspectRatio: 1 / 1.6,
              children: List.generate(
                  ShopCubit.get(context).getFavmodel.data!.data != null
                          ? ShopCubit.get(context).getFavmodel!.data!.data.length
                          : 0,
                  (index) =>
                      productItemBuilder(ShopCubit.get(context).getFavmodel.data!.data[index].product, context)),
            ):
          Container(),
                 
           
          fallback:(context)=>const Center(child: CircularProgressIndicator(),) );
      },
    ); }



  }
