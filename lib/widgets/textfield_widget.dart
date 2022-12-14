import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget MyTextField(context, String text, String type) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.065,
    decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(6).r,
        border: Border.all(color: Colors.white54)),
    child: TextFormField(
      onSaved: (value){
      },
        cursorHeight: 28.h,
        enableIMEPersonalizedLearning: false,
        strutStyle: StrutStyle(fontSize: 22.sp),
        style: TextStyle(color: Colors.white, fontSize: 20.sp),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Enter your $type";
          }
          return null;
        },
        decoration: InputDecoration(
          border: InputBorder.none,
          alignLabelWithHint: false,
          contentPadding: EdgeInsets.all(12).r,
          hintText: text,
          hintStyle: TextStyle(color: Colors.white38),
        )),
  );
}