import 'dart:io';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/start_screen_page.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/images.dart';
import 'package:flutter/widgets.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
  List<Widget> _list = <Widget>[
    Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Image.asset(
              MyImages.im_task,
              width: 250,
            ),
            SizedBox(
              height: 105,
            ),
            Text(
              "Manage your tasks",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Colors.white),
            ),
            SizedBox(
              height: 42,
            ),
            Text(
              "You can easily manage all of your daily \n               tasks in DoMe for free",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            )
          ],
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 150),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Image.asset(
              MyImages.im_routine,
              fit: BoxFit.cover,
              width: 250,
            ),
            SizedBox(
              height: 105,
            ),
            Text(
              "Create daily routine",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Colors.white),
            ),
            SizedBox(
              height: 42,
            ),
            Text(
              "        In Uptodo  you can create your \npersonalized routine to stay productive",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            )
          ],
        ),
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 200),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Image.asset(
              MyImages.im_organazed_task,
              width: 250,
            ),
            SizedBox(
              height: 82,
            ),
            Text(
              "Orgonaize your tasks",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Colors.white),
            ),
            SizedBox(
              height: 42,
            ),
            Text(
              "     You can organize your daily tasks by \nadding your tasks into separate categories",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            )
          ],
        ),
      ),
    ),
  ];
  int _curr = 0;
  int num = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: PageView(
          children: _list,
          scrollDirection: Axis.horizontal,
          physics: BouncingScrollPhysics(),
          controller: _pageController,
          onPageChanged: (num) {
            setState(() {
              _curr = num;
            });
          },
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 24, right: 250,),
              child: TextButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (_)=>StartScreenPage()));
              }, child: Text("SKIP", style: TextStyle(fontSize: 20, color: Colors.white38),)),
            ),
            SizedBox(height: 430,),
            Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Container(
                height: 4,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 26.28,
                      height: 4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(56),
                        color: _curr == index
                            ? Color(0xFF32B5FF)
                            : Color(0xFFC4C4C4),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 8,
                    );
                  },
                ),
              ),
            ),
            SizedBox(height: 230,),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: const TextStyle(fontSize: 20),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => exit(0)));
                      },
                      child: const Text('Back',
                          style: TextStyle(fontSize: 20, color: Colors.white54)),
                    ),
                  ),
                  Container(

                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: MyColors.C_8875FF),
                        onPressed: () {
                          _pageController.nextPage(duration: const Duration(seconds: 1), curve: Curves.ease);
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => StartScreenPage(),));
                        },
                        child: Text('Next',
                            style: TextStyle(
                              fontSize: 20,
                            )),
                      ))
                ]),
          ],
        ),
      ),
    );
  }

  Widget ListWidget(){
    return  Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            Image.asset(
              MyImages.im_task,
              width: 250,
            ),
            SizedBox(
              height: 105,
            ),
            Text(
              "Manage your tasks",
              style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                  color: Colors.white),
            ),
            SizedBox(
              height: 42,
            ),
            Text(
              "You can easily manage all of your daily \n               tasks in DoMe for free",
              style: TextStyle(fontSize: 18, color: Colors.white70),
            )
          ],
        ),
      ),
    );
  }
}
