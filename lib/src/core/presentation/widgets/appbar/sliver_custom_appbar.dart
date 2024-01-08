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
      toolbarHeight: kToolbarHeight + 24.h,
      pinned: pinned,
      automaticallyImplyLeading: false,
      centerTitle: false,
      title: Text(
        title,
        style: theme.textTheme.titleMedium?.copyWith(
          fontSize: 24.sp,
          color: AppColors.grey400,
          fontWeight: FontWeight.w600,
        ),
      ),
      leading: showBackButton
          ? IconButton(
              iconSize: 20.h,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.grey400,
              ),
            )
          : null,
      actions: actions,
    );
  }
}
