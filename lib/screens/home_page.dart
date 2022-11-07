import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/utils/colors.dart';
import 'package:todo_app/utils/images.dart';
import '../database/local_database.dart';
import '../models/todo_model.dart';
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
  int countOfUnCompleted=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            searchTodoes(),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: UncomplatedTodos(),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10,right: 10),
              child: CompletedTodos(),
            ),
            SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }

  Widget searchTodoes(){
    return  Padding(
      padding:  EdgeInsets.only(left: 24, right: 24),
      child: TextField(
        onChanged: (val){
          setState(() {
            search=val;
          });
        },
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
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

  Widget UncomplatedTodos(){
    return  ExpansionTile(
      title: Text('Uncomplated ($countOfUnCompleted)', style: TextStyle(color: Colors.white),),
      children: [
        SingleChildScrollView(
          child: FutureBuilder(
            future: LocalDatabase.getTodosIsCompeted(0),
            builder:
                (BuildContext context, AsyncSnapshot<List<TodoModel>> snapshot) {
              if (snapshot.hasData) {
                countOfUnCompleted=snapshot.data!.length;
                if (snapshot.data!.isEmpty) {
                  return Center(
                    child: SvgPicture.asset(MyImages.ic_fingerprint),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      model: snapshot.data?[index],
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
                            });
                      },
                      onCompleted: (todo){
                        setState(() {
                          LocalDatabase.getTodosIsCompeted(0,title: search);
                        });
                      },
                      onDeleted: () {
                        setState(() {});
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }

  Widget CompletedTodos(){
    return  ExpansionTile(
      title: Text('Completed ($countOfCompleted)', style: TextStyle(color: Colors.white),),
      children: [
        FutureBuilder(
          future: LocalDatabase.getTodosIsCompeted(1),
          builder:
              (BuildContext context, AsyncSnapshot<List<TodoModel>> snapshot) {
            if (snapshot.hasData) {
              countOfCompleted=snapshot.data!.length;
              if (snapshot.data!.isEmpty) {
                return Center(
                  child: SvgPicture.asset(MyImages.ic_fingerprint),
                );
              }
              return Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskItem(
                      onCompleted: (todo){
                        setState(() {
                          LocalDatabase.getTodosIsCompeted(1,title: search);
                        });
                      },
                      model: snapshot.data?[index],
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
                            });
                      },
                      onDeleted: () {
                        setState(() {});
                      },
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ],
    );
  }
}
