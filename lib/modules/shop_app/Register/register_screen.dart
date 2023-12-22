// ignore_for_file: avoid_print

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';


import '../../../layout/shop_app/shop_app_screen.dart';
import '../../../shared/Constants/constants.dart';
import '../../../shared/components/customized_form.dart';
import '../../../shared/components/taskCard.dart';
import '../../../shared/network/local/cache_helper.dart';
import '../../../shared/styles/colors.dart';
import '../log_in/logIn_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
   RegisterScreen({super.key});
final emailController = TextEditingController();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final passwordController = TextEditingController();
    final confirmpasswordController = TextEditingController();

    final nameController = TextEditingController();

  final phoneController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterShopCubit(),
      child: BlocConsumer<RegisterShopCubit, RegisterShopStates>(
        listener: (context, state) {
          if (state is RegisterShopSuccessStates) {
            // عشان الستاتس  حتى لو غلط ومش متسجل مش هيعتبره ايرور
            //فلازم اتاكد من الstatus
            //اللي جوا الريسبونس بتاعي

            if (state.loginModel.status!) {
              print(state.loginModel.message);
              print(state.loginModel.data!.token);
              CacheHelper.saveData(
                      key: 'token',
                       value: state.loginModel.data!.token)
                  .then((value) {
                    token  = state.loginModel.data!.token;
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
          if (state is RegisterShopErrorStates ) {
            // عشان الستاتس  حتى لو غلط ومش متسجل مش هيعتبره ايرور
            //فلازم اتاكد من الstatus
            //اللي جوا الريسبونس بتاعي

            if (!state.loginModel.status! && state.loginModel.data == null) {
              print(state.loginModel.message);
              flutterToast(
                  msg: state.loginModel.message!,
                  context: context,
                  state: ToastState.error);
                 
            }
              
            
          }
        },
        builder: (context, state) => Scaffold(
          appBar: AppBar(leading: Container(),),
          body: SingleChildScrollView(
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width *
                                      0.06,),
              child: Center(
                child: Form(
                  key: formkey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'WELCOME',
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge!
                            .copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                                fontSize:  MediaQuery.of(context).size.height *
                                    0.05),
                      ),
                       SizedBox(
                        height: MediaQuery.of(context).size.height *
                                      0.05,
                      ),
                       CustomizedFormField(
                          labelText: 'name',
                          prefixIcon: Icons.person,
                          textType: TextInputType.text,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'name must not be empty';
                            }
                            return null;
                          },
                          controller: nameController),
                       SizedBox(
                        height: MediaQuery.of(context).size.height *
                                      0.04,
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
                       SizedBox(
                        height: MediaQuery.of(context).size.height *
                                      0.04,
                      ),
                      
                     
                      CustomizedFormField(
                          labelText: 'phone',
                          prefixIcon: Icons.phone,
                          textType: TextInputType.phone,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'phone must not be empty';
                            }
                            return null;
                          },
                          controller: phoneController),
                       SizedBox(
                        height: MediaQuery.of(context).size.height *
                                      0.04,
                      ),
                      CustomizedFormField(
                          labelText: 'password',
                          prefixIcon: Icons.password,
                          textType: TextInputType.text,
                          suffixIcon: RegisterShopCubit.get(context).suffix,
                          
                          onTapSuffix: () {
                            RegisterShopCubit.get(context).changePasswordVisible();
                          },
                          secure: RegisterShopCubit.get(context).isPassword,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                          controller: passwordController),
                       SizedBox(
                        height: MediaQuery.of(context).size.height *
                                      0.04,
                      ),
                      CustomizedFormField(
                          labelText: 'confirm password',
                          prefixIcon: Icons.password,
                          textType: TextInputType.text,
                          suffixIcon: RegisterShopCubit.get(context).suffix,
                          
                          onTapSuffix: () {
                            RegisterShopCubit.get(context).changePasswordVisible();
                          },
                          secure: RegisterShopCubit.get(context).isPassword,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'password must not be empty';
                            }
                            return null;
                          },
                          controller: confirmpasswordController),
                        SizedBox(
                        height: MediaQuery.of(context).size.height *
                                      0.05,
                      ),
                      ConditionalBuilder(
                          condition: state is !RegisterShopLoadingStates || state is RegisterShopErrorStates,
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
                                    RegisterShopCubit.get(context).registerUser(
                                     name: nameController.text,
                                      email:  emailController.text,
                                      password:  passwordController.text,                           
                                      phone:  phoneController.text);
                                  }
                                },
                                child: Text(
                                  'SIGN UP ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall!
                                      .copyWith(color: Colors.white),
                                ),
                              )),
                          fallback: (context) => Center(
                                child: CircularProgressIndicator(
                                    color: defaultColor),
                              )),
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                        Text('Already have account ?',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: MediaQuery.of(context).size.width *
                                      0.04
                        ),),
                        TextButton(onPressed: (){
                          navigateTo(context, LogIn_Screen());
                        }, child: Text('SIGN IN',
                        style: GoogleFonts.poppins(
                          color: defaultColor,
                          fontWeight: FontWeight.w500,
                          fontSize: MediaQuery.of(context).size.width *
                                      0.045
                        ),),)
                      ],)
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