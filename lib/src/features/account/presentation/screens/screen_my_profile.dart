import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/image/circular_image.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/helpers/widget_helper.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

class ScreenMyProfile extends StatelessWidget {
  const ScreenMyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ProviderAccount>(builder: (_, providerAccount, child){
      return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverCustomAppBar(
                title: "My Profile",
                pinned: true,
                showBackButton: true,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 16.h,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircularImage(
                            size: 100.h,
                            imageUrl: providerAccount.currentUser?.profilePicture ?? "",
                            errorWidget: Image.asset(
                              AppImages.placeholderProfile,
                            ),
                          ),
                          Positioned(
                            right: -8,
                            bottom: -8,
                            child: IconButton(
                              onPressed: () async {
                                WidgetHelper.showDialogForConfirmation(
                                  title: "Confirmation",
                                  description: "Do you want to change your profile photo?",
                                  onPositiveAction: () async {
                                    File? pickedImageFile = await WidgetHelper.pickImageFromGallery(
                                      aspectRatio: const CropAspectRatio(ratioX: 4, ratioY: 4),
                                    );
                                    if (pickedImageFile != null) {
                                      WidgetHelper.showDialogForConfirmation(
                                          title: "Confirmation!",
                                          description: "Do you want to upload the selected photo?",
                                          onPositiveAction: () {
                                            providerAccount.updateMyProfilePicture(pickedImageFile.path);
                                          });
                                    } else {
                                      WidgetHelper.showAlertDialog(
                                        title: "Warning!",
                                        description:
                                        "Unable to select photos from Gallery. Please check photo access permission and try again.",
                                      );
                                    }
                                  },
                                );
                              },
                              icon: CircleAvatar(
                                  radius: 30.h,
                                  backgroundColor: AppColors.grey400.withOpacity(.5),
                                  child: const Icon(
                                    Icons.add_a_photo,
                                    color: AppColors.red,
                                    size: 16,
                                  )),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
