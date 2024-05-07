// ignore_for_file: annotate_overrides

import 'dart:async';

import 'package:get/get.dart';

class SplashController extends GetxController {
  void onInit() {
    super.onInit();
    Timer(const Duration(seconds: 3), () => Get.toNamed('/login'));
  }
}
