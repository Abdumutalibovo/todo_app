import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numberpicker/numberpicker.dart';

import '../utils/colors.dart';
import '../utils/images.dart';
import '../widgets/hour_widget.dart';
import '../widgets/textfield_widget.dart';

class MainPage extends StatefulWidget {
  final String? restorationId;

  const MainPage({Key? key, required this.restorationId}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

final _formkey = GlobalKey<FormState>();

class _MainPageState extends State<MainPage> with RestorationMixin {
  @override
  String? get restorationId => widget.restorationId;

  final RestorableDateTime _selectedDate =
      RestorableDateTime(DateTime(2022, 10, 28));
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2022),
          lastDate: DateTime(2023),
        );
      },
    );
  }

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      showDialog(
          context: context,
          builder: (((context) => AlertDialog(
                contentPadding: EdgeInsets.only(top: 8, left: 8, right: 8),
                content: HourWidget(context),
                backgroundColor: Color(0xFF363636),
                titlePadding: EdgeInsets.only(left: 110, top: 15),
                title: Text(
                  'Choose time',
                  style: TextStyle(color: Colors.white),
                ),
              ))));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          toolbarHeight: 80,
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(MyImages.ic_menu),
          ),
          backgroundColor: Colors.black,
          title: Text("HomePage"),
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
        floatingActionButton: InkWell(
          onTap: () {
            showModalBottomSheet(
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                context: (context),
                builder: (BuildContext context) {
                  return SingleChildScrollView(
                    child: Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: MyColors.C_363636,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 25, left: 25),
                            child: Text(
                              "Add Task",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700),
                            ),
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: MyTextField(
                                context, "Do math homework", "Title"),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, top: 16),
                            child: MyTextField(
                                context, "Description", "Description"),
                          ),
                          SizedBox(
                            height: 36,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: 32,
                              ),
                              SvgPicture.asset(MyImages.ic_hour),
                              SizedBox(
                                width: 32,
                              ),
                              SvgPicture.asset(MyImages.ic_pin),
                              SizedBox(
                                width: 32,
                              ),
                              SvgPicture.asset(MyImages.ic_flag),
                              SizedBox(
                                width: 160,
                              ),
                              OutlinedButton(
                                  onPressed: () {
                                    if (_formkey.currentState!.validate()) {
                                      _restorableDatePickerRouteFuture
                                          .present();
                                    }
                                  },
                                  child: SvgPicture.asset(MyImages.ic_sent)),
                            ],
                          )
                        ],
                      ),
                    ),
                  );
                });
          },
          child: Container(
              width: 72,
              height: 72,
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
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: SizedBox(
          height: 80,
          child: BottomNavigationBar(
            iconSize: 28,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.50),
            backgroundColor: MyColors.C_363636,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(MyImages.ic_home),
                label: 'Index',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(MyImages.ic_calendar),
                label: 'Calendar',
              ),
              BottomNavigationBarItem(
                icon: Icon(null),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(MyImages.ic_focuse),
                label: 'Focus',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(MyImages.ic_profile),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
