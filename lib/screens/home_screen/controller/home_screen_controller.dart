import 'package:get/get.dart';
import 'package:the_leaderboard/models/hall_of_fame_single_payment_model.dart';
import 'package:the_leaderboard/models/hall_of_frame_consisntantly_top_model.dart';
import 'package:the_leaderboard/models/hall_of_frame_most_engaged_model.dart';
import 'package:the_leaderboard/screens/bottom_nav/controller/bottom_nav_controller.dart';
import 'package:the_leaderboard/services/api/api_get_service.dart';

class HomeScreenController extends RxController {
  final RxString name = ''.obs;
  final RxString totalRaised = ''.obs;
  final RxString totalSpent = ''.obs;
  final RxInt rank = 0.obs;

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

  void fetchData() async {
    try {
      ismydataLoading.value = true;
      final data = await ApiGetService.fetchHomeData();

      if (data != null) {
        final userData = data.user;
        name.value = userData.name;
        totalRaised.value = userData.totalRaised.toString();
        totalSpent.value = userData.totalInvest.toString();
        rank.value = userData.rank;
      }
      ismydataLoading.value = false;

      ishallofframeSinglePaymentLoading.value = true;
      final recordSingledata =
          await ApiGetService.fetchHallofFrameSinglePayment();
      if (recordSingledata != null) {
        recoredSinglePayment.value = recordSingledata;
      }
      ishallofframeSinglePaymentLoading.value = false;

      ishallofframeConsisntantTopLoading.value = true;
      final consistantlyTopdata =
          await ApiGetService.fetchHallofFrameConsistentlyTop();
      if (consistantlyTopdata != null) {
        consistantlyTop.value = consistantlyTopdata;
      }
      ishallofframeConsisntantTopLoading.value = false;

      ishallofframeMostEngagedLoading.value = true;
      final mostEngageddata =
          await ApiGetService.fetchHallofFrameEngagedProfile();
      if (mostEngageddata != null) {
        mostEngaged.value = mostEngageddata;
      }
      ishallofframeMostEngagedLoading.value = false;
    } catch (e) {
      Get.snackbar("Error", "Something went wrong");
    }
  }

  void viewMyProfile() {
    Get.put(BottomNavController()).changeIndex(3);
  }
}
