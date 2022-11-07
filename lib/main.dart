import 'package:flutter/material.dart';
import 'package:todo_app/screens/main_page.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: ThemeData(brightness: Brightness.dark),
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
