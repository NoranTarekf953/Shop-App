// ignore_for_file: file_names, avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/modules/shop_app/log_in/cubit/states.dart';


import '../../../layout/shop_app/shop_app_screen.dart';
import '../../../shared/Constants/constants.dart';
import '../../../shared/components/customized_form.dart';
import '../../../shared/components/taskCard.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../Register/register_screen.dart';
import 'cubit/cubit.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

// ignore: camel_case_types
class LogIn_Screen extends StatelessWidget {
  LogIn_Screen({super.key});

  final emailController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginShopCubit(),
      child: BlocConsumer<LoginShopCubit, LoginShopStates>(
        listener: (context, state) {
          if (state is LoginShopSuccessStates) {
            // عشان الستاتس  حتى لو غلط ومش متسجل مش هيعتبره ايرور
            //فلازم اتاكد من الstatus
            //اللي جوا الريسبونس بتاعي

            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                      key: 'token', value: state.loginModel.data!.token)
                  .then((value) {
                token = state.loginModel.data!.token;
                navigateAndFinish(context,  const ShopAppScreen());
              });
            } else {
              print(state.loginModel.message);
              flutterToast(
                  msg: state.loginModel.message!,
                  context: context,
                  state: ToastState.error);
            }
          }
          else if(state is LoginShopErrorStates){
              print(state.loginModel.message);
              flutterToast(
                  msg: state.loginModel.message!,
                  context: context,
                  state: ToastState.error);
            }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(leading: Container(),),
          body: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.06),
              child: Center(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Hello !',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                color: Colors.grey[400],
                                fontWeight: FontWeight.w400,
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.12),
                      ),
                      Text('WELCOME BACK',
                          style: Theme.of(context)
                              .textTheme
                              .headlineLarge!
                              .copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.12)),
                      const SizedBox(
                        height: 40,
                      ),
                      CustomizedFormField(
                          labelText: 'e-mail',
                          prefixIcon: Icons.email,
                          textType: TextInputType.emailAddress,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Email must not be empty';
                            }
                            return null;
                          },
                          controller: emailController),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomizedFormField(
                          labelText: 'password',
                          prefixIcon: Icons.password,
                          textType: TextInputType.text,
                          suffixIcon: LoginShopCubit.get(context).suffix,
                          onSubmit: (value) {
                            if (formkey.currentState!.validate()) {
                              LoginShopCubit.get(context).loginUser(
                                  emailController.text,
                                  passwordController.text);
                            }
                          },
                          onTapSuffix: () {
                            LoginShopCubit.get(context).changePasswordVisible();
                          },
                          secure: LoginShopCubit.get(context).isPassword,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                          controller: passwordController),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: TextButton(
                            onPressed: () {},
                            child: Text(
                              'Forgot Password',
                              style: TextStyle(
                                  color: Colors.black87,
                                  fontSize: MediaQuery.of(context).size.width *
                                      0.045),
                            )),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                          condition: state is !LoginShopLoadingStates,
                          builder: (context) => Container(
                              padding: const EdgeInsetsDirectional.all(10),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(25),
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  color: defaultColor),
                              child: MaterialButton(
                                onPressed: () {
                                  if (formkey.currentState!.validate()) {
                                    LoginShopCubit.get(context).loginUser(
                                        emailController.text,
                                        passwordController.text);
                                  }
                                },
                                child: Text(
                                  'SIGN IN ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(color: Colors.white),
                                ),
                              )),
                          fallback: (context) => Center(
                                child: CircularProgressIndicator(
                                    color: defaultColor)
                                    ,
                              )),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: const EdgeInsetsDirectional.all(10),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: Border.all(color: Colors.grey.shade200),
                              color: Colors.white),
                          child: MaterialButton(
                            onPressed: () {
                              navigateTo(context, RegisterScreen());
                            },
                            elevation: 0,
                            focusColor: Colors.grey[200],
                            color: Colors.white,
                            child: Text(
                              'SIGN UP ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(color: Colors.black),
                            ),
                          )),
                
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
