import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget ListWidget(String name, String text, String image) {
  return Container(
    padding: EdgeInsets.only(top: 100).r,
    width: double.infinity,
    height: double.infinity,
    child: Column(
      children: [
        Image.asset(
          image,
          width: 250.w,
        ),
        SizedBox(
          height: 105.h,
        ),
        Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32.sp,
              color: Colors.white),
        ),
        SizedBox(
          height: 42.h,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 18.sp, color: Colors.white70),
        )
      ],
    ),
  );
}
