import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/utils/images.dart';
import '../../database/local_database.dart';
import '../../models/todo_model.dart';
import '../utils/colors.dart';
import '../utils/time_utils.dart';

class UpdateTaskWidget extends StatefulWidget {
  TodoModel todo;
  VoidCallback onUpdatedTask;

  UpdateTaskWidget({
    Key? key,
    required this.onUpdatedTask,
    required this.todo,
  }) : super(key: key);

  @override
  State<UpdateTaskWidget> createState() => _UpdateTaskWidgetState();
}

class _UpdateTaskWidgetState extends State<UpdateTaskWidget> {
  final formKey = GlobalKey<FormState>();
  String newTitle = "";
  String newDescription = "";
  DateTime? taskDate;
  String newpriorty='';
  int newCategory = -1;
  int newCategoryColor = -1;

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
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15).r),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(top: 25, left: 25).r,
                child: Text(
                  "Edit Task",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16).r,
                child: TextFormField(
                  initialValue: widget.todo.title,
                  onSaved: (val) {
                    newTitle = val ?? "";
                  },
                  style: TextStyle(color: Colors.white),
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
               SizedBox(height: 12.h),
              Padding(
                padding: const EdgeInsets.only(left: 16,right: 16).r,
                child: TextFormField(
                  style: TextStyle(color: Colors.white),
                  initialValue: widget.todo.description,
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
              SizedBox(height: 12.h),
              Text(
                taskDate.toString() == "null"
                    ? ""
                    : TimeUtils.formatToMyTime(taskDate!),
                style: TextStyle(color: Colors.white),
              ),
              // SizedBox(height: 20),
              Row(
                children: [
                  SizedBox(
                    width: 16.w,
                  ),
                  IconButton(
                    onPressed: () async {
                      taskDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.parse(widget.todo.date),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2300),
                      );
                      TimeOfDay? taskTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay(
                          minute: DateTime.parse(widget.todo.date).minute,
                          hour: DateTime.parse(widget.todo.date).hour,
                        ),
                      );
                      taskDate = DateTime(
                        taskDate!.year,
                        taskDate!.month,
                        taskDate!.day,
                        taskTime!.hour,
                        taskTime.minute,
                      );
                      setState(() {});
                    },
                    icon: Icon(
                      Icons.calendar_month,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 24.w,
                  ),
                  SvgPicture.asset(MyImages.ic_pin),
                  SizedBox(
                    width: 32.w,
                  ),
                  InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (((context)=>AlertDialog(
                          contentPadding: EdgeInsets.only(top: 8,left: 8,right: 8).r,
                          title: Center(child: Text('Task Priority',style: TextStyle(color: Colors.white),)),
                          backgroundColor: MyColors.C_363636,
                          content: Container(
                            height: MediaQuery.of(context).size.height*0.42,
                            width: MediaQuery.of(context).size.height*0.9,
                            color: MyColors.C_363636,
                            child: Column(
                              children: [
                                Divider(thickness: 0.7,color: Colors.white70,),
                                SizedBox(height: 5.h,),
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
                                        padding: EdgeInsets.all(8),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              newpriorty = index.toString();
                                            });
                                          },
                                          child: Container(
                                            width: 50.w,
                                            height: 50.h,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF272727),
                                                borderRadius: BorderRadius.circular(6)
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 5.h,),
                                                Container(
                                                  child: SvgPicture.asset(MyImages.ic_flags, width: 26.w,),),
                                                SizedBox(height: 3.h,),
                                                Container(child: Text(index.toString(),style: TextStyle(fontSize: 22.sp, color:
                                                Colors.white),),)
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
                                      padding: const EdgeInsets.only(left: 45).r,
                                      child: InkWell(
                                          onTap: (() {
                                            Navigator.pop(context);
                                          }),
                                          child: Text('Cancel', style: TextStyle(color: Colors.white,),)),
                                    ),
                                    InkWell(
                                        onTap: (){
                                          setState(() {
                                            Navigator.pop(context);
                                            newpriorty = newpriorty;
                                          });
                                        }, child: Container(
                                        height: 50.h,
                                        width: 120.w,
                                        color: MyColors.C_8687E7,
                                        child: Container(
                                            child: Center(child: Text('Save', style: TextStyle(color: Colors.white),)))))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ))));
                      },
                      child: SvgPicture.asset(MyImages.ic_flags)),
                  SizedBox(
                    width: 160.w,
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    // onTap: () {
                    //   formKey.currentState?.save();
                    //   var newTodo = TodoModel(
                    //     id: widget.todo.id,
                    //     title: newTitle,
                    //     description: newDescription,
                    //     date: taskDate.toString(),
                    //     priority: newpriorty,
                    //     categoryId: newCategory,
                    //     isCompleted: 0,
                    //   );
                    //   LocalDatabase.updateTaskById(newTodo);
                    //   widget.onUpdatedTask();
                    //   Navigator.pop(context);
                    // },
                    child: SvgPicture.asset(MyImages.ic_sent),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}