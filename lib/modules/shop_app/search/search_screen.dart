import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/search/cubit/cubit.dart';

import '../../../shared/components/buildArticle.dart';
import '../../../shared/components/customized_form.dart';
import '../../../shared/components/shopApp_component.dart';
import 'cubit/states.dart';

class ShopSearchScreen extends StatelessWidget {
  ShopSearchScreen({super.key});
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocProvider(
        create: (context) => SearchCubit(),
        child: BlocConsumer<SearchCubit, SearchStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    RoundedFormField(
                        labelText: 'Search',
                        prefixIcon: Icons.search,
                        textType: TextInputType.text,
                        validate: (String? value) {
                          if (value!.isEmpty) return 'search must not be empty';
                          return null;
                        },
                        controller: searchController,
                        onChange: (text) {
                          SearchCubit.get(context).searchFun(text);
                        },
                        onSubmit: (text) {
                          SearchCubit.get(context).searchFun(text);
                        }),
                    if (state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    if (state is SearchSuccesslState)
                      Expanded(
                        child: ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) =>
                                SearchCubit.get(context).searchModel != null
                                    ? productListBuilder(
                                        context,
                                        SearchCubit.get(context)
                                            .searchModel!
                                            .data!
                                            .data[index],
                                        isSearch: true)
                                    : const Text('Loading...'),
                            separatorBuilder: (context, index) => myDivider(),
                            itemCount:
                                SearchCubit.get(context).searchModel != null
                                    ? SearchCubit.get(context)
                                        .searchModel!
                                        .data!
                                        .data
                                        .length
                                    : 0),
                      )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
