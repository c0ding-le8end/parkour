import 'package:get/get.dart';

import 'authController.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
  }
}