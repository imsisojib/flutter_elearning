import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GradientButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Function? onPressed;
  final Widget? suffix;
  final Widget? prefix;
  final String buttonText;
  final TextStyle? buttonTextStyle;
  const GradientButton({super.key, this.width, this.height=60,this.onPressed, this.suffix, this.prefix, required this.buttonText, this.buttonTextStyle});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.h),
          gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xffF71353),
                Color(0xffB51CFD),
              ])),
      height: height!.h,
      width: MediaQuery.of(context).size.width,
      child: MaterialButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.h),
        ),
        onPressed: () {},
        child: Text(
          buttonText,
          style: buttonTextStyle??theme.textTheme.bodySmall,
        ),
      ),
    );
  }
}
