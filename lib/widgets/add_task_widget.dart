import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:numberpicker/numberpicker.dart';
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
  String newprority = '';
  bool onClock=false;
  String newDate1 = '';
  String newDate2 = '';
  String newDate3 = '';
  int _currentIntValue1 = 1;
  int _currentIntValue2 = 1;
  List list = [
    'AM',
    'PM'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Container(
          width: double.infinity,
          height: 600,
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
                  InkWell(
                      onTap: (){
                        setState(() {
                          onClock=!onClock;
                        });
                      },
                      child: SvgPicture.asset(MyImages.ic_hour)),
                  SizedBox(
                    width: 32,
                  ),
                  SvgPicture.asset(MyImages.ic_pin),
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
                          date: newDate3,
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
              onClock?Container(
                height: MediaQuery.of(context).size.height*0.25,
                width: MediaQuery.of(context).size.height*0.9,
                color: Color(0xFF363636),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 40),
                      child: Divider(thickness: 0.7,color: Colors.white70,),
                    ),
                    SizedBox(height: 10,),
                    Padding(
                      padding: const EdgeInsets.only(left: 55),
                      child: Row(children: [
                        Container(
                          width: 70,
                          color: Color(0xFF272727),
                          child: NumberPicker(
                            value: _currentIntValue2,
                            itemHeight: 25,
                            itemWidth: 80,
                            selectedTextStyle:TextStyle(color: Colors.white,fontSize: 25,
                              fontWeight: FontWeight.w800,),
                            textStyle: TextStyle(color: Colors.white12,fontSize: 20),
                            minValue: 0,
                            maxValue: 23,
                            step: 1,
                            haptics: true,
                            onChanged: (value) => setState(() {
                              _currentIntValue2 = value;
                              newDate1 = value.toString();
                            } ),
                          ),
                        ),
                        SizedBox(width: 16,),
                        Container(child: Text(':',style: TextStyle(fontSize: 30, color:
                        Colors.white),),),
                        SizedBox(width: 16,),
                        Container(
                          width: 70,
                          color: Color(0xFF272727),
                          child: NumberPicker(
                            value: _currentIntValue1,
                            itemHeight: 25,
                            itemWidth: 80,
                            selectedTextStyle:TextStyle(color: Colors.white,fontSize: 25,
                              fontWeight: FontWeight.w800,),
                            textStyle: TextStyle(color: Colors.white12,fontSize: 20),
                            minValue: 0,
                            maxValue: 59,
                            step: 1,
                            haptics: true,
                            onChanged: (value) => setState(() {
                              _currentIntValue1 = value;
                              newDate2 = value.toString();
                            } ),
                          ),
                        ),
                        SizedBox(width: 20,),
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 20,horizontal: 12),
                          width: 70,
                          height: 75,
                          color: Color(0xFF272727),
                          child: ListView.separated(
                            itemCount: 2,
                            itemBuilder: (BuildContext context, int count){
                              return Container(
                                child: Text(list[count], style: TextStyle(fontSize: 30,color: Colors.white),),
                              );
                            },
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 0.2,);
                            },
                          ),
                        ),
                      ],),
                    ),
                    SizedBox(height: 32,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 65),
                          child: InkWell(
                              onTap: (() {
                               setState(() {
                                 onClock=!onClock;
                               });
                              }),
                              child: Text('Cancel', style: TextStyle(color: MyColors.C_8687E7,),)),
                        ),
                        InkWell(
                            onTap: (){
                              newDate3 = '$newDate1 : $newDate2';
                            }, child: Padding(
                          padding: const EdgeInsets.only(right: 40),
                          child: Container(
                              height: 50,
                              width: 120,
                              color: MyColors.C_8687E7,
                              child: Container(
                                  child: Center(child: Text('Save', style: TextStyle(color: Colors.white),)))),
                        ))
                      ],
                    ),
                  ],
                ),
              ):Container(),
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