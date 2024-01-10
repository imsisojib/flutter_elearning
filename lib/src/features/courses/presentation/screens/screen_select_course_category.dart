import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/entities/course_category.dart';
import 'package:flutter_boilerplate_code/src/features/courses/presentation/providers/provider_courses.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenSelectCourseCategory extends StatelessWidget {
  const ScreenSelectCourseCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: FutureBuilder(
          future: Provider.of<ProviderCourses>(context, listen: false).getCourseCategories(),
          builder: (_, AsyncSnapshot<List<CourseCategory>> response) {
            if (response.connectionState == ConnectionState.done) {
              List<CourseCategory> categories = response.data ?? [];
              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverCustomAppBar(
                    title: "Select Category",
                    pinned: true,
                  ),
                  SliverPadding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    sliver: categories.isEmpty
                        ? SliverFillRemaining(
                            child: Center(
                              child: Text("Found Nothing!"),
                            ),
                          )
                        : SliverList.separated(
                            itemCount: categories.length,
                            itemBuilder: (_, index) {
                              return ListTile(
                                tileColor: AppColors.topSheet,
                                title: Text(categories[index].name ?? ""),
                                onTap: () {
                                  var data = Provider.of<ProviderCourses>(context, listen: false).requestBodyCourse;
                                  data?.categoryId = categories[index].id;
                                  data?.categoryName = categories[index].name;
                                  Provider.of<ProviderCourses>(context, listen: false).requestBodyCourse = data;

                                  Navigator.pop(context);
                                },
                              );
                            },
                            separatorBuilder: (_, index) {
                              return SizedBox(
                                height: 16.h,
                              );
                            },
                          ),
                  ),
                ],
              );
            }

            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
