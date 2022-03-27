import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_management/controllers/authController.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key key}) : super(key: key);
  final AuthController controller = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {

    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 50,top: 50.0,right: 50.0,bottom: 10.0),
            child: AutoSizeText(
              "Your Parking History:",
              style: TextStyle(color: Colors.black,
                fontWeight: FontWeight.w100,),
              maxFontSize: 24,minFontSize: 20,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 50.0,right: 50.0,bottom: 50.0),
            child: Table(
              border: TableBorder.all(color: Colors.black.withOpacity(0.4)),
              children: [
                    TableRow(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: Colors.grey.withOpacity(0.4)),
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AutoSizeText(
                              "Date",
                              maxLines: 1,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AutoSizeText(
                              "street name",
                              maxLines: 1,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AutoSizeText(
                              "start time",
                              maxLines: 1,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              "end time",
                              maxLines: 1,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AutoSizeText(
                              "status of parking",
                              maxLines: 1,
                            ),
                          ),
                        ),
                      ],
                    )
                  ] +
                  List.generate(controller.parkingHistory.length, (index) {
                    String startTime =
                        controller.parkingHistory[index]['start_time'] == null
                            ? 'N/A'
                            : controller.parkingHistory[index]['start_time'];
                    String endTime =
                        controller.parkingHistory[index]['end_time'] == null
                            ? 'N/A'
                            : controller.parkingHistory[index]['end_time'];
                    // if (index == 0) {
                    //   return TableRow(
                    //     children: [
                    //       Column(
                    //         children: [
                    //           Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: AutoSizeText(
                    //               "Your Parking History:",
                    //               style: AutoSizeTextStyle(fontSize: 24, fontFamily: "OpenSans"),
                    //             ),
                    //           ),
                    //           Row(
                    //             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //             children: [
                    //               Flexible(
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(10.0),
                    //                   child: AutoSizeText(
                    //                       "${controller.parking_history[index]['date']}"),
                    //                 ),
                    //               ),
                    //               Flexible(
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(10.0),
                    //                   child: Text(
                    //                       "${controller.parking_history[index]['street_name']}"),
                    //                 ),
                    //               ),
                    //               Flexible(
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(10.0),
                    //                   child: Text(startTime),
                    //                 ),
                    //               ),
                    //               Flexible(
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(8.0),
                    //                   child: Text(endTime),
                    //                 ),
                    //               ),
                    //               Flexible(
                    //                 child: Padding(
                    //                   padding: const EdgeInsets.all(10.0),
                    //                   child: Text(
                    //                       "${controller.parking_history[index]['status_of_parking']}"),
                    //                 ),
                    //               ),
                    //             ],
                    //           ),
                    //         ],
                    //       ),
                    //     ],
                    //   );
                    // }
                    return TableRow(
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: Colors.black.withOpacity(0.2),
                              width: 0.3)),
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AutoSizeText(
                              "${controller.parkingHistory[index]['date']}",
                              maxLines: 5,

                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AutoSizeText(
                              "${controller.parkingHistory[index]['street_name']}",textAlign: TextAlign.justify,
                              maxLines: 5,
                              minFontSize: 4,
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AutoSizeText(
                              startTime,
                              maxLines: 5,

                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AutoSizeText(
                              endTime,
                              maxLines: 5,

                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: AutoSizeText(
                              "${controller.parkingHistory[index]['status_of_parking']}",
                              maxLines: 5,

                            ),
                          ),
                        ),
                      ],
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
