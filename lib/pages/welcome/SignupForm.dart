import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parking_management/pages/welcome/welcome.dart';
import 'package:parking_management/util/animations.dart';
import 'dart:html' show window;
import '../../api/api.dart';
import '../../controllers/authController.dart';

class SignUpForm extends StatelessWidget {
  SignUpForm({Key key}) : super(key: key);

  final RegExp phoneNumberRegex = RegExp(r'^[0-9]+$');
  final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  final controller = Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return FadeAnimation(
      1.0, Column(
      children: [
        Center(
          child:   Padding(
            padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 10),
            child: FittedBox(
              child: Text(
                'SignUp',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        TextFormField(
          controller: controller.signupNameController,
          maxLength: 12,
          decoration: InputDecoration(
            hintText: 'Name',
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
        TextFormField(
          controller: controller.phoneController,
          maxLength: 10,
          onChanged: (value) {
            if (value == null || value.length != 10) {
              controller.invalidPhoneNumber.value = true;
            } else {
              if(phoneNumberRegex.hasMatch(value)==false)
              {
                controller.invalidPhoneNumber.value = true;
              }
              else
              {
                controller.invalidPhoneNumber.value = false;
              }

            }
          },
          decoration: InputDecoration(
            hintText: 'Phone number',
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
        Obx(() {
          if (controller.invalidPhoneNumber.value == false || controller.phoneController.text == "") {

            return Container();
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                "A phone number should be 10 characters long",
                style: TextStyle(
                    color: Colors.red,
                    letterSpacing: 1,
                    fontFamily: "OpenSans"),
              ),
            );
          }
        }),
        SizedBox(height: 40),
        TextFormField(
          controller: controller.signupEmailController,
          onChanged: (value)
          {
            if(emailRegex.hasMatch(value))
            {
              controller.invalidEmail.value=false;
            }
            else
            {
              controller.invalidEmail.value=true;
            }
          },
          decoration: InputDecoration(
            hintText: 'email',

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
        Obx(() {
          if (controller.invalidEmail.value == false || controller.signupEmailController.text == "") {

            return Container();
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                "Enter a valid email address",
                style: TextStyle(
                    color: Colors.red,
                    letterSpacing: 1,
                    fontFamily: "OpenSans"),
              ),
            );
          }
        }),
        SizedBox(height: 40),
        TextFormField(
          controller: controller.signupPasswordController,
          onChanged: (value)
          {

            if(value.length<6)
            {
              controller.invalidPassword.value=true;
            }
            else
            {
              if(controller.rePasswordController.text!=value)
              {
                controller.invalidRePassword.value=true;
              }
              controller.invalidPassword.value=false;
            }
          },
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
        Obx(() {
          if (controller.invalidPassword.value == false || controller.signupPasswordController.text == "") {

            return Container();
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                "Your Password must contain a minimum of 6 characters",
                style: TextStyle(
                    color: Colors.red,
                    letterSpacing: 1,
                    fontFamily: "OpenSans"),
              ),
            );
          }
        }),
        SizedBox(height: 40),
        TextFormField(
          controller: controller.rePasswordController,
          onChanged: (value)
          {
            if(value!=controller.signupPasswordController.text)
            {
              controller.invalidRePassword.value=true;
            }
            else
            {
              controller.invalidRePassword.value=false;
            }
          },
          obscureText: true,
          decoration: InputDecoration(
            hintText: 're-enter password',
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
        Obx(() {
          if (controller.invalidRePassword.value == false || controller.rePasswordController.text == "") {
            // print("592login.dart ${invalidRePassword.value } ${rePasswordController.text}");
            return Container();
          } else {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                "Password does not match",
                style: TextStyle(
                    color: Colors.red,
                    letterSpacing: 1,
                    fontFamily: "OpenSans"),
              ),
            );
          }
        }),
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
                    if(controller.isSigningUp.value==true)
                      {

                        return CircularProgressIndicator();
                      }
                    return Text("Register");
                  }
                ))),
            onPressed: () async {
              try {
                if(controller.isSigningUp.value==true)
                {
                  return null;
                }
                // print("controller.invalidPhoneNumber:${controller.invalidPhoneNumber.value}");
                // print("invalidEmail:${invalidEmail.value}");
                // print("invalidPassword:${invalidPassword.value}");
                // print("invalidRePassword:${invalidRePassword.value}");
                if(controller.signupNameController.text!=null&&controller.signupNameController.text!=""&&controller.invalidPhoneNumber.value==false&&controller.invalidEmail.value==false&&controller.invalidPassword.value==false&&controller.invalidRePassword.value==false)
                {
                  var name = controller.signupNameController.text;
                  var phoneNumber = controller.phoneController.text;
                  var email = controller.signupEmailController.text;
                  var password = controller.signupPasswordController.text;
                  // print("588-Login.dart");
                  var csrf = await ApiRequests.signUpUser(
                      name, phoneNumber, email, password);
                  // print("590-Login.dart ${json.decode(csrf.body)['status']}");
                  if (csrf.body != null && csrf.statusCode == 200) {
                    window.localStorage["csrf"] = csrf.body;
                    controller.validToken.value = "true";
                    controller.email.value =
                    json.decode(csrf.body)['userData']['email'];
                    controller.name.value =
                    json.decode(csrf.body)['userData']['name'];
                    controller.estimatedStartTime.value = null;
                    controller.parkingHistory.value =
                    json.decode(csrf.body)['userData']['parking_history'];
                    controller.surveyGiven.value=json.decode(csrf.body)['survey_given'];
                    // print("599-login.dart ${controller.estimatedStartTime.value}");
                    // print("600-login.dart ${DateFormat("hh:mmaaa").format(controller.estimatedStartTime.value)}");
                    controller.getData(loggedIn: false);
                  } else {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: Text("${json.decode(csrf.body)['message']}",style: TextStyle( fontFamily: "OpenSans",),),
                            actions: [TextButton(onPressed: ()=>Get.back(), child: Text("Ok",
                            style: TextStyle( fontFamily: "OpenSans",
                                color: Colors.deepPurple.shade300),))],
                          );
                        });
                  }
                }
                else {
                  return null;
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
                              : Text("${e}"),
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
        Center(
          child: FittedBox(
            child: Text(  
              "don't have an account?",
              style:
              TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
            ),
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
                  Body.page.value = 0;
                },
                child: Center(
                  child: Text(
                    "Sign in!",
                    style: TextStyle(
                        color: Colors.deepPurple, fontWeight: FontWeight.bold),
                  ),
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
