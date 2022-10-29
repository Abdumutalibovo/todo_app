import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import '../utils/colors.dart';

int _currentValue = 0;
List list = ['AM', 'PM'];
int count = 0;
//
// Widget HourWidget(BuildContext context, onClock){
//   return Container(
//     height: MediaQuery.of(context).size.height * 0.25,
//     width: MediaQuery.of(context).size.height * 0.9,
//     color: Color(0xFF363636),
//     child: Column(
//       children: [
//         Divider(
//           thickness: 0.7,
//           color: Colors.white70,
//         ),
//         SizedBox(
//           height: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 25),
//           child: Row(
//             children: [
//               Container(
//                 width: 70,
//                 color: Color(0xFF272727),
//                 child: NumberPicker(
//                   value: _currentValue,
//                   itemHeight: 25,
//                   itemWidth: 80,
//                   selectedTextStyle: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25,
//                     fontWeight: FontWeight.w800,
//                   ),
//                   textStyle: TextStyle(
//                       color: Colors.white12, fontSize: 20),
//                   minValue: 0,
//                   maxValue: count == 0 ? 12 : 24,
//                   step: 1,
//                   haptics: true,
//                   onChanged: (value) =>
//                       setState(() => _currentValue = value),
//                 ),
//               ),
//               SizedBox(
//                 width: 16,
//               ),
//               Container(
//                 child: Text(
//                   ':',
//                   style: TextStyle(
//                       fontSize: 30, color: Colors.white),
//                 ),
//               ),
//               SizedBox(
//                 width: 16,
//               ),
//               Container(
//                 width: 70,
//                 color: Color(0xFF272727),
//                 child: NumberPicker(
//                   infiniteLoop: false,
//                   value: _currentValue,
//                   itemHeight: 25,
//                   itemWidth: 80,
//                   selectedTextStyle: TextStyle(
//                     color: Colors.white,
//                     fontSize: 25,
//                     fontWeight: FontWeight.w800,
//                   ),
//                   textStyle: TextStyle(
//                       color: Colors.white12, fontSize: 20),
//                   minValue: 0,
//                   maxValue: 60,
//                   step: 1,
//                   haptics: true,
//                   onChanged: (value) =>
//                       setState(() => _currentValue = value),
//                 ),
//               ),
//               SizedBox(
//                 width: 20,
//               ),
//               Container(
//                 padding: EdgeInsets.symmetric(
//                     vertical: 20, horizontal: 12),
//                 width: 70,
//                 height: 75,
//                 color: Color(0xFF272727),
//                 child: ListView.separated(
//                   itemCount: 2,
//                   itemBuilder: (BuildContext context, int count) {
//                     return Container(
//                       child: Text(
//                         list[count],
//                         style: TextStyle(
//                             fontSize: 30, color: Colors.white),
//                       ),
//                     );
//                   },
//                   separatorBuilder: (context, index) {
//                     return SizedBox(
//                       height: 0.2,
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(
//           height: 32,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(left: 45),
//               child: InkWell(
//                   onTap: (() {
//                     Navigator.pop(context);
//                   }),
//                   child: Text(
//                     'Cancel',
//                     style: TextStyle(
//                       color: Colors.white,
//                     ),
//                   )),
//             ),
//             InkWell(
//                 onTap: () {
//                   setState(() {
//                     //  Navigator.push(context, MaterialPageRoute(builder: (_)=> StartScreen()));
//                   });
//                 },
//                 child: Container(
//                     height: 50,
//                     width: 120,
//                     color: MyColors.C_8687E7,
//                     child: Container(
//                         child: Center(
//                             child: Text(
//                               'Save',
//                               style: TextStyle(color: Colors.white),
//                             )))))
//           ],
//         ),
//       ],
//     ),
//   );
// }