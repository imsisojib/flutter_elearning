import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ContainerBg extends StatelessWidget{
  final Widget child;
  const ContainerBg({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 24.h,
      ),
      decoration:  const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xffD2F2F0),
            AppColors.scaffoldColorLight,
            AppColors.scaffoldColorLight,
          ],
        ),
      ),
      child: child,
    );
  }
}