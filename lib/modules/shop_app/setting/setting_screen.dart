import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/shop_app/cubit/cubit.dart';
import 'package:shop_app/layout/shop_app/cubit/states.dart';
import 'package:shop_app/modules/shop_app/addresses/addresses_screen.dart';
import 'package:shop_app/modules/shop_app/profile/profile_screen.dart';
import 'package:shop_app/modules/shop_app/setting/faqs_screen.dart';
import 'package:shop_app/shared/Constants/constants.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/components/shopApp_component.dart';
import '../../../shared/components/taskCard.dart';
import '../../../shared/styles/colors.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  _launchURL(String path) async {
    Uri _url = Uri.parse(path);
    if (await launchUrl(_url)) {
      await launchUrl(_url);
    } else {
      throw 'Could not launch $_url';
    }
  }

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getUserData();

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        var model = ShopCubit.get(context).userData;
        print('????????????${model.data?.name}');
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (state is ShopGetUserDataLoadingStates)
                LinearProgressIndicator(),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${model.data?.name ?? ''}',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Text(
                              '${model.data?.email ?? ''}',
                              style: Theme.of(context).textTheme.bodySmall,
                            )
                          ],
                        ),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              showAlertDialog(
                                  context: context,
                                  content: 'Are you sure to signOut ?',
                                  yesFunction: () {
                                    logOut(context);
                                    //Navigator.pop(context);
                                  });
                            },
                            icon: Row(
                              children: [
                                Icon(
                                  Icons.logout_outlined,
                                  size: 20,
                                  color: defaultColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'SignOut',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.copyWith(color: defaultColor),
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10, horizontal: 10),
                child: Text(
                  'Profile',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      MenuItem(
                        icon: Icons.person,
                        label: 'Your Personal Info ',
                        onTap: () {
                          navigateTo(context, ProfileScreen());
                        },
                      ),
                      MenuItem(
                        icon: Icons.location_on_rounded,
                        label: 'Addresses ',
                        onTap: () {
                          navigateTo(context, const AddressScreen());
                        },
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10, horizontal: 10),
                child: Text(
                  'Settings',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      ExpansionTileTheme(
                        data: ExpansionTileThemeData(
                            shape: Border.all(color: Colors.transparent)),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.all(0),
                          onExpansionChanged: (value) {
                            // cubit.isTapped = value;
                            cubit.menuListTap();
                          },
                          trailing: cubit.isTapped == true
                              ? Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: defaultColor,
                                )
                              : Icon(
                                  Icons.keyboard_arrow_right_rounded,
                                  color: defaultColor,
                                ),
                          leading: CircleAvatar(
                            child: Icon(
                              Icons.language,
                              color: Colors.grey[600],
                            ),
                          ),
                          title: const Text('Language'),
                          children: [
                            RadioListTile(
                                //selected: true,
                                title: const Text('English'),
                                value: 'en',
                                groupValue: cubit.language,
                                onChanged: (value) {
                                  cubit.language = value ?? '';
                                }),
                            RadioListTile(
                                title: const Text('العربية'),
                                value: 'ar',
                                groupValue: cubit.language,
                                onChanged: (value) {
                                  cubit.language = value ?? '';
                                })
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 10),
                        child: Row(
                          children: [
                            CircleAvatar(
                              child: Icon(
                                Icons.dark_mode_outlined,
                                color: Colors.grey[600],
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Dark Mode ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            const Spacer(),
                            CupertinoSwitch(
                                activeColor: defaultColor,
                                value: cubit.isDark,
                                onChanged: ((value) {
                                  cubit.changeMood(sharedpref: value);
                                }))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                    vertical: 10, horizontal: 10),
                child: Text(
                  'Reach out to us',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsetsDirectional.symmetric(
                              vertical: 10),
                          child: MenuItem(
                              icon: Icons.info_outline_rounded,
                              onTap: () {
                                navigateTo(context, const FAQsScreen());
                              },
                              label: 'FAQs')),
                      Padding(
                        padding:
                            const EdgeInsetsDirectional.symmetric(vertical: 10),
                        child: ExpansionTileTheme(
                          data: ExpansionTileThemeData(
                              shape: Border.all(color: Colors.transparent)),
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.all(0),
                            onExpansionChanged: (value) {
                              // cubit.isTapped = value;
                              cubit.menuListTap();
                            },
                            trailing: cubit.isTapped == true
                                ? Icon(
                                    Icons.keyboard_arrow_down_rounded,
                                    color: defaultColor,
                                  )
                                : Icon(
                                    Icons.keyboard_arrow_right_rounded,
                                    color: defaultColor,
                                  ),
                            leading: CircleAvatar(
                              child: Icon(
                                Icons.question_mark_rounded,
                                color: Colors.grey[600],
                              ),
                            ),
                            title: const Text('Contact Us'),
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.6,
                                child: ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: cubit
                                      .contactModel?.data?.contactItem.length,
                                  itemBuilder: (context, index) => ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.deepPurple,
                                      radius: 18,
                                      child: Image(
                                          width: 16,
                                          height: 16,
                                          image: NetworkImage(cubit
                                                  .contactModel
                                                  ?.data
                                                  ?.contactItem[index]
                                                  .image ??
                                              '')),
                                    ),
                                    title: InkWell(
                                      onTap: () => _launchURL(cubit
                                              .contactModel
                                              ?.data
                                              ?.contactItem[index]
                                              .value ??
                                          ''),
                                      child: Text(
                                        '${cubit.contactModel?.data?.contactItem[index].value ?? ''}',
                                        style: const TextStyle(
                                            color: Colors.blue,
                                            decoration:
                                                TextDecoration.underline,
                                            decorationColor: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;

  final void Function()? onTap;
  const MenuItem({
    super.key,
    required this.icon,
    required this.onTap,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(vertical: 10),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            CircleAvatar(
              child: Icon(
                icon,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(fontWeight: FontWeight.w500),
            ),
            const Spacer(),
            Icon(
              Icons.keyboard_arrow_right_rounded,
              color: defaultColor,
            )
          ],
        ),
      ),
    );
  }
}
