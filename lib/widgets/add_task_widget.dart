import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/utils/colors.dart';

import '../../database/local_database.dart';
import '../../models/todo_model.dart';
import '../utils/images.dart';

class AddTaskWidget extends StatefulWidget {
  VoidCallback onNewTask;

  AddTaskWidget({Key? key, required this.onNewTask}) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final formKey = GlobalKey<FormState>();
  String newTitle = "";
  String newDescription = "";

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
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
                padding: const EdgeInsets.only(left: 16,right: 16),
                child: TextFormField(
                  onSaved: (val) {
                    newTitle = val ?? "";
                  },
                  decoration: InputDecoration(
                    hintText: 'Title',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16),
                child: TextFormField(
                  onSaved: (val) {
                    newDescription = val ?? "";
                  },
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                  InkWell(
                      onTap: (){
                        formKey.currentState?.save();
                        var newTodo = TodoModel(
                          title: newTitle,
                          description: newDescription,
                          date: "date",
                          priority: "priority",
                          isCompleted: 0,
                        );
                        LocalDatabase.insertToDatabase(newTodo);

                        widget.onNewTask();

                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(MyImages.ic_sent)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}