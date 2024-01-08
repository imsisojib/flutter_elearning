import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/di_container.dart';
import 'package:flutter_boilerplate_code/src/core/application/navigation_service.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/dialogtype_enum.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/stroke_button.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:overlay_support/overlay_support.dart';

class WidgetHelper {
  static void showNotificationToast(String tittle, String? description, DialogTypeEnum? type) {
    showOverlayNotification((context) {
      final theme = Theme.of(context);
      return SafeArea(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 6,
          shadowColor: AppColors.grey75.withOpacity(.1),
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(16.h),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      type == DialogTypeEnum.success ? Icons.check_circle_outline_outlined : type == DialogTypeEnum.failed? Icons.cancel_outlined : Icons.warning_amber_rounded,
                      color: type == DialogTypeEnum.success ? AppColors.green : type == DialogTypeEnum.failed? AppColors.red : Colors.orangeAccent,
                      size: 20.h,
                    ),
                    SizedBox(
                      width: 8.w,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tittle,
                            style: theme.textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            description ?? '',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AppColors.grey500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 2,
                right: 2,
                child: IconButton(
                  iconSize: 20.h,
                  splashRadius: 24.h,
                  icon: const Icon(
                    Icons.close,
                    color: AppColors.grey600,
                  ),
                  onPressed: () {
                    OverlaySupportEntry.of(context)?.dismiss();
                  },
                ),
              ),
            ],
          ),
        ),
      );
    }, duration: const Duration(seconds: 4));
  }

  static Future<File?> pickImageFromGallery({
    required CropAspectRatio aspectRatio,
    CropAspectRatioPreset? aspectRatioPreset,
  }) async {
    final theme = Theme.of(sl<NavigationService>().navigatorKey.currentContext!);
    //pick pickedImage
    final ImagePicker picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      CroppedFile? croppedFile = await ImageCropper().cropImage(
        sourcePath: pickedImage.path,
        /*aspectRatioPresets: [
          ratio ?? CropAspectRatioPreset.square,
          //by default it will be square size.
        ],*/
        aspectRatioPresets: Platform.isAndroid
            ? [
                aspectRatioPreset ?? CropAspectRatioPreset.square,
              ]
            : [],
        aspectRatio: Platform.isIOS ? aspectRatio : null,
        compressQuality: 75,
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: 'Crop Image',
              toolbarColor: theme.colorScheme.primary,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: aspectRatioPreset ?? CropAspectRatioPreset.square,
              lockAspectRatio: true),
          IOSUiSettings(
            title: 'Crop Image',
            aspectRatioLockEnabled: true,
            resetAspectRatioEnabled: false,
          ),
        ],
      );

      if (croppedFile != null) {
        return File(croppedFile.path);
      }
    }

    return null;
  }

  static void showDialogForConfirmation({
    required String title,
    required String description,
    required Function onPositiveAction,
  }) {
    final theme = Theme.of(sl<NavigationService>().navigatorKey.currentContext!);
    showDialog(
      barrierLabel: "ConfirmationDialog",
      //barrierColor: Colors.transparent,
      context: sl<NavigationService>().navigatorKey.currentContext!,
      builder: (context) {
        return _BlurryDialog(
          alertDialog: AlertDialog(
            backgroundColor: theme.cardColor,
            shadowColor: const Color(0xff6B3CB0).withOpacity(.7),
            elevation: 7,
            //backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: const BorderSide(
                strokeAlign: 2,
                style: BorderStyle.solid,
                color: Color(0xff8148C3),
              ),
            ),
            title: Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            //titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //insetPadding: EdgeInsets.zero,
            buttonPadding: const EdgeInsets.all(16),
            content: Text(
              description,
              style: theme.textTheme.bodyMedium,
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: <Widget>[
              StrokeButton(
                strokeWidth: 1,
                height: 30.h,
                width: 70.w,
                backgroundColor: AppColors.topSheet,
                strokeColor: const Color(0xff5A4080),
                onPressed: () {
                  Navigator.pop(context);
                },
                buttonText: 'No',
                buttonTextStyle: theme.textTheme.labelSmall?.copyWith(
                  color: AppColors.grey500,
                ),
              ),
              BasicButton(
                height: 30.h,
                width: 70.w,
                buttonText: "Yes",
                onPressed: () {
                  Navigator.pop(context);
                  onPositiveAction.call();
                },
                buttonTextStyle: theme.textTheme.labelSmall?.copyWith(),
              ),
            ],
          ),
        );
      },
    );
  }

  static void showAlertDialog({
    required String title,
    required String description,
  }) {
    final theme = Theme.of(sl<NavigationService>().navigatorKey.currentContext!);
    showDialog(
      barrierLabel: "AlertDialog",
      //barrierColor: Colors.transparent,
      context: sl<NavigationService>().navigatorKey.currentContext!,
      builder: (context) {
        return _BlurryDialog(
          alertDialog: AlertDialog(
            backgroundColor: theme.cardColor,
            //backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            title: Text(
              title,
              style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600),
            ),
            //titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //insetPadding: EdgeInsets.zero,
            buttonPadding: const EdgeInsets.all(16),
            content: Text(
              description,
              style: theme.textTheme.bodyMedium,
            ),
            actionsAlignment: MainAxisAlignment.end,
            actions: <Widget>[
              BasicButton(
                height: 30.h,
                width: 70.w,
                buttonText: "Ok",
                onPressed: () {
                  Navigator.pop(context);
                },
                buttonTextStyle: theme.textTheme.labelSmall,
              ),
            ],
          ),
        );
      },
    );
  }

  static void showDialogWithDynamicContent({
    required Widget content,
    Color? popupBackgroundColor,
    Color? popupBorderColor,
  }) {
    final theme = Theme.of(sl<NavigationService>().navigatorKey.currentContext!);
    showDialog(
      barrierLabel: "ConfirmationDialog",
      //barrierColor: Colors.transparent,
      context: sl<NavigationService>().navigatorKey.currentContext!,
      builder: (context) {
        return _BlurryDialog(
          alertDialog: AlertDialog(
            backgroundColor: popupBackgroundColor??theme.cardColor,
            shadowColor: const Color(0xff6B3CB0).withOpacity(.7),
            elevation: 7,
            //backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                strokeAlign: 2,
                style: BorderStyle.solid,
                color: popupBorderColor??AppColors.popupStroke,
              ),
            ),
            //titlePadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            //insetPadding: EdgeInsets.zero,
            buttonPadding: EdgeInsets.all(16.h),
            content: content,
          ),
        );
      },
    );
  }



  static Future<void> showAlertDialogForAppUpdate(String? title, String? body, {Function? function}) async {
    await showDialog(
      context: sl<NavigationService>().navigatorKey.currentContext!,
      barrierDismissible: false,
      builder: (BuildContext context) {
        final theme = Theme.of(context);

        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.h),
            ),
            actionsPadding: EdgeInsets.symmetric(
              horizontal: 12.w,
              vertical: 12.h,
            ),
            title: Text(
              title ?? "",
              softWrap: true,
              textAlign: TextAlign.start,
            ),
            content: Text(
              body ?? "",
              textAlign: TextAlign.start,
              style: theme.textTheme.bodyMedium,
            ),
            actions: <Widget>[
              BasicButton(
                buttonText: "INSTALL",
                onPressed: () {
                  function?.call();
                },
              )
            ],
          ),
        );
      },
    );
  }

  static String countryCodeToEmoji(String? countryCode) {
    if (countryCode?.isEmpty ?? true) {
      //simply return empty string when countryCode is empty or null
      return "";
    }
    if (countryCode!.length > 2) {
      //country code should not exceed length of 2
      return "";
    }
    // 0x41 is Letter A
    // 0x1F1E6 is Regional Indicator Symbol Letter A
    // Example :
    // firstLetter U => 20 + 0x1F1E6
    // secondLetter S => 18 + 0x1F1E6
    // See: https://en.wikipedia.org/wiki/Regional_Indicator_Symbol
    try {
      final int firstLetter = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
      final int secondLetter = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;
      return String.fromCharCode(firstLetter) + String.fromCharCode(secondLetter);
    } catch (e) {
      return "";
    }
  }

  static void showBottomSheet({required Widget content, bool expand = false, double radius = 16}) {
    showModalBottomSheet<void>(
      context: sl<NavigationService>().navigatorKey.currentContext!,
      isScrollControlled: expand,
      builder: (BuildContext context) {
        //final theme = Theme.of(context);
        return Material(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(24.w), topRight: Radius.circular(24.w)),
          color: AppColors.bottomSheet,
          child: content,
        );
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.w), topRight: Radius.circular(24.w)),
      ),
    );
  }
}

class _BlurryDialog extends StatelessWidget {
  final AlertDialog alertDialog;

  const _BlurryDialog({
    required this.alertDialog,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
      child: alertDialog,
    );
  }
}
