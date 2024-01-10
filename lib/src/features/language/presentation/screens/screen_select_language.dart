import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/appbar/sliver_custom_appbar.dart';
import 'package:flutter_boilerplate_code/src/features/courses/data/entities/course_category.dart';
import 'package:flutter_boilerplate_code/src/features/courses/presentation/providers/provider_courses.dart';
import 'package:flutter_boilerplate_code/src/features/language/data/language_model.dart';
import 'package:flutter_boilerplate_code/src/features/language/presentation/providers/provider_language.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class ScreenSelectLanguage extends StatelessWidget {
  const ScreenSelectLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<ProviderLanguage>(
          builder: (_,providerLanguage, child){
            List<LanguageModel> languages = providerLanguage.languageList();
            return CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                SliverCustomAppBar(
                  title: "Select Language",
                  pinned: true,
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  sliver: SliverList.separated(
                    itemCount: languages.length,
                    itemBuilder: (_, index) {
                      return ListTile(
                        tileColor: AppColors.topSheet,
                        title: Text(languages[index].name),
                        onTap: () {
                          providerLanguage.updateLocaleByCode(languages[index].code);
                          Navigator.pop(context);
                        },
                      );
                    },
                    separatorBuilder: (_, index) {
                      return SizedBox(
                        height: 16.h,
                      );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
