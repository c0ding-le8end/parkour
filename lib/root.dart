import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_management/controllers/authController.dart';

import 'controllers/bindings.dart';
import 'pages/homepage/homepage.dart';
import 'pages/welcome/welcome.dart';

class Root extends StatelessWidget {
  Root({Key key}) : super(key: key);
  final controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // print(controller.validToken.value);
      if (controller.isLoading.value == false) {
        if (controller.validToken.value == "true") {
          return HomePage();
        } else if (controller.validToken.value == "error") {
          // print("56-main.dart");
          return AlertDialog(
            content: Text("session timed out"),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.offAll(() => Root(),
                        routeName: '/', binding: AuthBindings());
                  },
                  child: Text("Ok"))
            ],
          );
        } else {
          // print("53-main.dart");
          return LoginPage();
        }
      } else {
        return Center(child: Container());
      }
    });
  }
}