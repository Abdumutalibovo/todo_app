import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../database/local_database.dart';
import '../models/todo_model.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class Profile2 extends StatefulWidget {
  TodoModel? Model;
  Profile2({super.key, required this.Model});
  @override
  State<Profile2> createState() => _Profile2State();
}

class _Profile2State extends State<Profile2> {
  final formKey = GlobalKey<FormState>();
  String newName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 1.26,
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.black,
            child: Form(
              key: formKey,
              child: Column(children: [
                Container(
                  child: CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage("https://i.pravatar.cc/30"),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.025,
                ),
                Container(
                    child: Text("No title",
                        style: TextStyle(fontSize: 25, color: Colors.white))),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.085,
                        width: MediaQuery.of(context).size.width * 0.41,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xFF363636)),
                        child: Center(
                            child: Text('10 Task left',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20))),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.085,
                        width: MediaQuery.of(context).size.width * 0.41,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Color(0xFF363636)),
                        child: Center(
                            child: Text(
                          '5 Task done',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        )),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 30),
                    child: Text('settings',
                        style: TextStyle(color: Colors.white54))),
                InkWell(
                    onTap: (() {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                scrollable: true,
                                backgroundColor: Color(0xFF363636),
                                insetPadding: EdgeInsets.all(10),
                                contentPadding:
                                    EdgeInsets.only(top: 8, left: 8, right: 8),
                                content: Container(
                                  height:
                                      MediaQuery.of(context).size.height * 0.23,
                                  width:
                                      MediaQuery.of(context).size.width * 0.85,
                                  child: Column(children: [
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Container(
                                      child: Text(
                                        'Change account name',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 18),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 4,
                                    ),
                                    Divider(
                                      thickness: 0.7,
                                      color: Colors.white,
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                          top: 12, left: 15, right: 15),
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white54)),
                                      child: TextFormField(
                                          onSaved: (val) {
                                            newName = val ?? "";
                                          },
                                          cursorHeight: 28,
                                          strutStyle: StrutStyle(fontSize: 22),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                          decoration: InputDecoration(
                                            contentPadding:
                                                EdgeInsets.only(left: 10),
                                            border: InputBorder.none,
                                            alignLabelWithHint: false,
                                          )),
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.03,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 65),
                                          child: InkWell(
                                              onTap: (() {
                                                Navigator.pop(context);
                                              }),
                                              child: Text(
                                                'Cancel',
                                                style: TextStyle(
                                                  color: MyColors.C_8687E7,
                                                ),
                                              )),
                                        ),
                                        InkWell(
                                            onTap: () {
                                              formKey.currentState?.save();
                                              var newTodo = TodoModel(
                                                  title: 'newTitle',
                                                  description: 'newDescription',
                                                  date: 'newDate3',
                                                  priority: 'newprority',
                                                  isCompleted: 0,
                                                  categoryId: 0);
                                              LocalDatabase.insertToDatabase(
                                                  newTodo);
                                              Navigator.pop(context);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 5),
                                              child: Container(
                                                  height: 50,
                                                  width: 140,
                                                  decoration: BoxDecoration(
                                                      color: MyColors.C_8687E7,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4.5)),
                                                  child: Container(
                                                      child: Center(
                                                          child: Text(
                                                    'Save',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )))),
                                            ))
                                      ],
                                    ),
                                  ]),
                                ),
                              ));
                    }),
                    child: titleWidget(MyImages.ic_settings, 'App Settings')),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 30),
                    child: Text('Account',
                        style: TextStyle(color: Colors.white54))),
                titleWidget(MyImages.ic_user, 'Change account name'),
                titleWidget(MyImages.ic_key, 'Change account password'),
                titleWidget(MyImages.ic_camera, 'Change account Image'),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.only(left: 30),
                    child: Text('Uptodo',
                        style: TextStyle(color: Colors.white54))),
                titleWidget(MyImages.ic_about, 'About US'),
                titleWidget(MyImages.ic_faq, 'FAQ'),
                titleWidget(MyImages.ic_help_feedback, 'Help & Feedback'),
                titleWidget(MyImages.ic_like, 'Support US'),
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.only(left: 14),
                    child: SvgPicture.asset(
                      MyImages.ic_log_out,
                      width: 26,
                    ),
                  ),
                  title: Text(
                    'Log out',
                    style: TextStyle(color: Colors.red, fontSize: 18),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

   Widget titleWidget(icon, word) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(left: 14),
        child: SvgPicture.asset(
          icon,
          width: 26,
        ),
      ),
      title: Text(
        word,
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
      trailing: SvgPicture.asset(
        MyImages.ic_right,
        width: 26,
        color: Colors.white,
      ),
    );
  }
}
