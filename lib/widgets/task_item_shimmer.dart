import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../utils/colors.dart';


class TaskItemShimmer extends StatelessWidget {
  const TaskItemShimmer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20).r,
      margin: EdgeInsets.all(20).r,
      decoration: BoxDecoration(
          color: MyColors.C_363636, borderRadius: BorderRadius.circular(10).r),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 12.h,),
          Row(
            children: [
              Container(
                height: 24.h,
                width: 30.w,
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
                width: 10.w,
              ),
              Container(
                width: 50.w,
                height: 10.h,
                child: Shimmer.fromColors(
                    child: Container(
                      color: Colors.grey,
                    ),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!),
              ),
              SizedBox(width: 180.w,),
              Container(
                height: 20.h,
                width: 20.w,
                child: Shimmer.fromColors(
                    child: Container(
                      color: Colors.grey,
                    ),
                    baseColor: Colors.grey[400]!,
                    highlightColor: Colors.grey[100]!),
              ),
            ],
          ),
          SizedBox(height: 24.h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 14.h,
                width: 120.w,
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
                    height: 30.h,
                    width: 80.w,
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
                  SizedBox(width: 12.w,),
                  Container(
                    width: 42.w,
                    height: 30.h,
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
