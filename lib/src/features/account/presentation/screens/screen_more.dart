import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_code/src/core/data/enums/e_bottomnav.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/bottom_navigationbar/bottom_navigationbar.dart';
import 'package:flutter_boilerplate_code/src/core/presentation/widgets/image/circular_image.dart';
import 'package:flutter_boilerplate_code/src/features/account/presentation/providers/provider_account.dart';
import 'package:flutter_boilerplate_code/src/resources/app_colors.dart';
import 'package:flutter_boilerplate_code/src/resources/app_images.dart';
import 'package:flutter_boilerplate_code/src/routes/routes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ScreenMore extends StatelessWidget{
  const ScreenMore({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Consumer<ProviderAccount>(builder: (_, accountProvider, child) {
      return Scaffold(
        body: SafeArea(
          child: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                    vertical: 16.h,
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 16.h,
                      ),
                      CircularImage(
                        size: 56.h,
                        imageUrl: accountProvider.currentUser?.profilePicture ?? "",
                        errorWidget: Image.asset(
                          AppImages.placeholderProfile,
                        ),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        accountProvider.currentUser?.fullName ?? "",
                        style: GoogleFonts.rubik().copyWith(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 24.w,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        tileColor: AppColors.topSheet,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        splashColor: AppColors.popupBackground,
                        title: Text(
                          "View Full Profile",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),
                        leading: Image.asset(
                          AppImages.iconAccount,
                        ),
                        trailing: Image.asset(
                          AppImages.iconRightArrow,
                        ),
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.profileScreen,
                          );
                        },
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ListTile(
                        tileColor: AppColors.topSheet,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        splashColor: AppColors.popupBackground,
                        title: Text(
                          "Wallet",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),
                        leading: Image.asset(
                          AppImages.iconWallet,
                        ),
                        trailing: Image.asset(
                          AppImages.iconRightArrow,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ListTile(
                        tileColor: AppColors.topSheet,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        splashColor: AppColors.popupBackground,
                        title: Text(
                          "Bank Accounts",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),
                        leading: Image.asset(
                          AppImages.iconCreditCard,
                        ),
                        trailing: Image.asset(
                          AppImages.iconRightArrow,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ListTile(
                        tileColor: AppColors.topSheet,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        splashColor: AppColors.popupBackground,
                        title: Text(
                          "Invitations",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),
                        leading: Image.asset(
                          AppImages.iconInvitations,
                        ),
                        trailing: Image.asset(
                          AppImages.iconRightArrow,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ListTile(
                        tileColor: AppColors.topSheet,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        splashColor: AppColors.popupBackground,
                        title: Text(
                          "Withdraw History",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),
                        leading: Image.asset(
                          AppImages.iconWithdrawRequest,
                        ),
                        trailing: Image.asset(
                          AppImages.iconRightArrow,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ListTile(
                        tileColor: AppColors.topSheet,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        splashColor: AppColors.popupBackground,
                        title: Text(
                          "Change Password",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),
                        leading: Image.asset(
                          AppImages.iconChangePassword,
                        ),
                        trailing: Image.asset(
                          AppImages.iconRightArrow,
                        ),
                      ),
                      SizedBox(
                        height: 16.h,
                      ),
                      ListTile(
                        tileColor: AppColors.topSheet,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        splashColor: AppColors.popupBackground,
                        title: Text(
                          "Logout",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppColors.grey400,
                          ),
                        ),
                        leading: Image.asset(
                          AppImages.iconLogout,
                        ),
                        trailing: Image.asset(
                          AppImages.iconRightArrow,
                        ),
                        onTap: () {
                          accountProvider.logout();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 24.h,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(
          activeTab: EBottomNav.more,
        ),
      );
    });
  }
}