import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

Widget CategoryWidget(Color color, String image, String name){
  return Container(
    child: Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
                child: SvgPicture.asset(image)),
          ),
        ),
        SizedBox(height: 3,),
        Text(name, style: TextStyle(color: Colors.white,),),
      ],
    ),
  );
}