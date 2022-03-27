import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:http/browser_client.dart';
import 'package:intl/intl.dart';
import 'package:parking_management/util/animations.dart';
import 'package:parking_management/api/api.dart';
import 'package:parking_management/controllers/authController.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

class BookingCard extends StatelessWidget {
  BookingCard({Key key, this.bottomSheet}) : super(key: key) {
    hoursList = List.generate(
        12,
        (index) => index < 9
            ? (formatter.format(index + 1)).toString()
            : (index + 1).toString());
    minutesList = List.generate(
        60,
        (index) =>
            index < 10 ? formatter.format(index).toString() : index.toString());
  }

  static RxBool streetSelected = RxBool(false);
  static RxString title = RxString("Select a street  ");
  static RxString availableParkingSpaces = RxString("");
  static String streetId = "";
  NumberFormat formatter = NumberFormat("00");
  static List hoursList = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12];
  static List minutesList;
  RxString meridian = RxString(null);
  RxString hour = RxString(null);
  RxString minute = RxString(null);
  double width;
  RxList timeAsList = RxList(["", ":", "", ""]);
  RxString timeString = RxString("");
  Rx<DateTime> timeInTimeFormat = Rx<DateTime>(null);
  RxBool invalidTime = RxBool(true);
  bool bottomSheet;

  @override
  Widget build(BuildContext context) {
    return bottomSheet == false
        ? Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 30, bottom: 60),
            child: PointerInterceptor(
              child: Card(
                elevation: 5,
                child: Builder(
                  builder: (context) {
                    width = MediaQuery.of(context).size.width / 4;
                    return Container(
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(40)),
                        color: Colors.white,
                      ),
                      child: buildColumn(context),
                    );
                  },
                ),
              ),
            ),
          )
        : PointerInterceptor(
            child: Builder(
              builder: (context) {
                width = MediaQuery.of(context).size.width;
                return Container(
                  decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))),
                  width: width,
                  height: MediaQuery.of(context).size.height,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: buildColumn(context),
                  ),
                );
              },
            ),
          );
  }

  Widget buildColumn(BuildContext context) {
    return Obx(
      () {
        if (streetSelected.isTrue) {
          return FadeAnimation(
            1.0,
            SizedBox(
              height: 500,
              child: ListView(
                children: [
                  bottomSheet == true
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              onPressed: () => Get.back(),
                              icon: Icon(Icons.close),
                              color: Colors.grey,
                            ),
                          ),
                        )
                      : Container(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10),
                    child: Obx(() => Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          child: Text(
                            title.value,
                            style: TextStyle(
                                fontSize: 30,
                                letterSpacing: 2,
                                fontFamily: "OpenSans"),
                          ),
                        ))),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10),
                    child: Obx(() => Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          child: Text(
                            "Available Spaces : ${availableParkingSpaces.value}",
                            style: TextStyle(
                                fontSize: 19,

                                fontFamily: "OpenSans"),
                          ),
                        ))),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: FittedBox(
                          child: Text(
                            DateFormat("dd MMMM yyyy, hh:mm aaa")
                                .format(DateTime.now())
                                .toString(),
                            style: TextStyle(
                                fontSize: 19  ,
                                fontFamily: "OpenSans"),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top:15.0),
                    child: Container(
                      // color: Color(0xFFEDE7F6),
                      child: Column(
                        children: [
                          Align(
                            alignment:Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 10.0,left: 10.0),
                              child: FittedBox(child: Text("Time:",style: TextStyle(fontSize: 19,fontFamily: "OpenSans"),),),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(13.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                bottomSheet == true
                                    ? Flexible(
                                        child: FittedBox(
                                          child: Container(
                                            width: 90,
                                            decoration: BoxDecoration(
                                                color: Colors.deepPurple,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Obx(
                                                () => DropdownButton<String>(
                                                  alignment: Alignment.bottomCenter,
                                                  icon: Icon(
                                                      Icons.keyboard_arrow_down,color: Colors.white,),
                                                  underline: Container(),
                                                  hint: FittedBox(
                                                    child: Text(
                                                      "hours",
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontFamily: "OpenSans"),
                                                    ),
                                                  ),
                                                  menuMaxHeight:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          4,
                                                  value: hour.value,
                                                  items: hoursList
                                                      .map((e) => DropdownMenuItem(
                                                            child:
                                                                Text(e.toString()),
                                                            value: e.toString(),
                                                          ))
                                                      .toList(),
                                                  onChanged: (value) {
                                                    // print(value);
                                                    hour.value = value;
                                                    timeAsList[0] = value;
                                                    // String s = "11:04:59PM";
                                                    // int hoursBefore12 =
                                                    //     s.substring(0, 2) == "12"
                                                    //         ? 0
                                                    //         : int.parse(s.substring(0, 2));
                                                    // int hoursAfter12 = s.substring(0, 2) == "12"
                                                    //     ? 12
                                                    //     : int.parse(s.substring(0, 2)) + 12;
                                                    // var d = TimeOfDay(
                                                    //     hour: s[8] == 'P'
                                                    //         ? hoursAfter12
                                                    //         : hoursBefore12,
                                                    //     minute: int.parse(s.substring(3, 5)));
                                                    // var now = DateTime.now();
                                                    // var time = DateFormat("h:mm:ssa").format(
                                                    //     DateTime(now.year, now.month, now.day,
                                                    //         d.hour, d.minute));
                                                    // print(minuteList);
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : FittedBox(
                                        child: Container(
                                          width: 90,
                                          decoration: BoxDecoration(
                                              color: Colors.deepPurple,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Obx(
                                              () => DropdownButton<String>(
                                                alignment: Alignment.bottomCenter,
                                                icon:
                                                    Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                                                underline: Container(),
                                                hint: FittedBox(
                                                  child: Text(
                                                    "hours",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "OpenSans"),
                                                  ),
                                                ),
                                                menuMaxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        4,
                                                value: hour.value,
                                                items: hoursList
                                                    .map((e) => DropdownMenuItem(
                                                          child: Text(e.toString(),),
                                                          value: e.toString(),
                                                        ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  // print(value);
                                                  hour.value = value;
                                                  timeAsList[0] = value;
                                                  // String s = "11:04:59PM";
                                                  // int hoursBefore12 =
                                                  //     s.substring(0, 2) == "12"
                                                  //         ? 0
                                                  //         : int.parse(s.substring(0, 2));
                                                  // int hoursAfter12 = s.substring(0, 2) == "12"
                                                  //     ? 12
                                                  //     : int.parse(s.substring(0, 2)) + 12;
                                                  // var d = TimeOfDay(
                                                  //     hour: s[8] == 'P'
                                                  //         ? hoursAfter12
                                                  //         : hoursBefore12,
                                                  //     minute: int.parse(s.substring(3, 5)));
                                                  // var now = DateTime.now();
                                                  // var time = DateFormat("h:mm:ssa").format(
                                                  //     DateTime(now.year, now.month, now.day,
                                                  //         d.hour, d.minute));
                                                  // print(minuteList);
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                Text(':'),
                                bottomSheet == true
                                    ? Flexible(
                                        child: FittedBox(
                                          child: Container(
                                            width: 90,
                                            decoration: BoxDecoration(
                                                color: Colors.deepPurple,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Obx(
                                                () => DropdownButton<String>(
                                                  alignment: Alignment.bottomCenter,
                                                  icon: Icon(
                                                      Icons.keyboard_arrow_down,color: Colors.white,),
                                                  value: minute.value,
                                                  underline: Container(),
                                                  hint: Text(
                                                    "minutes",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "OpenSans"),
                                                  ),
                                                  menuMaxHeight:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          4,
                                                  items: minutesList
                                                      .map((e) => DropdownMenuItem(
                                                            child:
                                                                Text(e.toString()),
                                                            value: e.toString(),
                                                          ))
                                                      .toList(),
                                                  onChanged: (value) {
                                                    minute.value = value;
                                                    timeAsList[2] = value;
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : FittedBox(
                                        child: Container(
                                          width: 90,
                                          decoration: BoxDecoration(
                                              color: Colors.deepPurple,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Obx(
                                              () => DropdownButton<String>(
                                                alignment: Alignment.bottomCenter,
                                                icon:
                                                    Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                                                value: minute.value,
                                                underline: Container(),
                                                hint: Text(
                                                  "minutes",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: "OpenSans"),
                                                ),
                                                menuMaxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        4,
                                                items: minutesList
                                                    .map((e) => DropdownMenuItem(
                                                          child: Text(e.toString()),
                                                          value: e.toString(),
                                                        ))
                                                    .toList(),
                                                onChanged: (value) {
                                                  minute.value = value;
                                                  timeAsList[2] = value;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                Text(':'),
                                bottomSheet == true
                                    ? Flexible(
                                        child: FittedBox(
                                          child: Container(
                                            width: 90,
                                            decoration: BoxDecoration(
                                                color: Colors.deepPurple,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(50))),
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8.0),
                                              child: Obx(
                                                () => DropdownButton<String>(
                                                  alignment: Alignment.bottomCenter,
                                                  icon: Icon(
                                                      Icons.keyboard_arrow_down,color: Colors.white,),
                                                  value: meridian.value,
                                                  underline: Container(),
                                                  hint: Text(
                                                    "AM/PM",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w600,
                                                        fontFamily: "OpenSans"),
                                                  ),
                                                  menuMaxHeight:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          4,
                                                  items: [
                                                    DropdownMenuItem(
                                                      child: Text("AM"),
                                                      value: "AM",
                                                    ),
                                                    DropdownMenuItem(
                                                      child: Text("PM"),
                                                      value: "PM",
                                                    )
                                                  ],
                                                  onChanged: (value) {
                                                    meridian.value = value;
                                                    timeAsList[3] = value;
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : FittedBox(
                                        child: Container(
                                          width: 90,
                                          decoration: BoxDecoration(
                                              color: Colors.deepPurple,
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(50))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: Obx(
                                              () => DropdownButton<String>(
                                                alignment: Alignment.bottomCenter,
                                                icon:
                                                    Icon(Icons.keyboard_arrow_down,color: Colors.white,),
                                                value: meridian.value,
                                                underline: Container(),
                                                hint: Text(
                                                  "AM/PM",
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: "OpenSans"),
                                                ),
                                                menuMaxHeight:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width /
                                                        4,
                                                items: [
                                                  DropdownMenuItem(
                                                    child: Text("AM"),
                                                    value: "AM",
                                                  ),
                                                  DropdownMenuItem(
                                                    child: Text("PM"),
                                                    value: "PM",
                                                  )
                                                ],
                                                onChanged: (value) {
                                                  meridian.value = value;
                                                  timeAsList[3] = value;
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Obx(() {
                      if (timeAsList[0] == "" ||
                          timeAsList[2] == "" ||
                          timeAsList[3] == "") {
                        invalidTime.value = true;
                        return Container();
                      } else {
                        timeString.value = timeAsList.join();
                        int hoursBefore12 =
                            timeString.value.substring(0, 2) == "12"
                                ? 0
                                : int.parse(timeString.value.substring(0, 2));
                        int hoursAfter12 = timeString.value.substring(0, 2) ==
                                "12"
                            ? 12
                            : int.parse(timeString.value.substring(0, 2)) + 12;
                        var timeInHoursAndMinutes = TimeOfDay(
                            hour: timeString.value[5] == 'P'
                                ? hoursAfter12
                                : hoursBefore12,
                            minute:
                                int.parse(timeString.value.substring(3, 5)));
                        var now = DateTime.now();
                        timeInTimeFormat.value = DateTime(
                            now.year,
                            now.month,
                            now.day,
                            timeInHoursAndMinutes.hour,
                            timeInHoursAndMinutes.minute);
                        // print("290-booking_card.dart ${timeInTimeFormat.value}");
                        if (timeInTimeFormat.value.compareTo(
                                DateTime.now().add(Duration(minutes: 6))) <
                            0) {
                          invalidTime.value = true;
                          return Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              child: Text(
                                "*Enter a valid time between ${DateFormat("hh:mmaaa").format(DateTime.now().add(Duration(minutes: 7)))} and 11:59PM",
                                style: TextStyle(
                                    fontSize: 14, color: Colors.red.shade900),
                              ),
                            ),
                          );
                        } else {
                          invalidTime.value = false;

                          return Align(
                            alignment: Alignment.centerLeft,
                            child: AutoSizeText(
                              'After Booking,You can park anywhere in ${title.value} between ${DateFormat("hh:mmaaa").format(timeInTimeFormat.value.subtract(Duration(minutes: 5)))} and ${DateFormat("hh:mmaaa").format(timeInTimeFormat.value.add(Duration(minutes: 5)))}',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "OpenSans",
                                  letterSpacing: 1),maxLines: 4,
                            ),
                          );
                        }
                      }
                    }),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        bottom: 14.0, top: 100, left: 50, right: 50),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.deepPurple[100],
                            spreadRadius: 5,
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        child: Container(
                            width: width / 1.5,
                            height: 50,
                            child: Center(
                                child: Text(
                              "Book",
                              style: TextStyle(letterSpacing: 2),
                            ))),
                        onPressed: () {
                          if (invalidTime.value == false) {
                            Get.dialog(PointerInterceptor(
                              child: AlertDialog(
                                content: Text(
                                  "Confirm booking?",
                                  style: TextStyle(
                                      fontFamily: "OpenSans",),
                                ),
                                actions: [
                                  TextButton(
                                      onPressed: () => Get.back(),
                                      child: Text(
                                        "cancel",
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.deepPurple.shade300),
                                      )),
                                  TextButton(
                                      onPressed: () async {
                                        if(bottomSheet==true)
                                        {
                                          Get.back();
                                        }
                                        Get.back();
                                        var bookResponse =
                                            await ApiRequests.book(
                                                time: timeString.value,
                                                id: streetId);
                                        if (bookResponse.statusCode == 200) {

                                          var controller =
                                              Get.find<AuthController>();
                                          controller.statusOfLastBooking.value =
                                              "pending";
                                          print(
                                              "404-booking_card.dart ${json.decode(bookResponse.body)['estimated_start_time']}");
                                          controller.estimatedStartTime.value =
                                              DateTime.parse(json.decode(
                                                      bookResponse.body)[
                                                  'estimated_start_time']);
                                          controller.cancelReverseTimer.value =
                                              false;
                                          controller.streetName.value =
                                              title.value;
                                          controller.reverseTimer();
                                          Get.dialog(PointerInterceptor(
                                            child: AlertDialog(
                                              content: Text(
                                                "Booking Successful!",
                                                style: TextStyle(
                                                    fontFamily: "OpenSans",
                                                    letterSpacing: 1),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () => Get.back(),
                                                    child: Text(
                                                      "Ok",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "OpenSans",
                                                          color: Colors
                                                              .deepPurple
                                                              .shade300),
                                                    )),
                                              ],
                                            ),
                                          ));
                                        } else {
                                          Get.back();
                                          Get.dialog(PointerInterceptor(
                                            child: AlertDialog(
                                              content: Text(
                                                "${bookResponse.body}",
                                                style: TextStyle(
                                                    fontFamily: "OpenSans",
                                                    letterSpacing: 1),
                                              ),
                                              actions: [
                                                TextButton(
                                                    onPressed: () {
                                                      var controller = Get.find<
                                                          AuthController>();
                                                      Get.back();
                                                      controller.isLoading
                                                          .value = true;
                                                      controller.onInit();
                                                    },
                                                    child: Text(
                                                      "Ok",
                                                      style: TextStyle(
                                                          fontFamily:
                                                              "OpenSans",
                                                          color: Colors
                                                              .deepPurple
                                                              .shade300),
                                                    )),
                                              ],
                                            ),
                                          ));
                                        }
                                      },
                                      child: Text(
                                        "Ok",
                                        style: TextStyle(
                                            fontFamily: "OpenSans",
                                            color: Colors.deepPurple.shade300),
                                      ))
                                ],
                              ),
                            ));
                          } else
                            return null;
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.deepPurple.shade400,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return FittedBox(
            child: AutoSizeText(
              title.value,
              style: TextStyle(fontSize: 70, fontFamily: "OpenSans"),
            ),
          );
        }
      },
    );
  }
}
// @override
// Widget build(BuildContext context) {
//   return FadeAnimation(
//     1.0, Padding(
//     padding: const EdgeInsets.only(top: 60.0, left: 30, bottom: 60),
//     child: PointerInterceptor(
//       child: LayoutBuilder(
//         builder:(context,constraints) {
//           if(constraints.maxWidth<1170)
//           {
//             return  DraggableScrollableSheet(
//                 initialChildSize: 0.4,
//                 maxChildSize: 0.6,
//                 minChildSize: 0.2,
//                 builder: (context, scrollController) {
//
//                   return Container(
//                     color: Colors.white,
//
//                     child: buildColumn(context,scrollController: scrollController),
//                   );
//                 });
//           }
//           else
//           {
//             return Card(
//               elevation: 5,
//               child:  Container(
//                 width: MediaQuery.of(context).size.width / 4,
//                 color: Colors.white,
//                 child: buildColumn(context),
//               ),
//             );
//           }
//
//         },
//       ),
//     ),
//   ),
//   );
// }
//
// Widget buildColumn(BuildContext context,{ScrollController scrollController}) {
//   return Obx(
//         () {
//       if (streetSelected.isTrue) {
//         return Column(
//
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 20.0, left: 10),
//               child: Obx(() => Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     title.value,
//                     style: TextStyle(
//                         fontSize: 24,
//                         letterSpacing: 2,
//                         fontFamily: "PTSerif"),
//                   ))),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20.0, left: 10),
//               child: Obx(() => Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     "Available Spaces : ${availableParkingSpaces.value}",
//                     style: TextStyle(
//                         fontSize: 16,
//                         letterSpacing: 2,
//                         fontFamily: "PTSerif"),
//                   ))),
//             ),
//             SizedBox(
//               height: 40,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 20.0, left: 10),
//               child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Text(
//                     DateFormat("dd MMMM yyyy, hh:mm aaa")
//                         .format(DateTime.now())
//                         .toString(),
//                     style: TextStyle(
//                         fontSize: 14,
//                         letterSpacing: 2,
//                         fontFamily: "OpenSans"),
//                   )),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Container(
//                 color: Color(0xFFEDE7F6),
//                 child: Padding(
//                   padding: const EdgeInsets.all(13.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       FittedBox(
//                         child: Container(
//                           width: 90,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(50))),
//                           child: Padding(
//                             padding:
//                             const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Obx(
//                                   () => DropdownButton<String>(
//                                 alignment: Alignment.bottomCenter,
//                                 icon: Icon(Icons.keyboard_arrow_down),
//                                 underline: Container(),
//                                 hint: Text(
//                                   "hours",
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600,
//                                       fontFamily: "OpenSans"),
//                                 ),
//                                 menuMaxHeight:
//                                 MediaQuery.of(context).size.width / 4,
//                                 value: hour.value,
//                                 items: hourList
//                                     .map((e) => DropdownMenuItem(
//                                   child: Text(e.toString()),
//                                   value: e.toString(),
//                                 ))
//                                     .toList(),
//                                 onChanged: (value) {
//                                   print(value);
//                                   hour.value = value;
//                                   timeAsList[0] = value;
//                                   // String s = "11:04:59PM";
//                                   // int hoursBefore12 =
//                                   //     s.substring(0, 2) == "12"
//                                   //         ? 0
//                                   //         : int.parse(s.substring(0, 2));
//                                   // int hoursAfter12 = s.substring(0, 2) == "12"
//                                   //     ? 12
//                                   //     : int.parse(s.substring(0, 2)) + 12;
//                                   // var d = TimeOfDay(
//                                   //     hour: s[8] == 'P'
//                                   //         ? hoursAfter12
//                                   //         : hoursBefore12,
//                                   //     minute: int.parse(s.substring(3, 5)));
//                                   // var now = DateTime.now();
//                                   // var time = DateFormat("h:mm:ssa").format(
//                                   //     DateTime(now.year, now.month, now.day,
//                                   //         d.hour, d.minute));
//                                   // print(minuteList);
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Text(':'),
//                       FittedBox(
//                         child: Container(
//                           width: 90,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(50))),
//                           child: Padding(
//                             padding:
//                             const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Obx(
//                                   () => DropdownButton<String>(
//                                 alignment: Alignment.bottomCenter,
//                                 icon: Icon(Icons.keyboard_arrow_down),
//                                 value: minute.value,
//                                 underline: Container(),
//                                 hint: Text(
//                                   "minutes",
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600,
//                                       fontFamily: "OpenSans"),
//                                 ),
//                                 menuMaxHeight:
//                                 MediaQuery.of(context).size.width / 4,
//                                 items: minuteList
//                                     .map((e) => DropdownMenuItem(
//                                   child: Text(e.toString()),
//                                   value: e.toString(),
//                                 ))
//                                     .toList(),
//                                 onChanged: (value) {
//                                   minute.value = value;
//                                   timeAsList[2] = value;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       Text(':'),
//                       FittedBox(
//                         child: Container(
//                           width: 90,
//                           decoration: BoxDecoration(
//                               color: Colors.white,
//                               borderRadius:
//                               BorderRadius.all(Radius.circular(50))),
//                           child: Padding(
//                             padding:
//                             const EdgeInsets.symmetric(horizontal: 8.0),
//                             child: Obx(
//                                   () => DropdownButton<String>(
//                                 alignment: Alignment.bottomCenter,
//                                 icon: Icon(Icons.keyboard_arrow_down),
//                                 value: meridian.value,
//                                 underline: Container(),
//                                 hint: Text(
//                                   "AM/PM",
//                                   style: TextStyle(
//                                       fontSize: 12,
//                                       color: Colors.black,
//                                       fontWeight: FontWeight.w600,
//                                       fontFamily: "OpenSans"),
//                                 ),
//                                 menuMaxHeight:
//                                 MediaQuery.of(context).size.width / 4,
//                                 items: [
//                                   DropdownMenuItem(
//                                     child: Text("AM"),
//                                     value: "AM",
//                                   ),
//                                   DropdownMenuItem(
//                                     child: Text("PM"),
//                                     value: "PM",
//                                   )
//                                 ],
//                                 onChanged: (value) {
//                                   meridian.value = value;
//                                   timeAsList[3] = value;
//                                 },
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 10,
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 10.0),
//               child: Obx(() {
//                 if (timeAsList[0] == "" ||
//                     timeAsList[2] == "" ||
//                     timeAsList[3] == "") {
//                   invalidTime.value = true;
//                   return Container();
//                 } else {
//                   timeString.value = timeAsList.join();
//                   int hoursBefore12 = timeString.value.substring(0, 2) == "12"
//                       ? 0
//                       : int.parse(timeString.value.substring(0, 2));
//                   int hoursAfter12 = timeString.value.substring(0, 2) == "12"
//                       ? 12
//                       : int.parse(timeString.value.substring(0, 2)) + 12;
//                   var timeInHoursAndMinutes = TimeOfDay(
//                       hour: timeString.value[5] == 'P'
//                           ? hoursAfter12
//                           : hoursBefore12,
//                       minute: int.parse(timeString.value.substring(3, 5)));
//                   var now = DateTime.now();
//                   timeInTimeFormat.value = DateTime(
//                       now.year,
//                       now.month,
//                       now.day,
//                       timeInHoursAndMinutes.hour,
//                       timeInHoursAndMinutes.minute);
//                   print("290-booking_card.dart ${timeInTimeFormat.value}");
//                   if (timeInTimeFormat.value.compareTo(
//                       DateTime.now().add(Duration(minutes: 6))) <
//                       0) {
//                     invalidTime.value = true;
//                     return Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         "*Enter a valid time between ${DateFormat("hh:mmaaa").format(DateTime.now().add(Duration(minutes: 7)))} and 11:59PM",
//                         style: TextStyle(
//                             fontSize: 14, color: Colors.red.shade900),
//                       ),
//                     );
//                   } else {
//                     invalidTime.value = false;
//
//                     return Align(
//                       alignment: Alignment.centerLeft,
//                       child: Text(
//                         'After Booking,You can park anywhere in ${title.value} between ${DateFormat("hh:mmaaa").format(timeInTimeFormat.value.subtract(Duration(minutes: 5)))} and ${DateFormat("hh:mmaaa").format(timeInTimeFormat.value.add(Duration(minutes: 5)))}',
//                         style: TextStyle(
//                             fontSize: 16,
//                             fontFamily: "PTSerif",
//                             letterSpacing: 1),
//                       ),
//                     );
//                   }
//                 }
//               }),
//             ),
//             Spacer(),
//             Padding(
//               padding: const EdgeInsets.only(bottom: 14.0),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.circular(30),
//                   boxShadow: [
//                     BoxShadow(
//                       color: Colors.deepPurple[100],
//                       spreadRadius: 5,
//                       blurRadius: 5,
//                     ),
//                   ],
//                 ),
//                 child: ElevatedButton(
//                   child: Container(
//                       width: width / 1.5,
//                       height: 50,
//                       child: Center(
//                           child: Text(
//                             "Book",
//                             style: TextStyle(letterSpacing: 2),
//                           ))),
//                   onPressed: () {
//                     if(invalidTime.value==false) {
//                       Get.dialog(PointerInterceptor(
//                         child: AlertDialog(
//                           content: Text(
//                             "Confirm booking?",
//                             style: TextStyle(
//                                 fontFamily: "OpenSans", letterSpacing: 1),
//                           ),
//                           actions: [
//                             TextButton(
//                                 onPressed: () => Get.back(),
//                                 child: Text(
//                                   "cancel",
//                                   style: TextStyle(
//                                       fontFamily: "OpenSans",
//                                       color: Colors.deepPurple.shade300),
//                                 )),
//                             TextButton(
//                                 onPressed: () async{
//                                   var bookResponse= await ApiRequests.book(time:timeString.value,id:streetId);
//                                   if(bookResponse.statusCode==200)
//                                   {
//                                     Get.back();
//                                     var controller = Get.find<AuthController>();
//                                     controller.statusOfLastBooking.value="pending";
//                                     print("404-booking_card.dart ${json.decode(bookResponse.body)['estimated_start_time']}");
//                                     controller.estimatedStartTime.value=DateTime.parse(json.decode(bookResponse.body)['estimated_start_time']);
//                                     controller.cancelReverseTimer.value=false;
//                                     controller.streetName.value=title.value;
//                                     controller.reverseTimer();
//                                     Get.dialog(PointerInterceptor(
//                                       child: AlertDialog(content: Text(
//                                         "Booking Successful!",
//                                         style: TextStyle(
//                                             fontFamily: "OpenSans", letterSpacing: 1),
//                                       ),actions: [ TextButton(
//                                           onPressed: () => Get.back(),
//                                           child: Text(
//                                             "Ok",
//                                             style: TextStyle(
//                                                 fontFamily: "OpenSans",
//                                                 color: Colors.deepPurple.shade300),
//                                           )),],),
//                                     ));
//
//                                   }
//                                   else
//                                   {
//                                     Get.back();
//                                     Get.dialog(PointerInterceptor(
//                                       child: AlertDialog(content: Text(
//                                         "${bookResponse.body}",
//                                         style: TextStyle(
//                                             fontFamily: "OpenSans", letterSpacing: 1),
//                                       ),actions: [ TextButton(
//                                           onPressed: () {
//                                             var controller=Get.find<AuthController>();
//                                             Get.back();
//                                             controller.isLoading.value=true;
//                                             controller.onInit();
//                                           },
//                                           child: Text(
//                                             "Ok",
//                                             style: TextStyle(
//                                                 fontFamily: "OpenSans",
//                                                 color: Colors.deepPurple.shade300),
//                                           )),],),
//                                     ));
//                                   }
//                                 },
//                                 child: Text(
//                                   "Ok",
//                                   style: TextStyle(
//                                       fontFamily: "OpenSans",
//                                       color: Colors.deepPurple.shade300),
//                                 ))
//                           ],
//                         ),
//                       ));
//                     }
//                     else
//                       return null;
//                   },
//                   style: ElevatedButton.styleFrom(
//                     primary: Colors.deepPurple.shade400,
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         );
//       } else {
//         return Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 title.value,
//                 style: TextStyle(
//                     fontSize: 24, letterSpacing: 2, fontFamily: "PTSerif"),
//               )
//             ],
//           ),
//         );
//       }
//     },
//   );
// }
