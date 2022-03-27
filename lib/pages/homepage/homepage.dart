import 'dart:convert';
import 'dart:html' show window;

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:parking_management/controllers/bindings.dart';

import 'package:parking_management/api/api.dart';
import 'package:parking_management/pages/homepage/booking_card.dart';
import 'package:parking_management/controllers/authController.dart';
import 'package:parking_management/pages/homepage/maps.dart';
import 'package:parking_management/pages/homepage/parking_ticket.dart';
import 'package:parking_management/root.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import '../about_page.dart';
import '../historyPage.dart';

import '../survey_page/survey_page.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);
  final AuthController controller = Get.find<AuthController>();
  final ScrollController scrollController = ScrollController();
  RxBool onEntered = RxBool(false);
  static RxInt pageNumber = RxInt(0);

  @override
  Widget build(BuildContext context) {
    // ignore: void_checks
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   if (controller.statusOfLastBooking.value == "invalid") {
    //     return showDialog(
    //         context: context,
    //         builder: (context) {
    //           return PointerInterceptor(
    //             child: AlertDialog(
    //               title: Text(
    //                 "Previous booking cancelled",
    //                 style: TextStyle(
    //                     fontSize: 16, fontFamily: "PTSerif", letterSpacing: 1),
    //               ),
    //               content: Text(
    //                 "Looks like you failed to park your vehicle on time.Make sure you don't repeat this again",
    //                 style: TextStyle(
    //                     fontSize: 16, fontFamily: "PTSerif", letterSpacing: 1),
    //               ),
    //               actions: [
    //                 TextButton(
    //                     onPressed: () {
    //                       controller.statusOfLastBooking.value = "invalid";
    //                       Get.back();
    //                       Get.back();
    //                     },
    //                     child: Text(
    //                       "Ok",
    //                       style: TextStyle(
    //                           fontFamily: "OpenSans",
    //                           color: Colors.deepPurple.shade300),
    //                     ))
    //               ],
    //             ),
    //           );
    //         });
    //   } else {
    //     return null;
    //   }
    // });
    return Scaffold(
        endDrawer: PointerInterceptor(
          child: BuildDrawer(),
        ),
        appBar: AppBar(
          title: FittedBox(
            child: Text(
              "ParkOur",
              style:
                  TextStyle(fontSize: 20, letterSpacing: 2, fontFamily: "Acme"),
            ),
          ),
          backgroundColor: Colors.deepPurple.shade800,
          actions: [
            Builder(builder: (context) {
              return TextButton(
                  onPressed: () {
                    Scaffold.of(context).openEndDrawer();
                  },
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Icon(
                          Icons.person,
                          color: Colors.grey.shade200,
                        ),
                      ),
                      AutoSizeText(
                        controller.name.value,
                        style: TextStyle(color: Colors.white, fontSize: 19),
                      ),
                    ],
                  ));
            })
          ],
        ),
        body: LayoutBuilder(
          builder: (context,constraints) {
            return Obx(() {
              if (pageNumber.value == 2) {
                return HistoryPage();
              }
              if (pageNumber.value == 3) {
                // print("112homepage.dart ${pageNumber.value}");
                return SurveyPage();
              }
              if (pageNumber.value == 4) {
                return SizedBox(height:MediaQuery.of(context).size.height,child: ListView(
                  children: [
                    AboutPage(),
                  ],
                ));
              }
              if (controller.statusOfLastBooking == "" ||
                  controller.statusOfLastBooking == "invalid" ||
                  controller.statusOfLastBooking == "completed") {
                if(constraints.maxWidth>1146)
                  {
                    controller.bottomSheet=false;
                    return Stack(
                      children: [
                       GoogleMap(),
                        BookingCard(bottomSheet: false,),
                      ],
                      fit: StackFit.loose,
                    );
                  }
                else
                  {
                    controller.bottomSheet=true;
                    return Stack(
                      children: [
                        GoogleMap(),
                        Container(color: Colors.white.withOpacity(0.4),
                          child: FittedBox(
                            child: AutoSizeText(
                              "Select a Street",
                              style: TextStyle(
                                  fontSize: 70, fontFamily: "OpenSans"),
                            ),
                          ),
                        )
                      ],
                      fit: StackFit.loose,
                    );
                  }

              } else {
                return ParkingTicket();
              }
            });
          }
        ));
  }
}

class BuildDrawer extends StatelessWidget {
  BuildDrawer({
    Key key,
  }) : super(key: key);
  final ScrollController scrollController = ScrollController();
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Color(0xFF2E1A47),
        child: ListView(controller: scrollController, children: [
          DrawerHeader(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.1)),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          '${controller.name}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 25.0,
                              letterSpacing: 1,
                              fontFamily: "OpenSans"),
                        ),
                        SizedBox(height: 10.0),
                        Text(
                          '${controller.email}',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 14.0,
                              fontFamily: "OpenSans"),
                        ),
                      ],
                    ),
                  ])),
          Column(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: InkWell(
                    onTap: () {
                      HomePage.pageNumber.value = 1;
                      Get.back();
                    },
                    child: ListTile(
                      title: Text(
                        "Home",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: InkWell(
                    onTap: () {
                      var logOutResult = ApiRequests.logout().then((value) {
                        controller.cancelReverseTimer.value = true;
                        controller.cancelTimer.value = true;

                        if (value['logOutResult'] == "success") {
                          try {
                            BookingCard.streetSelected = RxBool(false);
                            BookingCard.title = RxString("Select a street  ");
                            BookingCard.availableParkingSpaces = RxString("");
                            Get.offAll(() => Root(),
                                routeName: '/',
                                binding: AuthBindings(),
                                transition: Transition.fade,
                                duration: Duration(seconds: 1));
                            HomePage.pageNumber.value = 0;
                          } catch (e) {
                           print("213 $e");
                            print("214 ${e.message}");
                          }
                        } else {
                          Get.dialog(AlertDialog(
                            content: Text(
                              "An error occured",
                            ),
                            actions: [
                              TextButton(
                                  onPressed: () => Get.back(),
                                  child: Text("Ok"))
                            ],
                          ));
                        }
                      });
                      print("signed out!");
                    },
                    child: ListTile(
                      title: Text(
                        "Sign Out",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: InkWell(
                    onTap: () {
                      Get.back();
                      controller.isLoading.value = true;
                      Future.delayed(Duration(milliseconds: 800), () {
                        controller.isLoading.value = false;
                      });
                      HomePage.pageNumber.value = 2;
                    },
                    child: ListTile(
                      title: Text(
                        "Parking History",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: InkWell(
                    onTap: () {
                      Get.back();
                      controller.isLoading.value = true;
                      Future.delayed(Duration(milliseconds: 800), () {
                        controller.isLoading.value = false;
                      });
                      HomePage.pageNumber.value = 3;
                    },
                    child: ListTile(
                      title: Text(
                        "Take Survey",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: InkWell(
                    onTap: () {
                      HomePage.pageNumber.value = 4;
                      Get.back();
                    },
                    child: ListTile(
                      title: Text(
                        "About",
                        style: TextStyle(color: Colors.white),
                      ),
                    )),
              ),
            ],
          )
        ]));
  }
}
