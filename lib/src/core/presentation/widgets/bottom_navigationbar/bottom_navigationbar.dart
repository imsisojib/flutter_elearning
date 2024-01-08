import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_bottomnav.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final EBottomNav? activeTab;

  const CustomBottomNavigationBar({
    super.key,
    this.activeTab,
  });

  Widget _buildNavButton({
    required bool active,
    required String title,
    required IconData activeIcon,
    required IconData inActiveIcon,
    required Function onPressed,
  }) {
    final theme = Theme.of(sl<NavigationService>().navigatorKey.currentContext!);

    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        iconSize: 52.w,
        onPressed: () {
          onPressed.call();
        },
        icon: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              active ? activeIcon : inActiveIcon,
              size: 16.h,
              color: active? AppColors.red : AppColors.grey600,
            ),
            SizedBox(
              height: 2.h,
            ),
            Text(
              title,
              style: theme.textTheme.labelSmall?.copyWith(
                fontSize: 8.sp,
                color: active ? Colors.white : AppColors.grey600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      height: kToolbarHeight + 16.h,
      margin: EdgeInsets.only(
        bottom: MediaQuery.of(context).padding.bottom,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          //border: Border.all(color: theme.colorScheme.primary,width: 1.h,),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.h),
            topRight: Radius.circular(30.h),
          ),
          boxShadow: [
            BoxShadow(
              color: theme.colorScheme.primary.withOpacity(.3),
              blurRadius: 20,
              offset: const Offset(0, -10),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildNavButton(
            active: activeTab == EBottomNav.home,
            title: "Home",
            activeIcon: Icons.dashboard,
            inActiveIcon: Icons.dashboard_outlined,
            onPressed: () {
              if (activeTab == EBottomNav.home) return;
              Navigator.pushNamedAndRemoveUntil(context, Routes.homeScreen, (route) => false);
            },
          ),

          _buildNavButton(
            active: activeTab == EBottomNav.courses,
            title: "Courses",
            activeIcon: Icons.library_books,
            inActiveIcon: Icons.library_books_outlined,
            onPressed: () {
              if (activeTab == EBottomNav.courses) return;
              Navigator.pushNamedAndRemoveUntil(context, Routes.coursesScreen, (route) => false);
            },
          ),
          _buildNavButton(
            active: activeTab == EBottomNav.progress,
            title: "Progress",
            activeIcon: CupertinoIcons.circle_lefthalf_fill,
            inActiveIcon: CupertinoIcons.circle_righthalf_fill,
            onPressed: () {
              if (activeTab == EBottomNav.progress) return;
              Navigator.pushNamedAndRemoveUntil(context, Routes.progressScreen, (route) => false);
            },
          ),
          _buildNavButton(
            active: activeTab == EBottomNav.more,
            title: "More",
            activeIcon: Icons.more_horiz,
            inActiveIcon: Icons.more_horiz_outlined,
            onPressed: () {
              if (activeTab == EBottomNav.more) return;
              Navigator.pushNamedAndRemoveUntil(context, Routes.moreScreen, (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
