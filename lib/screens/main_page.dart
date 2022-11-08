import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/screens/profile_page.dart';
import 'package:todo_app/theme_provider.dart';
import '../utils/colors.dart';
import '../utils/images.dart';
import '../widgets/add_task_widget.dart';
import 'home_page.dart';

class MainPage extends StatefulWidget {
  MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {

    final List<String> titles=[
      "HomePage".tr(),
      "Calendar".tr(),
      "Add Screen".tr(),
      "Focus".tr(),
      "Profile".tr()
    ];

    final List<Widget> _pages = [
      HomePage(),
      Container(),
      Container(),
      Container(),
      ProfilePage(),
    ];

    Future<bool> _onWillPop() async{

      if(_selectedIndex!=0){
        setState(() {
          _selectedIndex=0;
        });
        return false;
      }
      return (await showDialog(
        context: context, builder: (context)=>AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text("Do you want to exit an App"),
        actions: <Widget>[
          TextButton(onPressed: ()=>Navigator.of(context).pop(false), child:const Text('No'),),
          TextButton(onPressed: ()=>Navigator.of(context).pop(true), child: const Text('Yes'),),
        ],
      ),
      ))??false;
    }

    var isLight=context.watch<ThemeProvider>().getIsLight();

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: _pages[_selectedIndex],
        backgroundColor: isLight?Colors.white:Colors.black,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      padding: EdgeInsets.all(24),
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        color: MyColors.C_363636,
                      ),
                      child: Column(
                        children: [
                          SvgPicture.asset(MyImages.ic_fingerprint),
                          SizedBox(height: 12),
                          Text(
                            "Please hold your finger at "
                                "the fingerprint scanner to verify your identity",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.87),
                                fontSize: 20),
                          ),
                          SizedBox(height: 48),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(150, 48),
                                  backgroundColor: MyColors.C_363636,
                                  shadowColor: null,
                                  elevation: 0,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Cancel",
                                  style: TextStyle(
                                      fontSize: 16, color: MyColors.C_8875FF),
                                ),
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  minimumSize: const Size(150, 48),
                                  backgroundColor: MyColors.C_363636,
                                ),
                                onPressed: () {},
                                child: const Text(
                                  "Use Password",
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    );
                  });
            },
            icon: SvgPicture.asset(MyImages.ic_menu),
          ),
          backgroundColor: Colors.black,
          title: Text(titles[_selectedIndex],),
          actions: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: CircleAvatar(
                radius: 24,
                backgroundImage: NetworkImage(
                  "https://i.pravatar.cc/300",
                ),
              ),
            ),
            SizedBox(width: 12),
          ],
        ),
        floatingActionButton: Stack(children: [
          Positioned(
            bottom: 34,
            left: 155.9,
            child: Container(
              width: 90,
              height: 45.5,
              decoration: BoxDecoration(
                  color: Color(0xff121212),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.elliptical(76, 80),
                      bottomRight: Radius.elliptical(76, 80))),
            ),
          ),
          Positioned(
            bottom: 40,
            left: 165,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return AddTaskWidget(
                      onNewTask: () {
                        setState(() {
                          _selectedIndex = 0;
                        });
                      },
                    );
                  },
                );
              },
              child: Container(
                  height: 72,
                  width: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: MyColors.C_8687E7,
                  ),
                  child: Center(
                    child: Text(
                      "+",
                      style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.w400,
                          color: Colors.white),
                    ),
                  )),
            ),
          ),
        ]),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            currentIndex: _selectedIndex,
            onTap: (index) {
              setState(() {
                _selectedIndex = index;
              });
            },
            iconSize: 28,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.50),
            backgroundColor: MyColors.C_363636,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_filled),
                label: 'Index',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.calendar_month),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(null),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.watch_later_outlined),
                label: 'Focus',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_outline),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}