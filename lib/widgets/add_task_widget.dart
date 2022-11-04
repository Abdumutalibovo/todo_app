import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/utils/colors.dart';
import '../../database/local_database.dart';
import '../../models/todo_model.dart';
import '../models/category_model.dart';
import '../utils/images.dart';
import 'category_widget.dart';

class AddTaskWidget extends StatefulWidget {
  VoidCallback onNewTask;

  AddTaskWidget({Key? key, required this.onNewTask}) : super(key: key);

  @override
  State<AddTaskWidget> createState() => _AddTaskWidgetState();
}

class _AddTaskWidgetState extends State<AddTaskWidget> {
  final formKey = GlobalKey<FormState>();
  String newTitle = "";
  bool isOn = false;
  String newDescription = "";
  String newprority = '';
  int newCategoryId = -1;
  int isSelected = -1;
  bool onClock = false;
  DateTime? taskDay; // 02.11.2022 ----
  TimeOfDay? taskTime; // ---------- 21:25
  List list = ['AM', 'PM'];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          width: double.infinity,
          height: 500,
          decoration: BoxDecoration(
            color: MyColors.C_363636,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15), topRight: Radius.circular(15)),
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
                padding: const EdgeInsets.only(left: 16, right: 16),
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
                padding: const EdgeInsets.only(left: 16, right: 16),
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
                    width: 16,
                  ),
                  IconButton(
                    onPressed: () async {
                      taskDay = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2300),
                      );
                      taskTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      taskDay = DateTime(
                        taskDay!.year,
                        taskDay!.month,
                        taskDay!.day,
                        taskTime!.hour,
                        taskTime!.minute,
                      );
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 24,
                  ),
                  InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (((context) => AlertDialog(
                                  contentPadding: EdgeInsets.only(
                                      top: 8, left: 8, right: 8),
                                  title: Center(
                                      child: Text(
                                    'Choose Category',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                  backgroundColor: MyColors.C_363636,
                                  content: Container(
                                    height: MediaQuery.of(context).size.height *
                                        0.6,
                                    width: MediaQuery.of(context).size.height *
                                        0.95,
                                    color: MyColors.C_363636,
                                    child: Column(
                                      children: [
                                        Divider(
                                          thickness: 0.7,
                                          color: Colors.white70,
                                        ),
                                        SizedBox(
                                          height: 5,
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.5,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.9,
                                          child: GridView.builder(
                                            shrinkWrap: true,
                                            scrollDirection: Axis.vertical,
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 3),
                                            itemCount: 11,
                                            itemBuilder: ((context, index) {
                                              return Padding(
                                                padding: EdgeInsets.all(8),
                                                child: InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      newCategoryId = index;

                                                    });
                                                  },
                                                  child: CategoryWidget(CategoryModel.lists[index], index),
                                                ),
                                              );
                                            }),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 45),
                                              child: InkWell(
                                                  onTap: (() {
                                                    Navigator.pop(context);
                                                  }),
                                                  child: Text(
                                                    'Cancel',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                            ),
                                            InkWell(
                                                onTap: () {
                                                  setState(() {
                                                    Navigator.pop(context);
                                                    newCategoryId=newCategoryId;
                                                  });
                                                },
                                                child: Container(
                                                    height: 50,
                                                    width: 120,
                                                    color: MyColors.C_8687E7,
                                                    child: Container(
                                                        child: Center(
                                                            child: Text(
                                                      'Save',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    )))))
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ))));
                      },
                      child: SvgPicture.asset(MyImages.ic_pin)),
                  SizedBox(
                    width: 32,
                  ),
                  InkWell(
                      onTap: () {
                        showDialog(context: context, builder: (((context)=>StatefulBuilder(builder: (context,state){
                          return AlertDialog(
                            contentPadding: EdgeInsets.only(top: 8,left: 8,right: 8),
                            title: Center(child: Text('Task Priority',style: TextStyle(color: Colors.white),)),
                            backgroundColor: MyColors.C_363636,
                            content: Container(
                              height: MediaQuery.of(context).size.height*0.42,
                              width: MediaQuery.of(context).size.height*0.9,
                              color: MyColors.C_363636,
                              child: Column(
                                children: [
                                  Divider(thickness: 0.7,color: Colors.white70,),
                                  SizedBox(height: 5,),
                                  Container(
                                    height: MediaQuery.of(context).size.height*0.32,
                                    width: MediaQuery.of(context).size.height*0.9,
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                                      itemCount: 10,
                                      itemBuilder: ((context,index){
                                        return Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: InkWell(
                                            onTap: (){
                                              state(() {
                                                isSelected = index;
                                                newprority = (index+1).toString();
                                              });
                                            },
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                  color: isSelected == index ? MyColors.C_8687E7 : Color(0xFF272727),
                                                  borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: Column(
                                                children: [
                                                  SizedBox(height: 5,),
                                                  Container(
                                                    child: SvgPicture.asset(MyImages.ic_flags, width: 26,),),
                                                  SizedBox(height: 3,),
                                                  Container(
                                                    child: Text((index+1).toString(),style: TextStyle(fontSize: 22, color:
                                                    Colors.white),),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 45),
                                        child: InkWell(
                                            onTap: (() {
                                              Navigator.pop(context);
                                            }),
                                            child: Text('Cancel', style: TextStyle(color: Colors.white,),)),
                                      ),
                                      InkWell(
                                        onTap: (){
                                          state(() {
                                            Navigator.pop(context);
                                            newprority = newprority;
                                          });},
                                        child: Container(
                                          height: 50,
                                          width: 120,
                                          color: MyColors.C_8687E7,
                                          child: Container(
                                              child: Center(child: Text('Save', style: TextStyle(color: Colors.white,),))),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          );
                        }))));
                      },
                      child: SvgPicture.asset(MyImages.ic_flags)),
                  SizedBox(
                    width: 160,
                  ),
                  InkWell(
                      onTap: () {
                        formKey.currentState?.save();
                        if(newTitle.isNotEmpty &&
                            newDescription.isNotEmpty &&
                            taskDay != null &&
                            newCategoryId != -1){var newTodo = TodoModel(
                          title: newTitle,
                          description: newDescription,
                          date: taskDay.toString(),
                          priority: newprority,
                          categoryId: newCategoryId,
                          isCompleted: 0,
                        );
                        LocalDatabase.insertToDatabase(newTodo);
                        widget.onNewTask();
                        Navigator.pop(context);
                      }else{
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text("Qayerdadur xatolik mavjud!", style: TextStyle(fontSize: 20),),
                              content: Text("\nHamasn toldirishingiz kerak"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text("Tushinarli"),
                                )
                              ],
                            ),
                          );
                        }},
                      child: SvgPicture.asset(MyImages.ic_sent)),
                ],
              ),
              SizedBox(
                height: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
