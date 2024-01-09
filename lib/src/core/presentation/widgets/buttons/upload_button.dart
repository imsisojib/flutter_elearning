import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadButton extends StatelessWidget {
  final String title;
  final Widget icon;
  final Function? onPressed;
  final Widget? selectedFileOrPicture;
  final Function? onRemoveFileOrPhotos;

  ///if file/photo is not select then pass null

  const UploadButton({
    super.key,
    required this.title,
    required this.icon,
    this.onPressed,
    this.selectedFileOrPicture,
    this.onRemoveFileOrPhotos,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DottedBorder(
      dashPattern: [
        6,
      ],
      borderType: BorderType.RRect,
      color: AppColors.popupStroke,
      radius: const Radius.circular(12),
      strokeWidth: 2,
      child: InkWell(
        onTap: () {
          onPressed?.call();
        },
        child: Container(
          height: 120.h,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(
            horizontal: 8,
            vertical: 8,
          ),
          decoration: const BoxDecoration(
            color: AppColors.topSheet,
          ),
          child: selectedFileOrPicture == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    icon,
                    SizedBox(
                      height: 4.h,
                    ),
                    Text(
                      title,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: AppColors.grey400,
                      ),
                    ),
                  ],
                )
              : Stack(
                  fit: StackFit.expand,
                  children: [
                    selectedFileOrPicture!,
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        onPressed: () {
                          onRemoveFileOrPhotos?.call();
                        },
                        icon: Icon(
                          Icons.close,
                          color: AppColors.grey400,
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
