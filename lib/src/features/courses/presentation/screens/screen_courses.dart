import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_bottomnav.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/bottom_navigationbar/bottom_navigationbar.dart';
import 'package:flutter_boilerplate_code/src/features/courses/presentation/providers/provider_courses.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenCourses extends StatefulWidget {
  const ScreenCourses({super.key});

  @override
  State<ScreenCourses> createState() => _ScreenCoursesState();
}

class _ScreenCoursesState extends State<ScreenCourses> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderCourses>(context, listen: false).fetchMyCourses();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderCourses>(
      builder: (_, providerCourses, child) {
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
                        Navigator.pushNamed(
                          context,
                          Routes.courseAddScreen,
                        );
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
                providerCourses.loading
                    ? const SliverToBoxAdapter(
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      )
                    : SliverPadding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 16.h,
                        ),
                        sliver: providerCourses.myCourses.isEmpty
                            ? SliverFillRemaining(
                                child: Center(
                                  child: Text("No course found!"),
                                ),
                              )
                            : SliverList.separated(
                                itemCount: providerCourses.myCourses.length,
                                itemBuilder: (_, index) {
                                  return Card(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 16.w,
                                        vertical: 8.h,
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Course Name: ",
                                          ),
                                          Text(
                                            providerCourses.myCourses[index].name ?? "",
                                          ),
                                          Text(
                                            "Course Price: ",
                                          ),
                                          Text(
                                            "${providerCourses.myCourses[index].price}",
                                          ),
                                        ],
                                      ),
                                    ),
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
            ),
          ),
          bottomNavigationBar: const CustomBottomNavigationBar(
            activeTab: EBottomNav.courses,
          ),
        );
      },
    );
  }
}
