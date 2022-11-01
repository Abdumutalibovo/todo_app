import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/utils/images.dart';
import '../../models/todo_model.dart';
import '../database/local_database.dart';
import '../utils/colors.dart';

class TaskItem extends StatelessWidget {
  TodoModel? model;
  final VoidCallback onDeleted;

  TaskItem({
    Key? key,
    required this.model,
    required this.onDeleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: MyColors.C_363636,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                model?.id.toString() ?? "-1",
                style: TextStyle(color: Colors.white,),
              ),
              SizedBox(height: 8),
              Text(
                model?.title.toString() ?? "No title",
                style: TextStyle(color: Colors.white,fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 8),
              Text(
                model?.date.toString() ?? "No data",
                style: TextStyle(color: Colors.grey,fontSize: 16, fontWeight: FontWeight.w700),
              ),
            ],
          ),
          Column(
            children: [
              IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Delete"),
                            content: Text(
                              "Are you sure to delete task ${model?.title}",
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {},
                                child: Text("NO"),
                              ),
                              TextButton(
                                onPressed: () async {
                                  var res = await LocalDatabase.deleteTaskById(
                                      model!.id!);

                                  if (res != 0) {
                                    Navigator.pop(context);
                                    onDeleted();
                                  }
                                },
                                child: Text("YES"),
                              ),
                            ],
                          );
                        });
                  },
                  icon: Icon(
                    Icons.delete_forever,
                    color: Colors.red,
                    size: 28,
                  )),
              SizedBox(width: 5,),
              Container(
                width: 42,
                height: 29,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: MyColors.C_363636,
                  border: Border.all(color: Color(0xFF809CFF)),
                ),
                child: Row(
                  children: [
                    Container(child: SvgPicture.asset(MyImages.ic_flags)),
                    SizedBox(width: 5,),
                    Text(model?.priority.toString()??'0', style: TextStyle(color: Colors.white, fontSize:17 ),),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}