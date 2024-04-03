// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/Constants/constants.dart';
import '../../../shared/components/customized_form.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userData = ShopCubit.get(context).userData;
        nameController.text = userData.data!.name;
        emailController.text = userData.data!.email;
        phoneController.text = userData.data!.phone;

        return Scaffold(
          appBar: AppBar(),
          body:  ConditionalBuilder(
              condition: ShopCubit.get(context).userData != null,
              builder: (context) => Padding(
                    padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.04),
                    child: Form(
                      key: formkey,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          if(state is ShopUpdateUserDataLoadingStates)
                            const LinearProgressIndicator(),
                          CustomizedFormField(
                              labelText: 'Name',
                              prefixIcon: Icons.person,
                              validate: (value) {
                                if(value!.isEmpty) return 'name must not be empty';
                                return null;
                              },
                              controller: nameController),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          CustomizedFormField(
                              labelText: 'E-mail',
                              textType: TextInputType.emailAddress,
                              prefixIcon: Icons.email_outlined,
                              validate: (value) {
                                                            if(value!.isEmpty) return 'email must not be empty';
                                                            return null;
                        
                              },
                              controller: emailController),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          CustomizedFormField(
                              labelText: 'Phone',
                              prefixIcon: Icons.phone,
                              textType: TextInputType.phone,
                              validate: (value) {
                                                            if(value!.isEmpty) return 'phone must not be empty';
                                                            return null;
                        
                              },
                              controller: phoneController),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.15),
                            child: ElevatedButton(
                                onPressed: () {
                                  logOut(context);
                                },
                                child: const Text(
                                  'Log out',
                                  style: TextStyle(fontSize: 18),
                                )),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04,
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.15),
                            child: ElevatedButton(
                                onPressed: () {
                                  ShopCubit.get(context).updateUserData(
                                    nameController.text,
                                     emailController.text,
                                      phoneController.text);
                                },
                                child: const Text(
                                  'Update',
                                  style: TextStyle(fontSize: 18),
                                )),
                          ),
                        ]),
                      ),
                    ),
                  ),
              fallback: (context) => const Center(
                    child:CircularProgressIndicator(),
                  )),
        );
      },
    );
  }
}
