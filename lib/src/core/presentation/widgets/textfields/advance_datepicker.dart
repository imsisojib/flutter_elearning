import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdvanceDatePicker extends StatefulWidget {
  final String? hintText;
  final String? titleText;
  final TextStyle? tittleTextStyle;
  final String? additionalTittleText;
  final bool isMandatoryField;
  final Icon? prefixIcon;
  final bool enabled;
  final bool obscureText;
  final Function? onPicked;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function? validator;
  final String? initialValue;
  final Color? backgroundColor;

  const AdvanceDatePicker({
    Key? key,
    this.hintText,
    this.prefixIcon,
    this.enabled = true,
    this.obscureText = false,
    this.onPicked,
    this.keyboardType,
    this.validator,
    this.initialValue,
    this.backgroundColor,
    this.titleText,
    this.tittleTextStyle,
    this.additionalTittleText,
    this.isMandatoryField = false,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<AdvanceDatePicker> createState() => _AdvanceDatePickerState();
}

class _AdvanceDatePickerState extends State<AdvanceDatePicker> {
  TextEditingController? controller;

  @override
  void initState() {
    controller ??= TextEditingController();

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
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: AppColors.grey400,
                            ),
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            initialValue: widget.initialValue,
            controller: controller,
            onChanged: (value) {
              widget.onPicked?.call(value);
            },
            cursorColor: AppColors.red,
            style: theme.textTheme.bodySmall,
            obscureText: widget.obscureText,
            keyboardType: widget.keyboardType,
            textInputAction: widget.textInputAction,
            maxLines: 1,
            validator: widget.validator as String? Function(String?)?,
            decoration: InputDecoration(
              fillColor: widget.backgroundColor ?? AppColors.topSheet,
              filled: true,
              contentPadding: EdgeInsets.fromLTRB(10.w, 16.h, 10.w, 16.h),
              prefixIcon: widget.prefixIcon,
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.calendar_month,
                ),
                onPressed: () async {
                  DateTime current = DateTime.now();
                  DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: current,
                    firstDate: DateTime(current.year - 1),
                    lastDate: DateTime(current.year + 1),
                  );
                  if (pickedDate != null) {
                    String pickedDateString = "${pickedDate.year}-${pickedDate.month.toString().padLeft(2,'0')}-${pickedDate.day.toString().padLeft(2,'0')}";
                    //widget.controller ??=TextEditingController();
                    controller?.text = pickedDateString;
                    widget.onPicked?.call(pickedDateString);
                  }
                },
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(
                  color: AppColors.popupStroke,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.popupStroke,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.popupStroke,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.red,
                ),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(
                  color: AppColors.popupStroke,
                ),
              ),
              hintText: widget.hintText,
              hintStyle: TextStyle(
                color: AppColors.grey500,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
              enabled: widget.enabled,
            ),
          ),
        ),
      ],
    );
  }
}
