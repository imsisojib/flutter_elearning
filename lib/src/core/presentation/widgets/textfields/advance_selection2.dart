import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvanceSelection2 extends StatefulWidget {
  final String? hintText;
  final String? titleText;
  final TextStyle? tittleTextStyle;
  final String? additionalTittleText;
  final bool isMandatoryField;
  final Widget? prefixIcon;
  final bool enabled;
  final bool obscureText;
  final Function? onStartSelection;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function? validator;
  final String? initialValue;
  final Color? backgroundColor;
  final TextDirection? textDirection;
  final TextAlign? textAlign;

  const AdvanceSelection2({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.enabled = false,
    this.obscureText = false,
    this.onStartSelection,
    this.keyboardType,
    this.validator,
    this.initialValue,
    this.backgroundColor,
    this.titleText,
    this.tittleTextStyle,
    this.additionalTittleText,
    this.isMandatoryField = false,
    this.textInputAction, this.textDirection, this.textAlign,
  }) : super(key: key);

  @override
  State<AdvanceSelection2> createState() => _AdvanceSelection2State();
}

class _AdvanceSelection2State extends State<AdvanceSelection2> {
  TextEditingController? controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    controller?.text = widget.initialValue??"";

    //for dark and light theme
    Color fillColor = theme.brightness==Brightness.light? AppColors.white : AppColors.topSheet;
    Color borderColor = theme.brightness==Brightness.light? AppColors.borderColorLight : AppColors.popupStroke;

    return Column(
      children: [
        widget.titleText == null
            ? const SizedBox()
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.titleText ?? "",
                            style: theme.textTheme.bodyLarge,
                          ),
                          widget.isMandatoryField
                              ? Text(
                                  " *",
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: AppColors.red,
                                  ),
                                )
                              : const Text(""),
                          Text(
                            widget.additionalTittleText ?? "",
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
        InkWell(
          onTap: (){
            widget.onStartSelection?.call();
          },
          child: Container(
            height: 65.h,
            decoration: BoxDecoration(
              border: Border.all(width: 2, color: borderColor,),
              borderRadius: BorderRadius.circular(16),
              color: AppColors.white,
            ),
            padding: const EdgeInsets.all(2),
            child: Row(
              textDirection: TextDirection.ltr,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.prefixIcon==null?const SizedBox(): Row(
                  children: [
                    SizedBox(
                      width: 8.w,
                    ),
                    widget.prefixIcon??const SizedBox(),
                    SizedBox(
                      width: 8.w,
                    ),
                  ],
                ),

                Expanded(
                  child: TextFormField(
                    textDirection: widget.textDirection,
                    textAlign: widget.textAlign??TextAlign.start,
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      color: AppColors.textColorInputLight,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: widget.hintText,
                      hintStyle: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.textColorLabelLight,
                      ),
                      fillColor: AppColors.white,
                      filled: true,
                      enabled: widget.enabled,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
