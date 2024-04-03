import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/layout/shop_app/shop_app_screen.dart';
import 'package:shop_app/models/shop_app/addressModels/address_model.dart';
import 'package:shop_app/modules/shop_app/addresses/addNewAddress_screen.dart';
import 'package:shop_app/shared/components/shopApp_component.dart';
import 'package:shop_app/shared/components/taskCard.dart';

import '../../../shared/styles/colors.dart';

class AddressScreen extends StatelessWidget {
  const AddressScreen({super.key});
  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context, state) {
        var address = ShopCubit.get(context).addressModel;
        return Scaffold(
      appBar: AppBar(
        toolbarHeight: 90,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
          onPressed: () => navigateTo(context,ShopAppScreen()),
        ),
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
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            ConditionalBuilder(
              condition: state is !ShopGetAddressLoadingStates || address!.data!.addressItem == [],
               builder: (context){
                if(address!.data!.addressItem == []) {
                  return Center(
                    child: Text('No Addresses yet',style: Theme.of(context).textTheme.headlineMedium!.copyWith(color: Colors.grey[300]),),);
                
                } else {
                  return SizedBox(
              height: MediaQuery.of(context).size.height* 0.7,
              child: ListView.separated
              (
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context,index)=>AddressItemBuilder(model:address.data!.addressItem[index]),
                 separatorBuilder: (context,index)=>const SizedBox(height: 10,),
                  itemCount: address.data!.addressItem.length),
            );
                }
               },
                fallback: (context)=> const Center(child: CircularProgressIndicator(),))
          ,Container(
            
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.15,
                    vertical: MediaQuery.of(context).size.width * 0.05),
                child: ElevatedButton(
                    onPressed: () {
                      navigateTo(context, AddNewAddressesScreen(isEdit: false,));
                    },
                    child: const Text(
                      'Add New Address',
                      style: TextStyle(fontSize: 18),
                    )),
              ),
              //SizedBox(height: 15,)
          ],
        ),
      ),
    );
      
      },);}
}

class AddressItemBuilder extends StatelessWidget {
 final AddressItem model;
   const AddressItemBuilder({
    required this.model,
    super.key,
  });


  @override
  Widget build(BuildContext context) {
    var titleStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: Colors.grey[600]);
    var labelStyle = Theme.of(context).textTheme.bodyMedium;
    return Column(
      children: [
        Row(
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: Colors.green,
            ),
            const SizedBox(
              width: 5,
            ),
            Text(
              model.name??'',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500, fontSize: 25),
            ),
            const Spacer(),
            TextButton.icon(
              icon: const Icon(
                Icons.delete_outline_rounded,
                color: Colors.red,
              ),
              onPressed: () {
                showAlertDialog
                (context: context,
                 content: 'Do you want to delete this address ?',
                  yesFunction: (){
                ShopCubit.get(context).deleteAddressData(addressId: model.id);
                Navigator.pop(context);
                  });
              },
              label: const Text(
                'Delete',
                style: TextStyle(color: Colors.red),
              ),
            ),
            TextButton.icon(
              icon: Icon(
                Icons.edit,
                color: Colors.grey[500],
              ),
              onPressed: () {
                navigateTo(context, AddNewAddressesScreen(
                  isEdit: true,
                  addressId:model.id ,
                  name: model.name,
                  city: model.city,
                  region: model.region,
                  detail: model.details,
                  notes: model.notes,));
              },
              label: Text(
                'Edit',
                style: TextStyle(color: Colors.grey[500]),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[400],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'City',
                    style: titleStyle,
                  ),
                  Text(
                    'Region',
                    style: titleStyle,
                  ),
                  Text(
                    'Details',
                    style: titleStyle,
                  ),
                  Text(
                    'Notes',
                    style: titleStyle,
                  ),
                ],
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.city??'',
                    style: labelStyle,
                  ),
                  Text(
                    model.region??'',
                    style: labelStyle,
                  ),
                  Text(
                    model.details??'',
                    style: labelStyle,
                  ),
                  Text(
                    model.notes??'',
                    style: labelStyle,
                  )
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
