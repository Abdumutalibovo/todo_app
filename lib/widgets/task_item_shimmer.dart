import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/colors.dart';


class TaskItemShimmer extends StatelessWidget {
  const TaskItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: MyColors.C_363636, borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12,),
          Row(
            children: [
              Container(
                height: 24,
                width: 30,
                child: Shimmer.fromColors(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                    ),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 50,
                height: 10,
                child: Shimmer.fromColors(
                    child: Container(
                      color: Colors.grey,
                    ),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!),
              ),
              SizedBox(width: 180,),
              Container(
                height: 20,
                width: 20,
                child: Shimmer.fromColors(
                    child: Container(
                      color: Colors.grey,
                    ),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!),
              ),
            ],
          ),
          SizedBox(height: 24,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 14,
                width: 120,
                padding: EdgeInsets.only(left: 8),
                child: Shimmer.fromColors(
                    child: Container(
                      color: Colors.grey,
                    ),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!),
              ),
              Row(
                children: [
                  Container(
                    height: 30,
                    width: 80,
                    child: Shimmer.fromColors(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[100]!),
                  ),
                  SizedBox(width: 12,),
                  Container(
                    width: 42,
                    height: 30,
                    child: Shimmer.fromColors(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(6),
                            color: Colors.grey
                          ),
                        ),
                        baseColor: Colors.grey[400]!,
                        highlightColor: Colors.grey[100]!),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
