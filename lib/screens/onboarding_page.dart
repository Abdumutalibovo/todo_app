import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_app/screens/start_screen_page.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/images.dart';

import '../widgets/lists_widget.dart';

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

  List<Widget> _list = [
    ListWidget(
      "Manage your tasks",
      "You can easily manage all of your daily \n               tasks in DoMe for free",
      MyImages.im_task,
    ),
    Padding(
      padding: const EdgeInsets.only(top: 50),
      child: ListWidget(
        "Create daily routine",
        "        In Uptodo  you can create your \npersonalized routine to stay productive",
        MyImages.im_routine,
      ),
    ),
    Padding(
      padding: const EdgeInsets.only(top: 76),
      child: ListWidget(
        "Orgonaize your tasks",
        "     You can organize your daily tasks by \nadding your tasks into separate categories",
        MyImages.im_organazed_task,
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
              padding:  EdgeInsets.only(
                top: 24.h,
                right: 250.w,
              ),
              child: TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => StartScreenPage()));
                  },
                  child: Text(
                    "SKIP",
                    style: TextStyle(fontSize: 20.sp, color: Colors.white38),
                  )),
            ),
            SizedBox(
              height: 430.h,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40).r,
              child: Container(
                height: 4,
                child: ListView.separated(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 3,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 26.28.w,
                      height: 4.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(56).r,
                        color: _curr == index
                            ? Color(0xFF32B5FF)
                            : Color(0xFFC4C4C4),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return SizedBox(
                      width: 8.w,
                    );
                  },
                ),
              ),
            ),
            SizedBox(
              height: 230.h,
            ),
            Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(left: 20).r,
                    child: TextButton(
                      style: TextButton.styleFrom(
                        textStyle: TextStyle(fontSize: 20.sp),
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => exit(0)));
                      },
                      child:  Text('Back',
                          style:
                              TextStyle(fontSize: 20.sp, color: Colors.white54)),
                    ),
                  ),
                  Container(
                      child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors.C_8875FF),
                    onPressed: () {
                      _pageController.nextPage(
                          duration: const Duration(seconds: 1),
                          curve: Curves.ease);
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => StartScreenPage(),));
                    },
                    child: Text('Next',
                        style: TextStyle(
                          fontSize: 20.sp,
                        )),
                  ))
                ]),
          ],
        ),
      ),
    );
  }
}
