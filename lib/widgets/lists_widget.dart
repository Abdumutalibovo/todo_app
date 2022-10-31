import 'package:flutter/material.dart';

Widget ListWidget(String name, String text, String image){
  return Container(
    padding: EdgeInsets.only(top: 100),
    width: double.infinity,
    height: double.infinity,
    child: Column(
      children: [
        Image.asset(
          image,
          width: 250,
        ),
        SizedBox(
          height: 105,
        ),
        Text(
          name,
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 32,
              color: Colors.white),
        ),
        SizedBox(
          height: 42,
        ),
        Text(
          text,
          style: TextStyle(fontSize: 18, color: Colors.white70),
        )
      ],
    ),
  );
}