import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_bottomnav.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/bottom_navigationbar/bottom_navigationbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/buttons/basic_button.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/image/circular_image.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({super.key});

  @override
  State<ScreenHome> createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ProviderAccount>(
        context,
        listen: false,
      ).fetchMyProfile();
    });
    super.initState();
  }

  String greet() {
    var hour = DateTime.now().hour;

    if (hour < 12) {
      return 'Good morning,';
    } else if (hour < 14) {
      return 'Good noon,';
    } else if (hour < 18) {
      return 'Good afternoon,';
    } else {
      return 'Good evening,';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Consumer<ProviderAccount>(
      builder: (_, providerAccount, child) {
        return Scaffold(
          body: SafeArea(
              child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24.w,
                          vertical: 32.h,
                        ),
                        child: providerAccount.loading
                            ? const Center(
                          child: CircularProgressIndicator(),
                        ): Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircularImage(
                                  size: 56.h,
                                  imageUrl: providerAccount.currentUser?.profilePicture ?? "",
                                  errorWidget: Image.asset(
                                    AppImages.placeholderProfile,
                                  ),
                                ),
                                SizedBox(
                                  width: 12.w,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      greet(),
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: AppColors.grey600,
                                      ),
                                    ),
                                    Text(
                                      providerAccount.currentUser?.fullName ?? "",
                                      style: GoogleFonts.poppins().copyWith(
                                        fontSize: 24.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                            const Icon(
                              Icons.notifications_none_outlined,
                              color: AppColors.grey600,
                            ),
                          ],
                        ),
                      ),
              ),
            ],
          )),
          bottomNavigationBar: const CustomBottomNavigationBar(
            activeTab: EBottomNav.home,
          ),
        );
      },
    );
  }
}
