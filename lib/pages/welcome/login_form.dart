import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_management/pages/welcome/welcome.dart';
import 'package:parking_management/util/animations.dart';
import 'dart:html' show window;
import '../../api/api.dart';
import '../../controllers/authController.dart';

class LoginForm extends StatelessWidget {
   LoginForm({Key key}) : super(key: key);

  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {

    return FadeAnimation(
      1.0, Column(
      children: [
    Padding(
    padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
      child: FittedBox(
        child: Text(
          'SignIn',
          style: TextStyle(
            fontSize: 45,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    ),
        TextFormField(
          controller: controller.signinEmailController,
          decoration: InputDecoration(
            hintText: 'Enter email',
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 30),
        TextFormField(
          controller: controller.signinPasswordController,
          obscureText: true,
          decoration: InputDecoration(
            hintText: 'Password',
            suffixIcon: Icon(
              Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
            filled: true,
            fillColor: Colors.blueGrey[50],
            labelStyle: TextStyle(fontSize: 12),
            contentPadding: EdgeInsets.only(left: 30),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]),
              borderRadius: BorderRadius.circular(15),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blueGrey[50]),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        SizedBox(height: 40),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: Colors.deepPurple[100],
                spreadRadius: 10,
                blurRadius: 20,
              ),
            ],
          ),
          child: ElevatedButton(
            child: Container(
                width: double.infinity,
                height: 50,
                child: Center(child: Obx(
                  () {
                    if(controller.isLoggingIn.value==true)
                    {
                      return CircularProgressIndicator();
                    }
                    return Text("Sign In");
                  }
                ))),
            onPressed: () async {
              try {
                if(controller.isLoggingIn.value==true)
                  {
                    return null;
                  }
                var username = controller.signinEmailController.text;
                var password = controller.signinPasswordController.text;
             //   print("394-Login.dart");
                var csrf = await ApiRequests.loginUser(username, password);
                var data = json.decode(csrf.body);
              //  print("396-Login.dart ${data['status']}");
                if (csrf.body != null && csrf.statusCode == 200) {
                  window.localStorage["csrf"] = csrf.body;
                  controller.validToken.value = "true";
                  controller.email.value = data['userData']['email'];
                  controller.statusOfLastBooking.value =
                  data['userData']['status_of_last_booking'] == null
                      ? ""
                      : data['userData']['status_of_last_booking'];
                  controller.name.value = data['userData']['name'];

                  controller.estimatedStartTime.value =
                  data['estimated_start_time_of_previous_booking'] == null
                      ? null
                      : DateTime.parse(
                      data['estimated_start_time_of_previous_booking']);
                  controller.startTime.value =
                  data['start_time'] == "None" || data['start_time'] == null
                      ? null
                      : DateTime.parse(data['start_time']);
                  controller.surveyGiven.value=data['survey_given'];
                  if (controller.statusOfLastBooking.value == "started" &&
                      controller.startTime.value != null) {
                    controller.timer();
                  }
                  if(controller.statusOfLastBooking.value=="pending")
                  {
                    controller.reverseTimer();
                  }
                  controller.parkingHistory.value =
                  data['userData']['parking_history'];
                  controller.getData(loggedIn: false);
                } else {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text("${data['status']}"),
                          actions: [TextButton(onPressed: ()=>Get.back(), child: Text("Ok",
                            style: TextStyle( fontFamily: "OpenSans",
                                color: Colors.deepPurple.shade300),))],
                        );
                      });
                }
              } catch (e) {
                return showDialog(
                    context: context,
                    builder: (context) {
                      return SimpleDialog(
                        children: [
                          e.message ==
                              "a document path must be a non-empty string"
                              ? Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                                child: Center(
                                    child: Text(
                                      "Enter a phone number first",
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "OpenSans"),
                                    ))),
                          )
                              : Text("${e.message}"),
                          TextButton(
                            child: Text(
                              "Ok",
                              style: TextStyle(
                                  color: Color.fromRGBO(29, 0, 184, 1),
                                  fontFamily: "Acme"),
                            ),
                            onPressed: () => null,
                          )
                        ],
                      );
                    });
              }
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.deepPurple,
              onPrimary: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
        SizedBox(height: 40),
        SizedBox(
          height: 30,
        ),
        FittedBox(
          child: Text(
            "don't have an account?",
            style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10.0),
          child: FittedBox(
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Body.page.value = 1;
                },
                child: Text(
                  "Register here!",
                  style: TextStyle(
                      color: Colors.deepPurple, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    ),
    );
  }
}
