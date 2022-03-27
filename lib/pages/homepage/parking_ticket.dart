import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parking_management/api/api.dart';
import 'package:parking_management/controllers/authController.dart';

class ParkingTicket extends StatelessWidget {
  ParkingTicket({Key key}) : super(key: key);
  RxString name = RxString("");
  DateTime currentTime = DateTime.now();
  final AuthController controller = Get.find<AuthController>();
  DateTime minimum;
  DateTime maximum;
  RxBool enableButton = RxBool(false);

  DateTime get minimumAllowedStartTime {
    minimum =
        controller.estimatedStartTime.value.subtract(Duration(minutes: 5));
    return minimum;
  }

  DateTime get maximumAllowedStartTime {
    maximum = controller.estimatedStartTime.value.add(Duration(minutes: 5));
    return maximum;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Obx(() {
            if (controller.statusOfLastBooking.value == "pending") {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            "You can park your vehicle anywhere in ${controller.streetName.value} between",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "OpenSans",
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            "${DateFormat("hh:mmaaa").format(minimumAllowedStartTime)} and ${DateFormat("hh:mmaaa").format(maximumAllowedStartTime)}",
                            style: TextStyle(
                                fontSize: 24,
                                fontFamily: "OpenSans",
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: FittedBox(
                          child: Text(
                            "After parking your vehicle,click on the start button to start your timer",
                            style: TextStyle(
                                fontSize: 20,
                                fontFamily: "OpenSans",
                                letterSpacing: 1),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                        child: SizedBox(
                      height: 10,
                    )),
                    Obx(
                      () {
                        if (DateTime.now().compareTo(controller
                                .estimatedStartTime.value
                                .subtract(Duration(minutes: 5))) >=
                            0) {
                          controller.cancelReverseTimer.value = true;
                          buildButtonAfterDelay();
                          return Container();
                        }
                        return Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SizedBox(
                              child: controller.timeElapsedSinceBooking.value ==
                                      null
                                  ? CircularProgressIndicator()
                                  : Text(
                                      "${controller.timeElapsedSinceBooking.value}"
                                          .split('.')[0]
                                          .padLeft(8, '0'),
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontFamily: "OpenSans",
                                          letterSpacing: 1),
                                    ),
                            ),
                          ),
                        );
                      },
                    ),
                    Flexible(
                      child: ElevatedButton(
                        child: Container(
                            width: 200,
                            height: 50,
                            child: Center(
                                child: Text(
                              "Start",
                              style: TextStyle(letterSpacing: 2),
                            ))),
                        onPressed: enableButton.value == true
                            ? (() async {
                                currentTime = DateTime.now();
                                if(currentTime.compareTo(maximumAllowedStartTime)>=0)
                                  {
                                    controller.onInit();
                                      Get.dialog( AlertDialog(
                                        title: Text("Your booking is invalid"),
                                        content: Text(
                                            "Itseems ,you did not park your vehicle by ${DateFormat("hh:mmaaa").format(maximumAllowedStartTime)}"),
                                        actions: [
                                          TextButton(
                                              onPressed: () => Get.back(),
                                              child: Text(
                                                "Ok",
                                                style: TextStyle(color: Colors.deepPurple),
                                              ))
                                        ],
                                      ));

                                  }
                                else
                                if (currentTime.compareTo(
                                            minimumAllowedStartTime) >=
                                        0 &&
                                    currentTime.compareTo(
                                            maximumAllowedStartTime) <=
                                        0) {
                                  var response = await ApiRequests.book(
                                      parkingStatus: "started");
                                  if (response.statusCode == 200) {
                                    controller.statusOfLastBooking.value =
                                        "started";
                                    controller.startTime.value = DateTime.parse(
                                        json.decode(
                                            response.body)['start_time']);
                                    print(
                                        "97-parking_ticket.dart ${json.decode(response.body)['start_time']}");
                                    controller.timer();
                                  }


                                }

                                // print("${response.body}");
                              })
                            : null,
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else if (controller.statusOfLastBooking.value == "started") {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Obx(
                      () => Flexible(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child:
                                controller.timeElapsedSinceParking.value == null
                                    ? CircularProgressIndicator()
                                    : Text(
                                        "${controller.timeElapsedSinceParking.value}"
                                            .split('.')[0]
                                            .padLeft(8, '0'),
                                        style: TextStyle(
                                            fontSize: 20,
                                            fontFamily: "OpenSans",
                                            letterSpacing: 1),
                                      ),
                          ),
                        ),
                      ),
                    ),
                    Flexible(
                        child: SizedBox(
                      height: 10,
                    )),
                    Flexible(
                      child: ElevatedButton(
                        child: Container(
                            width: 200,
                            height: 50,
                            child: Center(
                                child: Text(
                              "Stop",
                              style: TextStyle(letterSpacing: 2),
                            ))),
                        onPressed: () async {
                          controller.cancelTimer.value = true;
                          var response = await ApiRequests.book(
                              parkingStatus: "completed");
                          try {
                            if (response.statusCode == 200) {
                              controller.statusOfLastBooking.value =
                                  "completed";

                              controller.onInit();
                            }
                          } catch (e) {
                            print("148-parking_ticket.dart ${e.message}");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Container();
            }
          }),
        ),
      ],
    );
  }

  void buildButtonAfterDelay() {
    Future.delayed(Duration(seconds: 1), () {
      enableButton.value = true;
    });
  }
}
