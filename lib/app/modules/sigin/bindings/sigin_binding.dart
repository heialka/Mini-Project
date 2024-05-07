import 'package:get/get.dart';

import '../controllers/sigin_controller.dart';

class SiginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SiginController>(
      () => SiginController(),
    );
  }
}
