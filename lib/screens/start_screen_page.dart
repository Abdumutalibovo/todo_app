import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/screens/login_page.dart';
import 'package:todo_app/screens/onboarding_page.dart';
import 'package:todo_app/screens/register_page.dart';
import 'package:todo_app/utils/colors.dart';
class StartScreenPage extends StatelessWidget {
  const StartScreenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>OnBoardingPage()));
            },
            child: Icon(Icons.arrow_back_ios_outlined)),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 58).r,
        child: Column(
          children: [
            Center(
                child: Text(
                  "Welcome to UpTodo",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 36.sp,
                      fontWeight: FontWeight.w600),
                )),
            SizedBox(
              height: 26.h,
            ),
            Center(
                child: Text(
                  "Please login to your account or create \n            new account to continue",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 16.sp,
                    height: 1.5.h,
                  ),
                )),
            SizedBox(height: 400.h,),
            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage()));
                },
                child: MyButton("Login", MyColors.C_8875FF)),
            SizedBox(height: 28.h,),
            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>RegisterPage()));
                },
                child: MyButton("Create Account", Colors.black)),
          ],
        ),
      ),
    );
  }

  Widget MyButton(String text,Color color){
    return  Container(
      width: 327.w,
      height: 50.h,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4).r,
          border: Border.all(color: MyColors.C_8875FF,width: 1.5.w)
      ),
      child: Center(child: Text(text, style: TextStyle(fontSize: 20.sp,color: Colors.white),)),
    );
  }
}
