import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/browser_client.dart';
import 'package:parking_management/pages/welcome/welcome.dart';

import 'package:parking_management/api/api.dart';
import 'package:parking_management/pages/homepage/booking_card.dart';
import 'package:parking_management/controllers/authController.dart';
import 'package:parking_management/pages/homepage/maps.dart';

import 'dart:html' show window;
import 'dart:convert' show json, base64, ascii;
import 'controllers/bindings.dart';
import 'pages/homepage/homepage.dart';
import 'package:http/http.dart' as http;

import 'root.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
     getPages: [GetPage(name: '/', page: ()=>Root(),binding: AuthBindings())],
      initialRoute: '/',
      debugShowCheckedModeBanner: false,
      // home: BookingCard(),
    );
  }
}





// class H extends StatelessWidget {
//   GController controller = Get.find<GController>(tag: "1");
//
//   @override
//   Widget build(context) => Scaffold(
//       appBar: AppBar(
//         title: Text("counter"),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Get.offAll(() => H(), binding: AuthBindings());
//               },
//               icon: Icon(Icons.add_a_photo))
//         ],
//       ),
//       body: Center(
//         child: Obx(() => Text("${controller.count.value}")),
//       ),
//       floatingActionButton: FloatingActionButton(
//         child: Icon(Icons.add),
//         onPressed: () => controller.count.value++,
//       ));
// }

// class GController extends GetxController {
//   RxInt count = RxInt(0);
//
//   void increment() {
//     count++;
//   }
// }

// class MapTimer extends StatefulWidget {
//   const MapTimer({Key key}) : super(key: key);
//
//   @override
//   _MapTimerState createState() {
//     return _MapTimerState();
//   }
// }

// class _MapTimerState extends State<MapTimer> {
//   TimeOfDay selectedTime = TimeOfDay(hour: 3,minute: 55);
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Flutter TimePicker"),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             ElevatedButton(
//               onPressed: () {
//                 _selectTime(context);
//               },
//               child: Text("Choose Time"),
//             ),
//             Text("${selectedTime.hour}:${selectedTime.minute}"),
//           ],
//         ),
//       ),
//     );
//   }
//
//   _selectTime(BuildContext context) async {
//     final TimeOfDay timeOfDay = await showTimePicker(
//       context: context,
//       initialTime: selectedTime,
//       initialEntryMode: TimePickerEntryMode.dial,
//     );
//     if (timeOfDay != null &&
//         timeOfDay != selectedTime &&
//         timeOfDay.hour > TimeOfDay.now().hour && timeOfDay.minute>TimeOfDay.now().minute) {
//       // print("executed");
//       setState(() {
//         selectedTime = timeOfDay;
//       });
//     } else {
//       showDialog(
//           context: context,
//           builder: (context) {
//             return AlertDialog(
//               content: Text("please choose a valid time"),
//               actions: [
//                 TextButton(
//                     onPressed: () => Navigator.of(context).pop(),
//                     child: Text("Ok"))
//               ],
//             );
//           });
//     }
//   }
// }
