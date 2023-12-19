import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/product_detail.dart';
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
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
          ),
          body: ConditionalBuilder(
            condition: state is !ShopGetProductDetailLoadingStates && ShopCubit.get(context).getProductDetail != null  ,
             builder: (context)=>  productDetail(context,ShopCubit.get(context).getProductDetail?.data),
             fallback:(context)=> Center(child: CircularProgressIndicator(),)),
                   bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          child: Row(children: [
            SizedBox(
            height: 50,
            
              width: MediaQuery.of(context).size.width*0.15,
            child: FloatingActionButton(
              heroTag: 'fav',
              backgroundColor: Colors.grey[200],
    
              onPressed: (){},
              child: Icon(Icons.favorite,
              size: 30,
              color: defaultColor,),
              ),
    
            ),
            const Spacer(),
            SizedBox(
              height: 60,
              width: MediaQuery.of(context).size.width*0.75,
              child: FloatingActionButton(
                heroTag: 'add cart',
                backgroundColor: Colors.black87,
                onPressed: (){},
                child: Text('Add to Cart',
                style: GoogleFonts.notoSerif(
                  fontSize: 25,
                  color: Colors.white
                ),),),
                
            ),
    
          ]),
        ),
        
        );
      },
    );

  }

  Widget productDetail(context,Product? product){
    return Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.03),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsetsDirectional.only(start: 20),
                      decoration: BoxDecoration(
                       // color: Colors.red,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child:product?.image != null?  Image(
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: 300,
                          image: NetworkImage(
                              product!.image??'')):Container(),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * .05,
                    ),
                    Text(
                      product?.name??'',
                      style:
                          GoogleFonts.ptSerif(fontSize: 35, fontWeight: FontWeight.w500),
                    ),
                    Row(
                      children: [
                         Text(
                          product?.price.toString()??'',
                          style: TextStyle(
                            
                              fontSize: 28, fontWeight: FontWeight.w500),
                        ),
                        const Spacer(),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              color: Colors.grey[300]),
                          child: IconButton(
                              padding: const EdgeInsets.only(bottom: 0),
                              iconSize: 25,
                              color: Colors.black45,
                              onPressed: () {},
                              icon: const Icon(Icons.add)),
                        ),
                        const Text(
                          '01',
                          style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          width: 30,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              shape: BoxShape.rectangle,
                              color: Colors.grey[300]),
                          child: IconButton(
                              padding: const EdgeInsets.only(top: 12),
                              alignment: AlignmentDirectional.center,
                              iconSize: 22,
                              color: Colors.black45,
                              onPressed: () {},
                              icon: const Icon(Icons.maximize_rounded)),
                        )
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.02,
                    ),
                    Text(
                        product?.description??'',
                        style: GoogleFonts.notoSerif(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700]))
                  ],
                ),
              ),
            );
  
  }
}
