import 'dart:io';

import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/image/circular_image.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_datepicker.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_selection.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/helpers/widget_helper.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

class ScreenMyProfile extends StatefulWidget {
  const ScreenMyProfile({super.key});

  @override
  State<ScreenMyProfile> createState() => _ScreenMyProfileState();
}

class _ScreenMyProfileState extends State<ScreenMyProfile> {
  bool editProfile = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ProviderAccount>(builder: (_, providerAccount, child) {
      return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverCustomAppBar(
                title: "My Profile",
                pinned: true,
                showBackButton: true,
                actions: [
                  providerAccount.submitLoading
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : IconButton(
                          onPressed: () {
                            if (editProfile) {
                              //submit data for update
                              providerAccount.updateMyProfileInfo();
                            }
                            setState(() {
                              editProfile = !editProfile;
                            });
                          },
                          icon: editProfile
                              ? const Icon(
                                  Icons.check,
                                  color: AppColors.green,
                                )
                              : const Icon(Icons.edit),
                        ),
                  SizedBox(
                    width: 24.w,
                  ),
                ],
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: 24.w,
                  vertical: 16.h,
                ),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      Text(
                        providerAccount.currentUser?.role ?? "",
                        style: theme.textTheme.labelMedium,
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      AdvanceTextFormField(
                        titleText: "Full Name",
                        hintText: "Full Name",
                        isMandatoryField: true,
                        enabled: editProfile,
                        initialValue: providerAccount.currentUser?.fullName,
                        onChanged: (String value) {
                          var data = providerAccount.currentUser;
                          data?.fullName = value;
                          providerAccount.currentUser = data;
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AdvanceTextFormField(
                        titleText: "Phone Number",
                        hintText: "Phone Number",
                        enabled: false,
                        initialValue: providerAccount.currentUser?.phoneNumber,
                        onChanged: (String value) {},
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AdvanceSelection(
                        titleText: "Country",
                        hintText: "select",
                        initialValue: providerAccount.currentUser?.country,
                        onStartSelection: () {
                          if (!editProfile) return;

                          showCountryPicker(
                            context: context,
                            onSelect: (Country country) {
                              var data = providerAccount.currentUser;
                              data?.country = country.name;
                              providerAccount.currentUser = data;
                            },
                          );
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AdvanceDatePicker(
                        titleText: "Birthdate",
                        hintText: "yyyy-mm-dd",
                        enabled: editProfile,
                        initialValue: providerAccount.currentUser?.birthdate,
                        onPicked: (String date) {
                          var data = providerAccount.currentUser;
                          data?.birthdate = date;
                          providerAccount.currentUser = data;
                        },
                      ),
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
