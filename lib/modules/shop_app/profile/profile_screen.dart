// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/shop_app/profileModels/log_in_model.dart';
import 'package:shop_app/modules/shop_app/setting/setting_screen.dart';
import 'package:shop_app/shared/components/taskCard.dart';

import '../../../layout/shop_app/cubit/cubit.dart';
import '../../../layout/shop_app/cubit/states.dart';
import '../../../shared/Constants/constants.dart';
import '../../../shared/components/customized_form.dart';
import '../../../shared/styles/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userData = ShopCubit.get(context).userData;
        final GlobalKey<FormState> formkey = GlobalKey<FormState>();
        var nameController = TextEditingController();
        var emailController = TextEditingController();
        var phoneController = TextEditingController();
        nameController.text = userData.data?.name ?? '';
        emailController.text = userData.data?.email ?? '';
        phoneController.text = userData.data?.phone ?? '';
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded),
              onPressed: () => Navigator.pop(context),
            ),
            title: Text(
              'Your Personal Info',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: defaultColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 30),
            ),
          ),
          body: ConditionalBuilder(
              condition: state is! ShopGetUserDataLoadingStates,
              builder: (context) => Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: MediaQuery.of(context).size.width * 0.04),
                    child: Form(
                      key: formkey,
                      child: SingleChildScrollView(
                        child: Column(children: [
                          if (state is ShopUpdateUserDataLoadingStates)
                            const LinearProgressIndicator(),
                          CustomizedFormField(
                              labelText: 'Name',
                              prefixIcon: Icons.person,
                              validate: (value) {
                                if (value!.isEmpty)
                                  return 'name must not be empty';
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
                                if (value!.isEmpty)
                                  return 'email must not be empty';
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
                                if (value!.isEmpty)
                                  return 'phone must not be empty';
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
                    child: CircularProgressIndicator(),
                  )),
        );
      },
    );
  }
}
