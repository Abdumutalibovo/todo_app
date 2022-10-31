import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/utils/images.dart';
import '../database/local_database.dart';
import '../models/todo_model.dart';
import '../widgets/task_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: FutureBuilder(
        future: LocalDatabase.getList(),
        builder:
            (BuildContext context, AsyncSnapshot<List<TodoModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Center(
                  child: SvgPicture.asset(MyImages.ic_fingerprint),);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               const Padding(
                 padding: const EdgeInsets.only(left: 24, right: 24),
                 child: const  TextField(
                   style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: "Search for your task...",
                      prefixIcon: Icon(Icons.search, color: Colors.grey,),
                      hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w400, fontSize: 16),
                      filled: true,
                      fillColor: Colors.black,
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Color.fromARGB(255, 100, 99, 99),)
                      ),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                          borderSide: BorderSide(color: Color.fromARGB(255, 100, 99, 99),)
                      ),
                    ),
                  ),
               ),
                const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Container(
                width: 76,
                height: 31,
                padding: const EdgeInsets.only(left: 10, top: 5, bottom: 7, right: 7),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white.withOpacity(0.21),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Today", style:TextStyle(color: Colors.white)),
                      Icon(Icons.arrow_drop_down_sharp, color: Colors.white.withOpacity(0.87),)
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return TaskItem(
                    model: snapshot.data?[index],
                    onDeleted: () {
                      setState(() {});
                    },
                  );
                },
              ),
            ),
            ]
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}