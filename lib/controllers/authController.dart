import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parking_management/api/api.dart';

import '../pages/homepage/booking_card.dart';

class AuthController extends GetxController {
  RxBool isLoading = RxBool(true);
  RxBool isLoggingIn = RxBool(false);
  RxBool isSigningUp = RxBool(false);
  RxString validToken = RxString("false");
  RxList streets=RxList([]);
  RxString email = RxString("");
  RxString name = RxString("");
  RxString statusOfLastBooking = RxString("");
  RxString streetName = RxString("");
  Rx<DateTime> estimatedStartTime = Rx<DateTime>(null);
  Rx<DateTime> startTime = Rx<DateTime>(null);
  Rx<Duration> timeElapsedSinceParking = Rx<Duration>(null);
  Rx<Duration> timeElapsedSinceBooking = Rx<Duration>(null);
  RxString surveyGiven=RxString("");
  RxList parkingHistory = RxList([]);
  RxBool cancelTimer = RxBool(false);
  RxBool cancelReverseTimer=RxBool(false);
  bool bottomSheet;
  TextEditingController signupNameController = TextEditingController(text: "");
  TextEditingController phoneController = TextEditingController(text: "");
  TextEditingController signinEmailController = TextEditingController(text: "");
  TextEditingController signinPasswordController = TextEditingController(text: "");
  TextEditingController signupEmailController = TextEditingController(text: "");
  TextEditingController signupPasswordController = TextEditingController(text: "");
  TextEditingController reviewController = TextEditingController(text: " ");
  TextEditingController rePasswordController =
  TextEditingController(text: "");
  RxBool invalidPhoneNumber = RxBool(true);
  RxBool invalidEmail=RxBool(true);
  RxBool invalidPassword=RxBool(true);
  RxBool invalidRePassword=RxBool(true);

  @override
  void onInit() {

    ApiRequests.validate().then((value) {
      validToken.value = value['validToken'];
      // print("13-authcontroller.dart");
      if (validToken.value == "true") {
        // print("35,authcontroller.dart");
        statusOfLastBooking.value = value['userData']['status_of_last_booking']==null?"":value['userData']['status_of_last_booking'];
        email.value = value['userData']['email'];
        name.value = value['userData']['name'];
        parkingHistory.value = value['userData']['parking_history'];
        // print("33-AuthController.dart ${parkingHistory.value}");
        estimatedStartTime
            .value = value['estimated_start_time_of_previous_booking'] ==
                    null ||
                value['estimated_start_time_of_previous_booking'] == "None"
            ? null
            : DateTime.parse(value['estimated_start_time_of_previous_booking']);
        surveyGiven.value=value['survey_given'];
        // print("35-authController.dart ${value['start_time']}");
        startTime.value =
            value['start_time'] == "None" || value['start_time'] == null
                ? null
                : DateTime.parse(value['start_time']);
        streetName.value =
            value['street_name'] == null ? "" : value['street_name'];
        // print("26-authcontroller.dart ${estimatedStartTime.value}");
        if (statusOfLastBooking.value == "started" &&
            startTime.value != null) {
          timer();
        }
        if(statusOfLastBooking.value=="pending")
          {
            reverseTimer();
          }
        getData().whenComplete(() {
          isLoading.value = false;
        });
      } else {
        isLoading.value = false;
      }
    });
    super.onInit();
  }

  Future getData({bool loggedIn = true}) async {
    if (loggedIn == false) {
      isLoading.value = true;
      // print("33,authcontroller.dart");
      streets.value=await ApiRequests.getStreets();

      isLoading.value=false;
    } else {
      // print("44,authcontroller.dart");
      await ApiRequests.getStreets().then((value) {
        streets = RxList(value);
        print("46,authcontroller.dart $value");
      });
    }
  }
Future<void> reverseTimer()
{
  Timer.periodic(Duration(seconds: 1), (timer) {
    // print("78-authcontroller.dart");
    timeElapsedSinceBooking.value =
    (estimatedStartTime.value.subtract(Duration(minutes: 5))).difference(DateTime.now());
    if (cancelReverseTimer.value == true) {
      timer.cancel();
      // print("83-authController ${cancelTimer.value}");
      cancelReverseTimer.value = false;
    }
  });
}
  Future<void> timer() {
    Timer.periodic(Duration(seconds: 1), (timer) {
      print("78-authcontroller.dart ${startTime.value}");
      print("${DateTime.now()}");
      timeElapsedSinceParking.value =
          DateTime.now().difference(startTime.value);
      if (cancelTimer.value == true) {
        timer.cancel();
        // print("83-authController ${cancelTimer.value}");
        cancelTimer.value = false;
      }
    });
  }

}
