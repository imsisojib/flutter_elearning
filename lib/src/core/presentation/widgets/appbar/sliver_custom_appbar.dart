import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SliverCustomAppBar extends StatelessWidget {
  final String title;
  final bool pinned;
  final bool showBackButton;
  final List<Widget>? actions;

  const SliverCustomAppBar({
    super.key,
    required this.title,
    this.pinned = false,
    this.showBackButton = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SliverAppBar(
      toolbarHeight: kToolbarHeight,
      pinned: pinned,
      automaticallyImplyLeading: false,
      centerTitle: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              showBackButton
                  ? IconButton(
                padding: EdgeInsets.zero,
                iconSize: 16.h,
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: AppColors.textColorLight,
                ),
              )
                  : const SizedBox(),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w700,
                ),
              )
            ],
          )
        ],
      ),
      //title: ,
      //leading:
      //actions: actions,
    );
  }
}
