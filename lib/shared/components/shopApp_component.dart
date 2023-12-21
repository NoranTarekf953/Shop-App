// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/modules/shop_app/products/products_detail_screen.dart';
import 'package:shop_app/shared/components/taskCard.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../styles/colors.dart';

Widget productListBuilder(context, model, {bool isSearch = true}) {
  return Container(
      height: MediaQuery.of(context).size.width * 0.3,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          Stack(
            alignment: Alignment.bottomLeft,
            children: [
              Image(
                image: NetworkImage(model!.image!),
                width: 120,
                height: 120,
              ),
              if (!isSearch)
                model.discount != 0
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        color: Colors.red[400],
                        child: const Text(
                          'Discount',
                          style: TextStyle(fontSize: 14, color: Colors.white),
                        ),
                      )
                    : Container()
            ],
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  model.name!,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.045,
                  ),
                ),
                Expanded(
                  child: Row(
                    children: [
                      Text(
                        '${model.price}\$',
                        style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width * 0.043,
                            fontWeight: FontWeight.w600),
                      ),
                      const Spacer(),
                      if (!isSearch)
                        if (model.discount != 0)
                          Text(
                            '${model.oldPrice}\$',
                            style: TextStyle(
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.043,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[500],
                                decoration: TextDecoration.lineThrough),
                          ),
                      const Spacer(),
                      CircleAvatar(
                        radius: 18,
                        backgroundColor:
                            ShopCubit.get(context).changeFav[model.id] == true
                                ? defaultColor.shade200
                                : Colors.grey[400],
                        child: IconButton(
                            onPressed: () {
                              ShopCubit.get(context).changeFavorites(model.id);
                            },
                            icon: const Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 20,
                            )),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ],
      ));
}

Widget productItemBuilder(product, context) {
  return BlocConsumer<ShopCubit,ShopStates>(
    listener: (context, state) {
      
    },
    builder: (context, state) {
      return Container(
    color: Colors.white,
    width: double.infinity,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              ShopCubit.get(context)
                  .getProductDetails(productId: product.id);

                 state is !ShopGetProductDetailLoadingStates  
                 ?navigateTo(context, const ProductDetailScreen()):
                 const Center(child: CircularProgressIndicator(),);
             // navigateTo(context, ProductDetailScreen());
              //print(product.id);
            },
            child: Stack(
              alignment: Alignment.bottomLeft,
              children: [
                Image(
                  image: NetworkImage(product!.image!),
                  width: double.infinity,
                  height: MediaQuery.of(context).size.width * 0.4,
                ),
                product.discount != 0
                    ? Container(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.02),
                        color: Colors.red[400],
                        child: Text(
                          'Discount',
                          style: TextStyle(
                              fontSize:
                                  MediaQuery.of(context).size.width * 0.035,
                              color: Colors.white),
                        ))
                    : Container(),
              ],
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.02,
        ),
        Text(
          product.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
              fontSize: MediaQuery.of(context).size.width * 0.036,
              color: Colors.black,
              fontWeight: FontWeight.w500),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.width * 0.01,
        ),
        Row(
          children: [
            Column(
              children: [
                Text(
                  '${product.price.round()}\$',
                  style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width * 0.035,
                      fontWeight: FontWeight.w600,
                      color: defaultColor),
                ),
                // const Spacer(),
                if (product.discount != 0)
                  Text(
                    '${product.oldPrice.round()}\$',
                    style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width * 0.032,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[500],
                        decoration: TextDecoration.lineThrough),
                  ),
              ],
            ),
            const Spacer(),
  
            ShopCubit.get(context).changeCarts[product.id] == false
                ? IconButton(
                    onPressed: () {
                      ShopCubit.get(context).addRemoveCarts(product.id);
                    },
                    icon: Icon(
                      Icons.shopping_bag_outlined,
                      color: Colors.black,
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      ShopCubit.get(context).addRemoveCarts(product.id);
                    },
                    icon: Icon(
                      Icons.shopping_bag,
                      color: defaultColor.shade200,
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                  ),
            //  SizedBox( width: 2,),
            ShopCubit.get(context).changeFav[product.id] == false
                ? IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(product.id);
                    },
                    icon: Icon(
                      Icons.favorite_outline,
                      color: Colors.black,
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                  )
                : IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(product.id);
                    },
                    icon: Icon(
                      Icons.favorite_rounded,
                      color: defaultColor.shade200,
                      size: MediaQuery.of(context).size.width * 0.07,
                    ),
                  ),
          ],
        )
      ],
    ),
  );
  
    },);}

/// **************************************************************************

Widget categoriesBuilder(model) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10),
    child: Row(
      children: [
        Image(
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            image: NetworkImage(model.image)),
        const SizedBox(
          width: 10,
        ),
        Text(
          model.name,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
        const Spacer(),
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.arrow_forward_ios_rounded,
              color: defaultColor,
            ))
      ],
    ),
  );
}
