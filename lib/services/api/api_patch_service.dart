import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';
import 'package:the_leaderboard/constants/app_colors.dart';
import 'package:the_leaderboard/constants/app_urls.dart';
import 'package:the_leaderboard/services/storage/storage_services.dart';
import 'package:the_leaderboard/utils/app_logs.dart';

class ApiPatchService {
  static Future<void> updateProfile(
    String? name,
    String? contact,
    String? country,
    String? city,
    String? gender,
    String? age,
    String? facebook,
    String? instagram,
    String? twitter,
    String? linkedin
  ) async {
    final url = "${AppUrls.updateUser}/${LocalStorage.userId}";

    try {
      final Map<String, dynamic> updateData = {};

      if (name != null) updateData['name'] = name;
      if (contact != null) updateData['contact'] = contact;
      if (country != null) updateData['country'] = country;
      if (city != null) updateData['city'] = city;
      if (gender != null) updateData['gender'] = gender;
      if (age != null) updateData['age'] = age;
      if (facebook != null) updateData['facebook'] = facebook;
      if (instagram != null) updateData['instagram'] = instagram;
      if (twitter != null) updateData['twitter'] = twitter;
      if (linkedin != null) updateData['linkedin'] = linkedin;

      if (updateData.isEmpty) {
        Get.snackbar("Info", "No data to update");
        return;
      }
      appLog(jsonEncode(updateData));
      final response = await http.patch(
        Uri.parse(url),
        headers: {
           'Content-Type': 'application/json',
          'authorization': LocalStorage.token,
        },
        body: jsonEncode(updateData),
      );
      final jsonbody = jsonDecode(response.body);
      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar("Success", jsonbody["message"],
            colorText: AppColors.white);
      } else {
        Get.snackbar("Error", jsonbody["message"], colorText: AppColors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e",
          colorText: AppColors.white);
    }
  }

  static Future<void> updateProfileImage(File? image) async {
    try {
      final dio = Dio();

      String fileName = basename(image!.path);

      FormData formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          image.path,
          filename: fileName,
          contentType: MediaType('image', 'png'),
        ),
      });

      final response = await dio.patch(
        AppUrls.updateImage,
        data: formData,
        options: Options(
          headers: {
            'authorization': LocalStorage.token,
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      final jsonbody = response.data;
      if (response.statusCode == 200 || response.statusCode == 204) {
        Get.snackbar("Success", jsonbody["message"],
            colorText: AppColors.white);
      } else {
        Get.snackbar("Error", jsonbody["message"], colorText: AppColors.white);
      }
    } catch (e) {
      Get.snackbar("Error", "Upload failed: $e");
    }
  }
}
