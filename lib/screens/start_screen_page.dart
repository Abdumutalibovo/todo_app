import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.only(top: 58),
        child: Column(
          children: [
            Center(
                child: Text(
                  "Welcome to UpTodo",
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 36,
                      fontWeight: FontWeight.w600),
                )),
            SizedBox(
              height: 26,
            ),
            Center(
                child: Text(
                  "Please login to your account or create \n            new account to continue",
                  style: TextStyle(
                    color: Colors.white60,
                    fontSize: 16,
                    height: 1.5,
                  ),
                )),
            SizedBox(height: 400,),
            InkWell(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_)=>LoginPage()));
                },
                child: MyButton("Login", MyColors.C_8875FF)),
            SizedBox(height: 28,),
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
      width: 327,
      height: 50,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: MyColors.C_8875FF,width: 1.5)
      ),
      child: Center(child: Text(text, style: TextStyle(fontSize: 20,color: Colors.white),)),
    );
  }
}
