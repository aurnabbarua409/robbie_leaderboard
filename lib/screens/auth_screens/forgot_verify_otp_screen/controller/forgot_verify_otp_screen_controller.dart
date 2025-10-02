import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:the_leaderboard/constants/app_colors.dart';
import 'package:the_leaderboard/constants/app_urls.dart';
import 'package:the_leaderboard/models/verify_otp_model.dart';
import 'package:the_leaderboard/routes/app_routes.dart';
import 'package:the_leaderboard/services/api/api_post_service.dart';
import 'package:the_leaderboard/services/storage/storage_services.dart';
import 'package:the_leaderboard/utils/app_logs.dart';

class ForgotVerifyOtpController extends GetxController {
  late TextEditingController otpTextEditingController1;
  late TextEditingController otpTextEditingController2;
  late TextEditingController otpTextEditingController3;
  late TextEditingController otpTextEditingController4;

  // Timer variables
  final RxInt timerSeconds = 120.obs;
  final RxBool isTimerRunning = true.obs;
  Timer? _timer;

  @override
  void onInit() {
    super.onInit();
    otpTextEditingController1 = TextEditingController();
    otpTextEditingController2 = TextEditingController();
    otpTextEditingController3 = TextEditingController();
    otpTextEditingController4 = TextEditingController();

    // Start the timer when controller initializes
    startTimer();
  }

  // Format time as minutes:seconds
  String get formattedTime {
    final minutes = (timerSeconds.value ~/ 60).toString().padLeft(2, '0');
    final seconds = (timerSeconds.value % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  // Start countdown timer
  void startTimer() {
    isTimerRunning.value = true;
    timerSeconds.value = 120; // Reset to initial time

    _timer?.cancel(); // Cancel any existing timer
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timerSeconds.value > 0) {
        timerSeconds.value--;
      } else {
        timer.cancel();
        isTimerRunning.value = false;
      }
    });
  }

  // Function to resend the OTP code
  void resendOtp() async {
    // Here you would add your API call to request a new OTP code
    // For now we'll just show a snackbar and restart the timer
    appLog("otp request is sending");
    final url = "${AppUrls.resentOtp}/${LocalStorage.myEmail}";
    try {
      final response = await ApiPostService.apiPostService(url, null);
      if (response != null) {
        final data = jsonDecode(response.body);
        if (response.statusCode == 200 || response.statusCode == 201) {
          Get.snackbar("Success", data["message"], colorText: AppColors.white);
        } else {
          Get.snackbar("Error", data["message"], colorText: AppColors.white);
        }
      }
      appLog("Succeed");
    } catch (e) {
      errorLog("Failed", e);
    }

    // Clear all fields
    otpTextEditingController1.clear();
    otpTextEditingController2.clear();
    otpTextEditingController3.clear();
    otpTextEditingController4.clear();

    // Restart the timer
    startTimer();
  }

  void verifyOtp() async {
    final otp = otpTextEditingController1.text +
        otpTextEditingController2.text +
        otpTextEditingController3.text +
        otpTextEditingController4.text;
    appLog("Otp is varifying");
    if (otp.length == 4 && RegExp(r'^\d{4}$').hasMatch(otp)) {
      // TODO: Implement actual OTP verification logic (e.g., API call)
      final otpCode = VerifyOtpModel(otp: otp, email: LocalStorage.myEmail);
      try {
        final response = await ApiPostService.apiPostService(
            AppUrls.verifyOtp, otpCode.toJson());
        if (response != null) {
          final data = jsonDecode(response.body);
          if (response.statusCode == 200 || response.statusCode == 201) {
            LocalStorage.token = data["data"];
            Get.snackbar("Success", data["message"]);
            Get.toNamed(AppRoutes.createNewPasswordScreen);
          } else {
            Get.snackbar("Error", data["message"]);
          }
        }
        appLog("Succeed");
      } catch (e) {
        errorLog("Failed", e);
      }

      // Navigate to next screen or perform action
    } else {
      Get.snackbar(
        'Error',
        'Please enter a valid 4-digit OTP',
        
      );
    }
    return;
  }

  @override
  void onClose() {
    otpTextEditingController1.dispose();
    otpTextEditingController2.dispose();
    otpTextEditingController3.dispose();
    otpTextEditingController4.dispose();
    _timer?.cancel(); // Ensure timer is cancelled when controller is closed
    super.onClose();
  }
}
