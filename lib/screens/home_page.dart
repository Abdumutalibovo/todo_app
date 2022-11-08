import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/utils/colors.dart';
import '../database/local_database.dart';
import '../models/todo_model.dart';
import '../theme_provider.dart';
import '../widgets/task_item.dart';
import '../widgets/update_task_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String search='';
  int countOfCompleted=0;
  int countOfUncompleted=0;
  @override


  Widget build(BuildContext context) {
    var isLight=context.watch<ThemeProvider>().getIsLight();
    return Scaffold(
      backgroundColor: isLight? Colors.white:Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchTodoes(isLight),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: todayTodos(isLight),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: completedTodos(isLight),
            ),
            const SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }

  Widget searchTodoes(isLight){
    return  Padding(
      padding:  const EdgeInsets.only(left: 24, right: 24),
      child: TextField(
        onChanged: (val){
          setState(() {
            search=val;
          });
        },
        style: const TextStyle(color: Colors.white),
        decoration: const InputDecoration(
          hintText: "Search for your task...",
          prefixIcon: Icon(
            Icons.search,
            color: Colors.grey,
          ),
          hintStyle: TextStyle(
              color: Colors.grey,
              fontWeight: FontWeight.w400,
              fontSize: 16),
          filled: true,
          fillColor: Colors.black,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 100, 99, 99),
              )),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide(
                color: Color.fromARGB(255, 100, 99, 99),
              )),
        ),
      ),
    );
  }

  Widget todayTodos(isLight) {
    return ExpansionTile(
      iconColor: isLight?Colors.black:Colors.white,
      title: Text(
        'Uncompleted'.tr(),
        style: TextStyle(color: isLight?Colors.black:Colors.white,),
      ),
      children: [
        SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: FutureBuilder(
            future: LocalDatabase.getTodosIsCompeted(0, title: search),
            builder: (BuildContext context,
                AsyncSnapshot<List<TodoModel>> snapshot) {
              if (snapshot.hasData) {
                countOfUncompleted = snapshot.data!.length;
                if (snapshot.data!.isEmpty) {
                  return const Center(
                      child: Icon(
                        Icons.file_copy_outlined,
                        color: Colors.white,
                        size: 96,
                      ));
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      onCompleted: (todo) {
                        setState(() {
                          LocalDatabase.updateTaskById(
                            todo.copyWith(isCompleted: 1),
                          );
                        });
                      },
                      model: snapshot.data![index],
                      onDeleted: () {
                        setState(() {});
                      },
                      onSelected: () {
                        showModalBottomSheet(
                          backgroundColor: MyColors.C_363636,
                          context: context,
                          builder: (context) {
                            return UpdateTaskWidget(
                              todo: snapshot.data![index],
                              onUpdatedTask: () {
                                setState(() {});
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  Widget completedTodos(isLight) {
    return ExpansionTile(
      iconColor: isLight?Colors.black:Colors.white,
      title: Text(
        'Completed'.tr(),
        style: TextStyle(color: isLight?Colors.black:Colors.white,),
      ),
      children: [
        FutureBuilder(
          future: LocalDatabase.getTodosIsCompeted(1, title: search),
          builder:
              (BuildContext context, AsyncSnapshot<List<TodoModel>> snapshot) {
            if (snapshot.hasData) {
              countOfCompleted = snapshot.data!.length;
              if (snapshot.data!.isEmpty) {
                return const Center(
                    child: Icon(
                      Icons.file_copy_outlined,
                      color: Colors.white,
                      size: 96,
                    ));
              }
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskItem(
                    model: snapshot.data![index],
                    onCompleted: (todo) {
                      setState(() {
                        LocalDatabase.updateTaskById(
                          todo.copyWith(isCompleted: 0),
                        );
                      });
                    },
                    onDeleted: () {
                      setState(() {});
                    },
                    onSelected: () {
                      showModalBottomSheet(
                        backgroundColor: MyColors.C_363636,
                        context: context,
                        builder: (context) {
                          return UpdateTaskWidget(
                            todo: snapshot.data![index],
                            onUpdatedTask: () {
                              setState(() {});
                            },
                          );
                        },
                      );
                    },
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}