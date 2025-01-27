import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/components/shopApp_component.dart';
import '../../../shared/styles/colors.dart';

class CartsScreen extends StatelessWidget {
  const CartsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              flex: 2,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (state is ShopGetCartsLoadingStates)
                      const LinearProgressIndicator(),
                    ConditionalBuilder(
                        condition: state is! ShopGetCartsLoadingStates &&
                            ShopCubit.get(context).getCartsmodel.data != null,
                        builder: (context) => ShopCubit.get(context)
                                .getCartsmodel
                                .data!
                                .cart_items
                                .isNotEmpty
                            ? ListView.separated(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount:
                                    ShopCubit.get(context).getCartsmodel.data !=
                                            null
                                        ? ShopCubit.get(context)
                                            .getCartsmodel
                                            .data!
                                            .cart_items
                                            .length
                                        : 0,
                                itemBuilder: (context, index) => cartProduct(
                                    ShopCubit.get(context)
                                        .getCartsmodel
                                        .data
                                        ?.cart_items[index],
                                    context),
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(
                                  height: 10,
                                ),
                              )
                            : Center(
                                child: Text(
                                  'No products in cart yet ',
                                  style: TextStyle(
                                      fontSize: 28, color: Colors.grey[400]),
                                ),
                              ),
                        fallback: (context) => Center(
                              child: Text(
                                'No products in cart yet ',
                                style: TextStyle(
                                    fontSize: 28, color: Colors.grey[400]),
                              ),
                            )),
                    Container(
                      //height: 100,
                      color: Colors.grey[200],
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  'Subtotal (${ShopCubit.get(context).getCartsmodel.data?.cart_items.length ?? 0} item)',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                Text(
                                  '${ShopCubit.get(context).getCartsmodel.data?.sub_total.toString() ?? '0'}',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.038,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[500],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Shipping Fee ',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                Text(
                                  'Free',
                                  style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.038,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.grey[500],
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text(
                                  'Total',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                                const Spacer(),
                                Text(
                                  '${ShopCubit.get(context).getCartsmodel.data?.total.toString() ?? '0'}',
                                  style: TextStyle(
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.039,
                                      fontWeight: FontWeight.w600,
                                      color: defaultColor),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.15),
                child: ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      'Checkout',
                      style: TextStyle(fontSize: 18),
                    )),
              ),
            ),
          ],
        );
      },
    );
  }
}
