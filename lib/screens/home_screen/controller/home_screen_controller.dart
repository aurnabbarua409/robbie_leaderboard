import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:the_leaderboard/constants/app_colors.dart';
import 'package:the_leaderboard/constants/app_urls.dart';
import 'package:the_leaderboard/models/hall_of_fame_single_payment_model.dart';
import 'package:the_leaderboard/models/hall_of_frame_consisntantly_top_model.dart';
import 'package:the_leaderboard/models/hall_of_frame_most_engaged_model.dart';
import 'package:the_leaderboard/models/profile_model.dart';
import 'package:the_leaderboard/models/recent_activity_receive_model.dart';
import 'package:the_leaderboard/models/ticket_won_socket_model.dart';
import 'package:the_leaderboard/routes/app_routes.dart';
import 'package:the_leaderboard/screens/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:the_leaderboard/screens/notification_screen/controller/notification_controller.dart';
import 'package:the_leaderboard/services/api/api_get_service.dart';
import 'package:the_leaderboard/services/socket/socket_service.dart';
import 'package:the_leaderboard/services/storage/storage_keys.dart';
import 'package:the_leaderboard/services/storage/storage_services.dart';
import 'package:the_leaderboard/utils/app_logs.dart';

class HomeScreenController extends GetxController {
  final RxString name = ''.obs;
  final RxString totalRaised = ''.obs;
  final RxString totalSpent = ''.obs;
  final RxInt rank = 0.obs;
  final RxString image = "".obs;
  final RxString userCode = "".obs;
  final Rxn<HallOfFameSinglePaymentModel> recoredSinglePayment =
      Rxn<HallOfFameSinglePaymentModel>();
  final Rxn<HallOfFrameConsisntantlyTopModel> consistantlyTop =
      Rxn<HallOfFrameConsisntantlyTopModel>();
  final Rxn<HallOfFrameMostEngagedModel> mostEngaged =
      Rxn<HallOfFrameMostEngagedModel>();

  final RxBool ismydataLoading = true.obs;
  final RxBool ishallofframeSinglePaymentLoading = true.obs;
  final RxBool ishallofframeConsisntantTopLoading = true.obs;
  final RxBool ishallofframeMostEngagedLoading = true.obs;

  final RxList<List<dynamic>> recentActivity = <List<dynamic>>[].obs;
  final notificationController = Get.find<NotificationController>();
  void sendData() {
    SocketService.instance.sendInvest("Aurnab 420", 200);
  }

  void receiveData() {
    SocketService.instance.onNewInvestMessageReceived((p0) {
      final time = DateFormat('mm').format(DateTime.parse(p0.createdAt));
      recentActivity.insert(0, [p0.title, p0.subTitle, time]);
    });
    SocketService.instance.onCreatingTicketResponse(
      (p0) {
        final time = DateFormat('mm').format(DateTime.parse(p0.createdAt));
        recentActivity.insert(0, [p0.title, p0.text, time]);
      },
    );
  }

  Future fetchData() async {
    fetchHomeData();
    fetchHallofFrameSinglePayment();
    fetchHallofFrameConsistantlyTop();
    fetchHallofFrameMostEngaged();
  }

  void viewMyProfile() {
    final profileTab = Get.find<BottomNavController>();
    profileTab.changeIndex(3);
  }

  void fetchHomeData() async {
    appLog("fetching home data");
    try {
      ismydataLoading.value = true;
      final responseHomeData =
          await ApiGetService.apiGetService(AppUrls.profile);
      ismydataLoading.value = false;
      if (responseHomeData != null) {
        final data = jsonDecode(responseHomeData.body);
        if (responseHomeData.statusCode == 200) {
          final userData = ProfileResponseModel.fromJson(data["data"]).user;
          name.value = userData?.name ?? "";
          totalRaised.value = userData?.totalRaised.toString() ?? "";
          totalSpent.value = userData?.totalInvest.toString() ?? "";
          rank.value = userData?.rank ?? 0;
          image.value = userData?.profileImg ?? "";
          userCode.value = userData?.userCode ?? "";
          LocalStorage.userId = userData!.id;
          LocalStorage.setString(LocalStorageKeys.userId, userData.id);
          return;
        } else {
          Get.snackbar("Error", data["message"], colorText: AppColors.white);
        }
      } else {
        Get.toNamed(AppRoutes.serverOff);
      }
    } catch (e) {
      errorLog("fetchHomeData", e);
    }
  }

  void fetchHallofFrameSinglePayment() async {
    appLog("fetching single payment data");
    ishallofframeSinglePaymentLoading.value = true;
    try {
      final response =
          await ApiGetService.apiGetService(AppUrls.highestInvestor);
      ishallofframeSinglePaymentLoading.value = false;
      if (response != null) {
        final data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          recoredSinglePayment.value =
              HallOfFameSinglePaymentModel.fromJson(data["data"]);
          return;
        } else {
          Get.snackbar("Error", data["message"], colorText: AppColors.white);
        }
      }
      appLog("Succeed");
    } catch (e) {
      errorLog("Failed", e);
    }
    recoredSinglePayment.value = HallOfFameSinglePaymentModel(
        id: "0",
        name: "Unknown",
        country: "Unknown",
        gender: "Unknown",
        views: 0,
        totalInvested: 0);
  }

  void fetchHallofFrameConsistantlyTop() async {
    appLog("fetching consistantly top ");
    try {
      ishallofframeConsisntantTopLoading.value = true;
      final response =
          await ApiGetService.apiGetService(AppUrls.consecutiveToper);
      ishallofframeConsisntantTopLoading.value = false;
      if (response != null) {
        final data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          consistantlyTop.value =
              HallOfFrameConsisntantlyTopModel.fromJson(data["data"]);
          return;
        } else {
          Get.snackbar("Error", data["message"], colorText: AppColors.white);
        }
      }
      appLog("Succeed");
    } catch (e) {
      errorLog("Failed", e);
    }
    consistantlyTop.value = HallOfFrameConsisntantlyTopModel(
        id: "0", name: "Unknown", timesRankedTop: 0);
  }

  void fetchHallofFrameMostEngaged() async {
    appLog("fetching most engaged");
    try {
      ishallofframeMostEngagedLoading.value = true;
      final response = await ApiGetService.apiGetService(AppUrls.mostViewed);
      ishallofframeMostEngagedLoading.value = false;
      if (response != null) {
        final data = jsonDecode(response.body);
        if (response.statusCode == 200) {
          mostEngaged.value =
              HallOfFrameMostEngagedModel.fromJson(data["data"]);
          return;
        } else {
          Get.snackbar("Error", data["message"], colorText: AppColors.white);
        }
      }
      appLog("Succeed");
    } catch (e) {
      errorLog("Failed", e);
    }
    mostEngaged.value = HallOfFrameMostEngagedModel(
        id: "0",
        name: "Unnknown",
        country: "Unknown",
        gender: "Unknown",
        profileImg: '',
        views: 0);
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchData();
    SocketService.instance.connect();
    receiveData();
  }
}
