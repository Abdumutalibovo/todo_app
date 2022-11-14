import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_app/utils/images.dart';
import '../../models/todo_model.dart';
import '../database/local_database.dart';
import '../models/category_model.dart';
import '../utils/colors.dart';

class TaskItem extends StatelessWidget {
  TodoModel model;
  final VoidCallback onDeleted;
  final VoidCallback onSelected;
  final ValueChanged<TodoModel> onCompleted;
  DateTime? taskDate;
  TaskItem({
    Key? key,
    required this.model,
    required this.onDeleted,
    required this.onSelected,
    required this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onSelected,
      child: Container(
        padding: EdgeInsets.all(20).r,
        margin: EdgeInsets.all(20).r,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10).r,
          color: MyColors.C_363636,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    onCompleted(model);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: model.isCompleted == 1
                            ? Colors.green
                            : Colors.transparent,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white,
                          width: 2.w,
                        )),
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
                SizedBox(width: 10.w,),
                Padding(
                  padding: const EdgeInsets.only(right: 160).r,
                  child: Container(
                    child: Text(
                      model!.title,
                      style: TextStyle(color: Colors.white,fontSize: 20.sp, fontWeight: FontWeight.w700),
                    ),
                  ),
                ),
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
                      size: 28.r,
                    )),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  model?.date.toString() ?? "No data",
                  style: TextStyle(color: Colors.grey,fontSize: 10.sp, fontWeight: FontWeight.w400),
                ),
                Row(
                  children: [
                    Container(
                        height: 30.h,
                        decoration: BoxDecoration(
                          color: Color(CategoryModel.lists[model!.categoryId].color),
                          borderRadius: BorderRadius.circular(4).r,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(6).r,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(CategoryModel.lists[model!.categoryId].icon??""),
                              Padding(
                                padding: const EdgeInsets.only(right: 10).r,
                                child: Text(
                                  CategoryModel.lists[(model!.categoryId)].name.toString(),
                                  style: TextStyle(color: Colors.white,fontSize: 14.sp,),
                                ),
                              ),
                            ],
                          ),
                        )),
                    SizedBox(width: 12.w,),
                    Container(
                      width: 42.w,
                      height: 30.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6).r,
                        color: MyColors.C_363636,
                        border: Border.all(color: Color(0xFF809CFF)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(child: SvgPicture.asset(MyImages.ic_flags)),
                          // SizedBox(width: 3,),
                          Text(model?.priority.toString()??'0', style: TextStyle(color: Colors.white, fontSize:17.sp),),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  Widget todayTodos(){
    return ExpansionTile(title: Text('Today', style: TextStyle(color: Colors.white,),));
}
}