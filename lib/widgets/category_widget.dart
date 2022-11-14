import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/models/category_model.dart';

Widget CategoryWidget(CategoryModel category, int index) {
  return Container(
    child: Column(
      children: [
        Container(
          width: 64.w,
          height: 64.h,
          decoration: BoxDecoration(
            color: Color(category.color),
            borderRadius: BorderRadius.circular(4).r,
          ),
          child: Padding(
            padding: const EdgeInsets.all(16).r,
            child: Container(child: SvgPicture.asset(category.icon ?? "")),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        Text(
          category.name ?? "",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    ),
  );
}
