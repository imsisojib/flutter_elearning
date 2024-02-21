import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvanceDropDown2<T> extends StatelessWidget {
  final String? hintText;
  final String? titleText;
  final TextStyle? tittleTextStyle;
  final String? additionalTittleText;
  final bool isMandatoryField;
  final Widget? icon;
  final bool enabled;
  final Function? onChanged;
  final Color? backgroundColor;
  final List<DropdownMenuItem<T>> items;
  final T? value;
  final double? width;

  const AdvanceDropDown2({
    Key? key,
    this.hintText,
    this.icon,
    this.enabled = true,
    this.onChanged,
    this.value,
    this.backgroundColor,
    required this.items,
    this.width,
    this.titleText,
    this.tittleTextStyle,
    this.additionalTittleText,
    this.isMandatoryField = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    //for dark and light theme
    Color fillColor = theme.brightness==Brightness.light? AppColors.white : AppColors.topSheet;
    Color borderColor = theme.brightness==Brightness.light? AppColors.borderColorLight : AppColors.popupStroke;

    return Column(
      children: [
        titleText == null
            ? const SizedBox()
            : Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      titleText ?? "",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.grey600,
                      ),
                    ),
                    isMandatoryField
                        ? Text(
                      " *",
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: AppColors.red,
                      ),
                    )
                        : const Text(""),
                    Text(
                      additionalTittleText ?? "",
                      style: theme.textTheme.labelSmall,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 2,
            ),
          ],
        ),
        Container(
          height: 65.h,
          decoration: BoxDecoration(
            border: Border.all(width: 2, color: borderColor,),
            borderRadius: BorderRadius.circular(16),
            color: AppColors.white,
          ),
          padding: EdgeInsets.symmetric(
            vertical: 4.h,
            horizontal: 4.w,
          ),
          child: Expanded(
            child: DropdownButtonFormField<T?>(
              value: value,
              items: items,
              onChanged: (T? value){
                onChanged?.call(value);
              },
              iconSize: 12.h,
              icon: icon,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                hintStyle: theme.textTheme.bodyLarge?.copyWith(
                  color: AppColors.textColorLabelLight,
                ),
                fillColor: AppColors.white,
                filled: true,
              ),
            ),
          ),
        ),
      ],
    );
  }
}