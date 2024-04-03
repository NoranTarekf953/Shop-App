import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/models/shop_app/settings/faqs_model.dart';

import '../../../shared/styles/colors.dart';

class FAQsScreen extends StatelessWidget {
  const FAQsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'FAQs',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: defaultColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            ),
          ),
          body: Padding(
            padding: EdgeInsets.all(15),
            child:ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index)=> FAQsItemBuilder(model:cubit.faqsModel!.data!.faqsItem[index]),
               separatorBuilder: (context,index)=> SizedBox(height: 10,),
                itemCount: cubit.faqsModel!.data!.faqsItem.length),
          ),
        );
      },
    );
  }
}

class FAQsItemBuilder extends StatefulWidget {
  FAQsItem model;
   FAQsItemBuilder({
    super.key,
    required this.model
  });

  @override
  // ignore: no_logic_in_create_state
  State<FAQsItemBuilder> createState() => _FAQsItemBuilderState(model: model);
}

class _FAQsItemBuilderState extends State<FAQsItemBuilder> {
  bool isTapped = true;
  FAQsItem model;
  
  _FAQsItemBuilderState({required this.model});

  @override
  Widget build(BuildContext context) {
 var cubit = ShopCubit.get(context);

    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ExpansionTileTheme(
              data: ExpansionTileThemeData(
                  shape: Border.all(color: Colors.transparent)),
              child: ExpansionTile(
                childrenPadding: EdgeInsets.all(0),
                tilePadding: const EdgeInsets.all(0),
                onExpansionChanged: (value) {
                  setState(() {
                    value = !value;
                    isTapped = value;
                  });
                },
                trailing: isTapped == true
                    ? Icon(
                        Icons.keyboard_arrow_down_rounded,
                        color: defaultColor,
                      )
                    : Icon(
                        Icons.keyboard_arrow_up_rounded,
                        color: defaultColor,
                      ),
                title: Text(
                  model.question??'',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                children: [
                  Text(
                    model.answer??'',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w400,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
