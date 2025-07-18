import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:the_leaderboard/constants/app_colors.dart';
import 'package:the_leaderboard/constants/app_urls.dart';
import 'package:the_leaderboard/routes/app_routes.dart';
import 'package:the_leaderboard/services/api/api_post_service.dart';
import 'package:the_leaderboard/utils/app_logs.dart';

class ChangePasswordController extends GetxController {
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmNewPasswordController = TextEditingController();

  void saveChange() async {
    if (oldPasswordController.text.isEmpty ||
        newPasswordController.text.isEmpty ||
        confirmNewPasswordController.text.isEmpty) {
      Get.snackbar("Error", "Please fill the form correctly",
          colorText: AppColors.white, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (newPasswordController.text != confirmNewPasswordController.text) {
      Get.snackbar(
        "Password Mismatch",
        "The passwords you entered do not match. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: AppColors.white,
      );
      return;
    }
    if (oldPasswordController.text == newPasswordController.text) {
      Get.snackbar(
        "Error",
        "The new password cannot be the same as the old password.",
        snackPosition: SnackPosition.BOTTOM,
        colorText: AppColors.white,
      );

      return;
    }
    appLog(
        "Password is changing....old: ${oldPasswordController.text} and new: ${newPasswordController.text}");
    try {
      final response =
          await ApiPostService.apiPostService(AppUrls.changePassword, {
        "oldPassword": oldPasswordController.text,
        "newPassword": newPasswordController.text
      });
      if (response != null) {
        final data = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.snackbar("Success", data["message"], colorText: AppColors.white);
          Get.toNamed(AppRoutes.loginScreen);
        } else {
          Get.snackbar("Error", data["message"], colorText: AppColors.white);
        }
      }
      appLog("Succeed");
    } catch (e) {
      errorLog("Failed", e);
    }

    oldPasswordController.clear();
    newPasswordController.clear();
    confirmNewPasswordController.clear();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    oldPasswordController.dispose();
    newPasswordController.dispose();
    confirmNewPasswordController.dispose();
  }
}
