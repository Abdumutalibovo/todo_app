import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/screens/register_page.dart';
import 'package:todo_app/screens/start_screen_page.dart';
import 'package:todo_app/utils/colors.dart';
import '../utils/images.dart';
import '../widgets/my_button.dart';
import '../widgets/textfield_widget.dart';
import 'main_page.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

final _formkey = GlobalKey<FormState>();

class _LoginPageState extends State<LoginPage> {
  bool isvisiblity = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => StartScreenPage()));
                },
                child: Icon(Icons.arrow_back_ios_outlined)),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 42,
                  ),
                  Text(
                    "Login",
                    style: TextStyle(
                        fontSize: 36,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 53,
                  ),
                  Text(
                    "Username",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  MyTextField(context, "Enter your Username", "Username"),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Password",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white70,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  MyTextField(context, "• • • • • • • • • • • •", "Password"),
                  SizedBox(
                    height: 69,
                  ),
                  InkWell(
                    onTap: () {
                      if (_formkey.currentState!.validate()) {
                        showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                width: double.infinity,
                                height: 380,
                                decoration: BoxDecoration(
                                  color: MyColors.C_363636,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(15),
                                      topRight: Radius.circular(15)),
                                ),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 36,
                                    ),
                                    SvgPicture.asset(MyImages.ic_touch),
                                    SizedBox(
                                      height: 24,
                                    ),
                                    Text(
                                      "  Please hold your finger at the \nfingerprint scanner to verify your \n                      identity",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 24,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 68,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              Navigator.pushAndRemoveUntil(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) => MainPage(
                                                            restorationId: '',
                                                          )),
                                                  (route) => false);
                                            },
                                            child: Text(
                                              "Cancel",
                                              style: TextStyle(
                                                  color: MyColors.C_8687E7,
                                                  fontSize: 20),
                                            )),
                                        ElevatedButton(
                                            onPressed: () {},
                                            child: Text(
                                              "Use Password",
                                              style: TextStyle(fontSize: 20),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  MyColors.C_8687E7,
                                            ))
                                      ],
                                    )
                                  ],
                                ),
                              );
                            });
                      }
                    },
                    child: MyButton(
                      "Login",
                      MyColors.C_4C4C7C,
                    ),
                  ),
                  SizedBox(
                    height: 31,
                  ),
                  Image.asset(MyImages.im_or),
                  SizedBox(
                    height: 29,
                  ),
                  MyButtonImage(
                      "Login with Google", Colors.black, MyImages.ic_google),
                  SizedBox(
                    height: 20,
                  ),
                  MyButtonImage(
                      "Login with Appe", Colors.black, MyImages.ic_appe),
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Don’t have an account?",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color(0xFF979797),
                          )),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => RegisterPage()));
                        },
                        child: Text(" Register",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.white70,
                            )),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}