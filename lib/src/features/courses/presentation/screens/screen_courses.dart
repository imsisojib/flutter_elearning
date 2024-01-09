import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_bottomnav.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/bottom_navigationbar/bottom_navigationbar.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScreenCourses extends StatelessWidget {
  const ScreenCourses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverCustomAppBar(
              title: "Courses",
              pinned: true,
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, Routes.courseAddScreen,);
                  },
                  icon: Icon(
                    Icons.add,
                  ),
                ),
                SizedBox(
                  width: 24.w,
                ),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavigationBar(
        activeTab: EBottomNav.courses,
      ),
    );
  }
}
