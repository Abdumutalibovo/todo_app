import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/screens/onboarding_page.dart';
import 'package:todo_app/utils/images.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  void initState() {
    super.initState();
    onNextPage();
  }

  onNextPage(){
    Future.delayed(Duration(seconds: 3),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>OnBoardingPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          Container(
              width: double.infinity,
              child: SvgPicture.asset(MyImages.ic_accepted)),
          SizedBox(height: 20,),
          Text("UpTodo", style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.w600),)
        ] ,
      ),
    );
  }
}