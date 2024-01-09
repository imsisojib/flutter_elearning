import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/upload_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_selection.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/textfields/advance_textfield.dart';
import 'package:flutter_boilerplate_code/src/features/courses/presentation/providers/provider_courses.dart';
import 'package:flutter_boilerplate_code/src/helpers/widget_helper.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:provider/provider.dart';

class ScreenCourseUpdate extends StatefulWidget {
  const ScreenCourseUpdate({super.key});

  @override
  State<ScreenCourseUpdate> createState() => _ScreenCourseUpdateState();
}

class _ScreenCourseUpdateState extends State<ScreenCourseUpdate> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProviderCourses>(builder: (_, providerCourses, child) {
      return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverCustomAppBar(
                title: "Update Course",
                pinned: true,
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                sliver: SliverToBoxAdapter(
                  child: Column(
                    children: [
                      // UploadButton(
                      //   title: "Add Thumbnail Photo",
                      //   icon: Icon(
                      //     Icons.add,
                      //   ),
                      //   onPressed: () async {
                      //     File? pickedFile = await WidgetHelper.pickImageFromGallery(
                      //       aspectRatio: const CropAspectRatio(ratioX: 16, ratioY: 9),
                      //     );
                      //     var data = providerCourses.requestBodyCourse;
                      //     data?.thumbnailPath = pickedFile?.path;
                      //     providerCourses.requestBodyCourse = data;
                      //   },
                      //   onRemoveFileOrPhotos: () {
                      //     var data = providerCourses.requestBodyCourse;
                      //     data?.thumbnailPath = null;
                      //     providerCourses.requestBodyCourse = data;
                      //   },
                      //   selectedFileOrPicture: providerCourses.requestBodyCourse?.thumbnailPath != null
                      //       ? Image.file(
                      //           File(providerCourses.requestBodyCourse!.thumbnailPath!),
                      //           fit: BoxFit.cover,
                      //         )
                      //       : null,
                      // ),
                      // SizedBox(
                      //   height: 16.h,
                      // ),
                      AdvanceTextFormField(
                        titleText: "Course Name",
                        hintText: "Course Name",
                        isMandatoryField: true,
                        initialValue: providerCourses.requestBodyCourse?.name,
                        onChanged: (String value) {
                          var data = providerCourses.requestBodyCourse;
                          data?.name = value;
                          providerCourses.requestBodyCourse = data;
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      // AdvanceSelection(
                      //   titleText: "Course Category",
                      //   hintText: "Course Category",
                      //   isMandatoryField: true,
                      //   initialValue: providerCourses.requestBodyCourse?.categoryName,
                      //   onStartSelection: () {
                      //     //navigate to select course category page
                      //     Navigator.pushNamed(context, Routes.courseCategorySelectScreen,);
                      //   },
                      // ),
                      // SizedBox(
                      //   height: 8.h,
                      // ),
                      AdvanceTextFormField(
                        titleText: "Course Price",
                        hintText: "Course Price",
                        isMandatoryField: true,
                        initialValue: "${providerCourses.requestBodyCourse?.price??0}",
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          if (value.isEmpty) return;
                          var data = providerCourses.requestBodyCourse;
                          data?.price = double.parse(value);
                          providerCourses.requestBodyCourse = data;
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AdvanceTextFormField(
                        titleText: "Course Offer Price",
                        hintText: "Course Offer Price",
                        additionalTittleText: "No need to change if course has no offer price.",
                        initialValue: "${providerCourses.requestBodyCourse?.offerPrice??0}",
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          if (value.isEmpty) return;
                          var data = providerCourses.requestBodyCourse;
                          data?.offerPrice = double.parse(value);
                          providerCourses.requestBodyCourse = data;
                        },
                      ),
                      AdvanceTextFormField(
                        titleText: "Total Class",
                        hintText: "Total Class",
                        isMandatoryField: true,
                        initialValue: "${providerCourses.requestBodyCourse?.totalClass??0}",
                        keyboardType: TextInputType.number,
                        onChanged: (String value) {
                          if (value.isEmpty) return;
                          var data = providerCourses.requestBodyCourse;
                          data?.totalClass = int.parse(value);
                          providerCourses.requestBodyCourse = data;
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      AdvanceTextFormField(
                        titleText: "Description",
                        hintText: "Description",
                        maxLines: 6,
                        initialValue: providerCourses.requestBodyCourse?.description,
                        onChanged: (String value) {
                          var data = providerCourses.requestBodyCourse;
                          data?.description = value;
                          providerCourses.requestBodyCourse = data;
                        },
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          height: kToolbarHeight + 24.h,
          padding: EdgeInsets.symmetric(
            horizontal: 24.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              providerCourses.submitLoading
                  ? const CircularProgressIndicator()
                  : BasicButton(
                      buttonText: "Update Course",
                      onPressed: () {
                        providerCourses.updateCourse();
                      },
                    ),
            ],
          ),
        ),
      );
    });
  }
}
