import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/homeModels/product_detail.dart';
import 'package:shop_app/shared/styles/colors.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: ConditionalBuilder(
              condition: state is! ShopGetProductDetailLoadingStates &&
                  ShopCubit.get(context).getProductDetail != null,
              builder: (context) => productDetail(
                  context, ShopCubit.get(context).getProductDetail?.data),
              fallback: (context) => const Center(
                    child: CircularProgressIndicator(),
                  )),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(children: [
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width * 0.15,
                child: FloatingActionButton(
                  heroTag: 'fav 1',
                  backgroundColor: Colors.grey[200],
                  onPressed: () {
                    ShopCubit.get(context).changeFavorites(
                        ShopCubit.get(context).getProductDetail?.data!.id);
                  },
                  child: ShopCubit.get(context).changeFav[ShopCubit.get(context)
                              .getProductDetail
                              ?.data!
                              .id] ==
                          false
                      ? const Icon(
                          Icons.favorite_outline,
                          size: 30,
                          color: Colors.black,
                        )
                      : Icon(
                          Icons.favorite,
                          size: 30,
                          color: defaultColor,
                        ),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width * 0.75,
                child: FloatingActionButton(
                  heroTag: 'add cart',
                  backgroundColor: ShopCubit.get(context).changeCarts[ShopCubit.get(context)
                              .getProductDetail
                              ?.data!
                              .id]== false?
                              Colors.grey[200]: defaultColor,
                  onPressed: () {
                    ShopCubit.get(context).addRemoveCarts(
                         ShopCubit.get(context).getProductDetail?.data!.id);
                  },
                  child: ShopCubit.get(context).changeCarts[ShopCubit.get(context)
                              .getProductDetail
                              ?.data!
                              .id]== false?
                  Text(
                    'Add to Cart',
                    style: GoogleFonts.notoSerif(
                        fontSize: 25, color: Colors.black),
                  ):Text(
                    'Added to Cart',
                    style: GoogleFonts.notoSerif(
                        fontSize: 25, color: Colors.white),
                  ),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }

  Widget productDetail(context, Product? product) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: product!.images
                  .map((e) => Image(
                        image: NetworkImage(e),
                        width: double.infinity,
                        // height:  MediaQuery.of(context).size.height * 0.2,
                      ))
                  .toList(),
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height * 0.28,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  viewportFraction: 1.0,
                  reverse: false,
                  autoPlay: true,
                  pauseAutoPlayOnTouch: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal)),
          SizedBox(
            height: MediaQuery.of(context).size.height * .05,
          ),
          Expanded(
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.04,
                    vertical: MediaQuery.of(context).size.width * 0.04),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color.fromARGB(243, 245, 245, 245),
                ),
                child: SingleChildScrollView(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name ?? '',
                          style: GoogleFonts.ptSerif(
                              fontSize: MediaQuery.of(context).size.width * .06,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Text(
                              '${product.price.round()}\$',
                              style: TextStyle(
                                  color: defaultColor,
                                  fontSize:
                                      MediaQuery.of(context).size.width * .055,
                                  fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            if (product.discount != 0)
                              Text(
                                '${product.oldPrice.round()}\$',
                                style: TextStyle(
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.05,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey[500],
                                    decoration: TextDecoration.lineThrough),
                              ),
                            const Spacer(),
                           ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text('Overview',
                            style: GoogleFonts.notoSerif(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Colors.black)),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02,
                        ),
                        Text(product.description ?? '',
                            style: GoogleFonts.notoSerif(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[700]))
                      ]),
                )),
          ),
        ],
      ),
    );
  }
}
