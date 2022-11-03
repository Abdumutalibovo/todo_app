import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/utils/colors.dart';
import '../../database/local_database.dart';
import '../../models/todo_model.dart';
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
  String newDescription = "";
  String newprority = '';
  bool onClock=false;
  String newDate1 = '';
  String newDate2 = '';
  String newDate3 = '';
  DateTime? taskDay; // 02.11.2022 ----
  TimeOfDay? taskTime; // ---------- 21:25
  List list = [
    'AM',
    'PM'
  ];
  List<Widget> lists=[
    CategoryWidget(Color(0xFFCCFF80), MyImages.ic_grocery,'Grocery'),
    CategoryWidget(Color(0xFFFF9680), MyImages.ic_work,'Work'),
    CategoryWidget(Color(0xFF80FFFF), MyImages.ic_sport,'Sport'),
    CategoryWidget(Color(0xFF80FFD9), MyImages.ic_design,'Design'),
    CategoryWidget(Color(0xFF809CFF), MyImages.ic_university,'University'),
    CategoryWidget(Color(0xFFFF80EB), MyImages.ic_social,'Social'),
    CategoryWidget(Color(0xFFFC80FF), MyImages.ic_music,'Music'),
    CategoryWidget(Color(0xFF80FFA3), MyImages.ic_healty,'Health'),
    CategoryWidget(Color(0xFF80D1FF), MyImages.ic_movie,'Movie'),
    CategoryWidget(Color(0xFFFF8080), MyImages.icc_home,'Home'),
    CategoryWidget(Color(0xFF80FFD1), MyImages.ic_create,'Create New'),
  ];

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
                      onTap: (){
                        showDialog(context: context, builder: (((context)=>AlertDialog(
                          contentPadding:EdgeInsets.only(top: 8,left: 8,right: 8),
                          title:  Center(child: Text('Choose Category',style: TextStyle(color: Colors.white),)),
                          backgroundColor: MyColors.C_363636,
                          content: Container(
                            height: MediaQuery.of(context).size.height*0.6,
                            width: MediaQuery.of(context).size.height*0.95,
                            color: MyColors.C_363636,
                            child: Column(
                              children: [
                                Divider(thickness: 0.7,color: Colors.white70,),
                                SizedBox(height: 5,),
                                Container(
                                  height: MediaQuery.of(context).size.height*0.5,
                                  width: MediaQuery.of(context).size.height*0.9,
                                  child: GridView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                                    itemCount: 11,
                                    itemBuilder: ((context,index){
                                      return Padding(
                                        padding: EdgeInsets.all(8),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              newprority = index.toString();
                                            });
                                          },
                                          child: lists[index],
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
                                          setState(() {
                                            Navigator.pop(context);
                                            newprority = newprority;
                                          });
                                        },
                                        child: Container(
                                        height: 50,
                                        width: 120,
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
                      child: SvgPicture.asset(MyImages.ic_pin)),
                  SizedBox(
                    width: 32,
                  ),
                  InkWell(
                      onTap: (){
                        showDialog(context: context, builder: (((context)=>AlertDialog(
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
                                          padding: EdgeInsets.all(8),
                                        child: InkWell(
                                          onTap: (){
                                            setState(() {
                                              newprority = index.toString();
                                            });
                                          },
                                          child: Container(
                                            width: 50,
                                            height: 50,
                                            decoration: BoxDecoration(
                                                color: Color(0xFF272727),
                                              borderRadius: BorderRadius.circular(6)
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 5,),
                                                Container(
                                                  child: SvgPicture.asset(MyImages.ic_flags, width: 26,),),
                                                SizedBox(height: 3,),
                                                Container(child: Text(index.toString(),style: TextStyle(fontSize: 22, color:
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
                                      padding: const EdgeInsets.only(left: 45),
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
                                            newprority = newprority;
                                          });
                                        }, child: Container(
                                        height: 50,
                                        width: 120,
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
                    width: 160,
                  ),
                  InkWell(
                      onTap: (){
                        formKey.currentState?.save();
                        var newTodo = TodoModel(
                          title: newTitle,
                          description: newDescription,
                          date: taskDay.toString(),
                          priority: newprority,
                          isCompleted: 0,
                        );
                        LocalDatabase.insertToDatabase(newTodo);
                        widget.onNewTask();
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset(MyImages.ic_sent)),
                ],
              ),
              SizedBox(height: 24,),
            ],
          ),
        ),
      ),
    );
  }
  Widget FlagWidget(newprority){
    return  InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (((context) => AlertDialog(
              contentPadding: EdgeInsets.only(top: 8,left: 8,right: 8),
              content:Container(
                height: MediaQuery.of(context).size.height*0.42,
                width: MediaQuery.of(context).size.height*0.9,
                color: Color(0xFF363636),
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
                        gridDelegate:
                        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
                        itemCount: 10,
                        itemBuilder: ((context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: (){
                                setState(() {
                                  newprority = '2';
                                });
                              },
                              child: Container(
                                  width: 50,
                                  height: 50,
                                  color: Color(0xFF272727),
                                  child: Column(children: [
                                    SizedBox(height: 5,),
                                    Container(
                                      child: SvgPicture.asset(MyImages.ic_flags, width: 26,),),
                                    SizedBox(height: 3,),
                                    Container(child: Text(index.toString(),style: TextStyle(fontSize: 22, color:
                                    Colors.white),),)
                                  ],)
                              ),
                            ),
                          );
                        }),

                      ),
                    ),
                    // SizedBox(height: 32,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 45),
                          child: InkWell(
                              onTap: (() {
                                Navigator.pop(context);
                              }),
                              child: Text('Cancel', style: TextStyle(color: MyColors.C_4C4C7C,),)),
                        ),
                        InkWell(
                            onTap: (){
                              setState(() {
                                Navigator.of(context);
                                newprority = newprority;
                              });
                            }, child: Container(
                            height: 50,
                            width: 120,
                            color: MyColors.C_8687E7,
                            child: Container(
                                child: Center(child: Text('Save', style: TextStyle(color: Colors.white),)))))
                      ],
                    ),
                  ],
                ),),
              backgroundColor: Color(0xFF363636),
              titlePadding: EdgeInsets.only(left: 110,top: 15),
              title: Text('Task Priority',style: TextStyle(color: Colors.white),),
            ))));

      },
      child: Container(
        padding: EdgeInsets.only(left: 25),
        child: SvgPicture.asset(MyImages.ic_flags),
      ),
    );
  }
}