import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/modules/shop_app/addresses/addresses_screen.dart';
import 'package:shop_app/shared/components/taskCard.dart';

import '../../../shared/components/customized_form.dart';
import '../../../shared/styles/colors.dart';

class AddNewAddressesScreen extends StatelessWidget {
  bool isEdit = false;
  final int? addressId;
  final String? name;
  final String? city;
  final String? region;
  final String? detail;
  final String? notes;
  AddNewAddressesScreen(
      {super.key,
      required this.isEdit,
      this.addressId,
      this.name,
      this.city,
      this.region,
      this.detail,
      this.notes});
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final locationNameController = TextEditingController();
  final cityController = TextEditingController();
  final regionController = TextEditingController();
  final detailController = TextEditingController();
  final notesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopAddNewAddressSuccessStates ||
            state is ShopUpdateAddressSuccessStates) {
          navigateTo(context, const AddressScreen());
        }
      },
      builder: (context, state) {
        if (isEdit == true) {
          locationNameController.text = name!;
          cityController.text = city!;
          regionController.text = region!;
          detailController.text = detail!;
          notesController.text = notes!;
        }
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: 90,
            backgroundColor: Colors.white,
            leading: Container(),
            leadingWidth: 0,
            title: Row(
              children: [
                Icon(
                  Icons.shopping_cart_outlined,
                  color: defaultColor,
                  size: 45,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  'Sala',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: defaultColor,
                      fontWeight: FontWeight.w700,
                      fontSize: 45),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Cancel',
                    style: Theme.of(context)
                        .textTheme
                        .labelSmall!
                        .copyWith(fontSize: 15, color: Colors.grey[500]),
                  ))
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (state is ShopAddNewAddressLoadingStates)
                        const LinearProgressIndicator(),
                      const Text(
                        'Location Name',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      CustomizedFormField(
                          labelText: 'Please enter Location Name',
                          textType: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'location name must not be empty';
                            }
                            return null;
                          },
                          controller: locationNameController),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      const Text(
                        'City ',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      CustomizedFormField(
                          labelText: 'Please enter City Name',
                          textType: TextInputType.emailAddress,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'city name must not be empty';
                            }
                            return null;
                          },
                          controller: cityController),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      const Text(
                        'City Region',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      CustomizedFormField(
                          labelText: 'Please enter Region Name',
                          textType: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'Region must not be empty';
                            }
                            return null;
                          },
                          controller: regionController),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      const Text(
                        'Details',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      CustomizedFormField(
                          labelText: 'Please enter some Details',
                          textType: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'details must not be empty';
                            }
                            return null;
                          },
                          controller: detailController),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),
                      const Text(
                        'Notes',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      CustomizedFormField(
                          labelText: 'Please add some notes to help find you',
                          textType: TextInputType.text,
                          validate: (value) {
                            if (value!.isEmpty) {
                              return 'notes must not be empty';
                            } else {
                              value = '';
                            }
                            return null;
                          },
                          controller: notesController),
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
                              if (formkey.currentState!.validate()) {
                                if (isEdit == false) {
                                  ShopCubit.get(context).addNewAddressData(
                                      name: locationNameController.text,
                                      city: cityController.text,
                                      region: regionController.text,
                                      details: detailController.text,
                                      notes: notesController.text);
                                } else {
                                  ShopCubit.get(context).updateAddressData(
                                      id: addressId!,
                                      name: locationNameController.text,
                                      city: cityController.text,
                                      region: regionController.text,
                                      details: detailController.text,
                                      notes: notesController.text);
                                }
                              }
                            },
                            child: const Text(
                              'Save Address',
                              style: TextStyle(fontSize: 18),
                            )),
                      ),
                    ]),
              ),
            ),
          ),
        );
      },
    );
  }
}
