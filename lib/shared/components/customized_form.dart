// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget CustomizedFormField(
    {TextInputType? textType,
    required String labelText,
    required IconData prefixIcon,
    IconData? suffixIcon,
    required String? Function(String?) validate,
    required TextEditingController controller,
    void Function()? onTapSuffix,
    void Function()? onTap,
    void Function(String)? onChange,
    void Function(String)? onSubmit,
    bool secure = false,
    }
    ) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      //color: Colors.grey[300]
    ),
    child: TextFormField(
      keyboardType: textType,
      validator: validate,
      controller: controller,
      onFieldSubmitted: onSubmit,
      obscureText: secure,
      onTap: onTap,
      onChanged: onChange,
      enableInteractiveSelection: true,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      style:  GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400
      ),
      decoration: InputDecoration(
          label: Text(labelText),
          labelStyle: TextStyle(color: Colors.grey[400]),
          contentPadding: const EdgeInsetsDirectional.only(start: 5, end: 5),
          suffixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 5, end: 10),
            child: IconButton(onPressed: onTapSuffix, icon: Icon(suffixIcon)),
          ),
          prefix: Padding(
            padding: const EdgeInsetsDirectional.only(end: 10),
            child: Icon(prefixIcon),
          )),
    ),
  );
}

Widget RoundedFormField(
    {TextInputType? textType,
    required String labelText,
    required IconData prefixIcon,
    IconData? suffixIcon,
    required String? Function(String?) validate,
    required TextEditingController controller,
    void Function()? onTapSuffix,
    void Function()? onTap,
    void Function(String)? onSubmit,
    bool secure = false,
    void Function(String)? onChange}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: TextFormField(
      obscureText: secure,
      keyboardType: textType,
      validator: validate,
      enableInteractiveSelection: true,
      onTapOutside: (event) => FocusManager.instance.primaryFocus?.unfocus(),
      controller: controller,
      onTap: onTap,
      onChanged: onChange,
      onFieldSubmitted:onSubmit ,
      style:  GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400
      ),
      
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          )
        ),
          label: Text(labelText),
                    labelStyle: TextStyle(color: Colors.grey[400]),

          contentPadding: const EdgeInsetsDirectional.all(10),
          suffixIcon: Padding(
            padding: const EdgeInsetsDirectional.only(start: 10, end: 10),
            child: IconButton(
                padding: const EdgeInsetsDirectional.all(10),
                color: Colors.grey[400],
                focusColor: Colors.grey[400],
                onPressed: onTapSuffix,
                icon: Icon(
                  suffixIcon,
                )),
          ),
    
          prefixIconColor:  Colors.grey[400],
          prefixIcon: Icon(prefixIcon)),
    ),
  );
}

