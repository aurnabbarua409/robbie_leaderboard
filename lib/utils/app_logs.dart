import 'dart:developer';
import 'package:flutter/foundation.dart';

void appLog(dynamic value) {
  try {
    if (kDebugMode) {
      log("""
>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
$value
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
""");
    }
  } catch (e) {
    debugPrint("error form $e");
  }
}

void errorLog(String title, dynamic e, {String subtitle = "Error Form"}) {
  try {
    if (kDebugMode) {
      log("""
👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺
$subtitle

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 

$title


$e


👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺👺
""");
    }
  } catch (e) {
    debugPrint("error form : $e");
  }
}
