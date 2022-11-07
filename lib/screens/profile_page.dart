import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/screens/profile2_page.dart';

import '../database/local_database.dart';
import '../models/todo_model.dart';
import '../utils/images.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  final formKey = GlobalKey<FormState>();
  String newName = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: LocalDatabase.getList(),
          builder: (BuildContext context, AsyncSnapshot<List<TodoModel>> snapshot){
            if(snapshot.hasData) {
              if(snapshot.data!.isEmpty) {
                return Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height*0.12,),
                    Container(
                      alignment: Alignment.center,
                      child: SvgPicture.asset(MyImages.ic_flags,
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text('What do you want to do today?', style: TextStyle(color:
                      Colors.white, fontSize: MediaQuery.of(context).size.height*0.025),),),
                    SizedBox(height: MediaQuery.of(context).size.height*0.02,),
                    Container(
                      alignment: Alignment.center,
                      child: Text('Tap + to add your tasks', style: TextStyle(color:
                      Colors.white, fontSize: MediaQuery.of(context).size.height*0.025),),)
                  ],
                );
              }
            }
            return Profile2(Model: snapshot.data?[1]);
          }
      ),
    );
  }

}