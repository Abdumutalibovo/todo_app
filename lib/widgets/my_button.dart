import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/colors.dart';

Widget MyButton(String text, Color color) {
  return Container(
    height: 50,
    decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: MyColors.C_8875FF, width: 0.5)),
    child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 20, color: Colors.white70),
        )),
  );
}

Widget MyButtonImage(String text, Color color, String image) {
  return
    Container(
      height: 50,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: MyColors.C_8875FF, width: 0.5)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(image),
          SizedBox(width: 12,),
          Text(
            text,
            style: TextStyle(fontSize: 20, color: Colors.white70),
          ),
        ],
      ),
    );
}