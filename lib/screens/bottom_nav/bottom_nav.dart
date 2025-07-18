import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:the_leaderboard/screens/bottom_nav/widgets/custom_gbutton_widget.dart';
import 'package:the_leaderboard/screens/notification_screen/controller/notification_controller.dart';

import '../../../constants/app_colors.dart';
import '../../constants/app_icon_path.dart';
import '../../constants/app_strings.dart';
import 'controller/bottom_nav_controller.dart';

class BottomNav extends StatelessWidget {
  const BottomNav({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: BottomNavController(),
        builder: (controller) {
          Get.put(NotificationController());
          return Scaffold(
            backgroundColor: AppColors.blueDark,
            body: IndexedStack(
              index: controller.selectedIndex.value,
              children: controller.widgetOptions,
            ),
            bottomNavigationBar: Container(
              decoration: const BoxDecoration(
                color: AppColors.blueDark,
              ),
              child: SafeArea(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                  child: GNav(
                    // mainAxisAlignment: MainAxisAlignment.spaceAround,
                    // rippleColor: Colors.grey[300]!,
                    // hoverColor: Colors.grey[100]!,
                    gap: 0,
                    iconSize: 24,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    duration: const Duration(milliseconds: 400),
                    tabBackgroundColor: AppColors.blueLighter,
                    backgroundColor: AppColors.blueDark,
                    tabBorderRadius: 8,
                    tabs: [
                      CustomGButton.build(
                        iconPath: AppIconPath.homeIcon,
                        label: AppStrings.home,
                        index: 0,
                        selectedIndex: controller.selectedIndex.value,
                        selectedColor: AppColors.blueDark,
                        unselectedColor: AppColors.blueLighter,
                      ),
                      CustomGButton.build(
                        iconPath: AppIconPath.leaderboardIcon,
                        label: AppStrings.leaderboards,
                        index: 1,
                        selectedIndex: controller.selectedIndex.value,
                        selectedColor: AppColors.blueDark,
                        unselectedColor: AppColors.blueLighter,
                      ),
                      CustomGButton.build(
                        iconPath: AppIconPath.rewardsIcon,
                        label: AppStrings.rewards,
                        index: 2,
                        selectedIndex: controller.selectedIndex.value,
                        selectedColor: AppColors.blueDark,
                        unselectedColor: AppColors.blueLighter,
                      ),
                      CustomGButton.build(
                        iconPath: AppIconPath.profileIcon,
                        label: AppStrings.profile,
                        index: 3,
                        selectedIndex: controller.selectedIndex.value,
                        selectedColor: AppColors.blueDark,
                        unselectedColor: AppColors.blueLighter,
                      ),
                    ],
                    selectedIndex: controller.selectedIndex.value,
                    onTabChange: (index) => controller.changeIndex(index),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
