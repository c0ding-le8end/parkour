import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:intl/intl.dart';
import 'package:parking_management/pages/about_page.dart';
import 'package:parking_management/pages/welcome/SignupForm.dart';
import 'package:parking_management/util/animations.dart';
import 'package:parking_management/api/api.dart';
import 'package:parking_management/controllers/authController.dart';
import 'package:parking_management/pages/welcome/login_form.dart';
import 'dart:html' show window;
import '../homepage/homepage.dart';

class LoginPage extends StatelessWidget {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return FadeAnimation(0.8
      ,Scaffold(
        backgroundColor: Color(0xFFf5f5f5),
        body: Scrollbar(
          isAlwaysShown: true,
          controller: scrollController,
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width / 8),
            children: [
              Menu(),   
              // MediaQuery.of(context).size.width >= 980
              //     ? Menu()
              //     : SizedBox(), // Responsive
              Body()
            ],
          ),
        ),
      ),
    );
  }
}

class Menu extends StatelessWidget {
  static RxInt index = RxInt(0);

  Menu({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Obx(() => index.value == 0
              ? _menuItem(title: 'Home', isActive: true, index: 0)
              : _menuItem(title: 'Home', isActive: false, index: 0)),
          Flexible(child: SizedBox(width: 75,)),
          Obx(() => index.value == 1
              ? _menuItem(title: 'About Us', isActive: true, index: 1)
              : _menuItem(title: 'About Us', isActive: false, index: 1)),
        ],
      ),
    );
  }

  Widget _menuItem({String title = 'Title Menu', isActive = false, int index}) {
    return FittedBox(
      child: InkWell(
        onTap: () => Menu.index.value = index,
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Column(
            children: [
              Text(
                '$title',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: isActive ? Colors.deepPurple : Colors.grey,
                ),
              ),
              SizedBox(
                height: 6,
              ),
              isActive
                  ? Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.deepPurple,
                        borderRadius: BorderRadius.circular(30),
                      ),
                    )
                  : SizedBox()
            ],
          ),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  Body({Key key}) : super(key: key);

  static RxInt page = RxInt(0);

  @override
  Widget build(BuildContext context) {
    return Obx(
       () {
         if(Menu.index.value==1)
           {
             return AboutPage();
           }
        return LayoutBuilder(
          builder:(context,constraints) {
            if(constraints.maxWidth>800) {
              return Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Container(
                width: 360,
                height: MediaQuery.of(context).size.height + 150,
                child: LayoutBuilder(
                  builder:(context,constraints) {
                    return Padding(
                    padding: const EdgeInsets.only(bottom: 200.0),
                    child: FittedBox(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FittedBox(
                            child: Text(
                              'ParkOur ',
                              style: TextStyle(
                                  fontSize: 70,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          FittedBox(
                            child: Text(
                              'Park Anywhere!',
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                  },
                ),
              ),
Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 198.0),
                child: SizedBox(
                  width: 360,
                  child: Obx(() {
                    if (page.value == 1) {
                      return SignUpForm();
                    } else {
                      return LoginForm();
                    }
                  }),
                ),
              )
            ],
          );
            }
            else
              {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,

                  children: [
                    SizedBox(height: 80,),
                    FittedBox(
                      child: Text(
                        'ParkOur ',
                        style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      child: Text(
                        'Park Anywhere!',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1),
                      ),
                    ),
                    SizedBox(height: 80,),
                    SizedBox(
                      width: 360,
                      child: Obx(() {
                        if (page.value == 1) {
                          return SignUpForm();
                        } else {
                          return LoginForm();
                        }
                      }),
                    )
                  ],
                );
              }
          },
        );
      }
    );
  }

//   Widget _formLogin(BuildContext context) {
//     TextEditingController emailController = TextEditingController(text: "");
//     TextEditingController passwordController = TextEditingController(text: "");
//     final controller = Get.find<AuthController>();
//     return FadeAnimation(
//      1.0, Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.symmetric(vertical: 30),
//             child: Text(
//               'SignIn',
//               style: TextStyle(
//                 fontSize: 45,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//           ),
//           TextFormField(
//             controller: emailController,
//             decoration: InputDecoration(
//               hintText: 'Enter email',
//               filled: true,
//               fillColor: Colors.blueGrey[50],
//               labelStyle: TextStyle(fontSize: 12),
//               contentPadding: EdgeInsets.only(left: 30),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//           SizedBox(height: 30),
//           TextFormField(
//             controller: passwordController,
//             obscureText: true,
//             decoration: InputDecoration(
//               hintText: 'Password',
//               counterText: 'Forgot password?',
//               suffixIcon: Icon(
//                 Icons.visibility_off_outlined,
//                 color: Colors.grey,
//               ),
//               filled: true,
//               fillColor: Colors.blueGrey[50],
//               labelStyle: TextStyle(fontSize: 12),
//               contentPadding: EdgeInsets.only(left: 30),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//           SizedBox(height: 40),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.deepPurple[100],
//                   spreadRadius: 10,
//                   blurRadius: 20,
//                 ),
//               ],
//             ),
//             child: ElevatedButton(
//               child: Container(
//                   width: double.infinity,
//                   height: 50,
//                   child: Center(child: Text("Sign In"))),
//               onPressed: () async {
//                 try {
//                   var username = emailController.text;
//                   var password = passwordController.text;
//                   print("394-welcome.dart");
//                   var csrf = await ApiRequests.loginUser(username, password);
//                   var data = json.decode(csrf.body);
//                   print("396-welcome.dart ${data['status']}");
//                   if (csrf.body != null && csrf.statusCode == 200) {
//                     window.localStorage["csrf"] = csrf.body;
//                     controller.validToken.value = "true";
//                     controller.email.value = data['userData']['email'];
//                     controller.statusOfLastBooking.value =
//                         data['userData']['status_of_last_booking'] == null
//                             ? ""
//                             : data['userData']['status_of_last_booking'];
//                     controller.name.value = data['userData']['name'];
//
//                     controller.estimatedStartTime.value =
//                         data['estimated_start_time_of_previous_booking'] == null
//                             ? null
//                             : DateTime.parse(
//                                 data['estimated_start_time_of_previous_booking']);
//                     controller.startTime.value =
//                         data['start_time'] == "None" || data['start_time'] == null
//                             ? null
//                             : DateTime.parse(data['start_time']);
//                     controller.surveyGiven.value=data['survey_given'];
//                     if (controller.statusOfLastBooking.value == "started" &&
//                         controller.startTime.value != null) {
//                       controller.timer();
//                     }
//                     if(controller.statusOfLastBooking.value=="pending")
//                     {
//                       controller.reverseTimer();
//                     }
//                     controller.parkingHistory.value =
//                         data['userData']['parking_history'];
//                     controller.getData(loggedIn: false);
//                   } else {
//                     showDialog(
//                         context: context,
//                         builder: (context) {
//                           return AlertDialog(
//                             content: Text("${data['status']}"),
//                           );
//                         });
//                   }
//                 } catch (e) {
//                   return showDialog(
//                       context: context,
//                       builder: (context) {
//                         return SimpleDialog(
//                           children: [
//                             e.message ==
//                                     "a document path must be a non-empty string"
//                                 ? Padding(
//                                     padding: const EdgeInsets.only(top: 20),
//                                     child: Container(
//                                         child: Center(
//                                             child: Text(
//                                       "Enter a phone number first",
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold,
//                                           fontFamily: "OpenSans"),
//                                     ))),
//                                   )
//                                 : Text("${e.message}"),
//                             TextButton(
//                               child: Text(
//                                 "Ok",
//                                 style: TextStyle(
//                                     color: Color.fromRGBO(29, 0, 184, 1),
//                                     fontFamily: "Acme"),
//                               ),
//                               onPressed: () => null,
//                             )
//                           ],
//                         );
//                       });
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.deepPurple,
//                 onPrimary: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 40),
//           SizedBox(
//             height: 30,
//           ),
//           Text(
//             "don't have an account?",
//             style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           MouseRegion(
//             cursor: SystemMouseCursors.click,
//             child: GestureDetector(
//               onTap: () {
//                 page.value = 1;
//               },
//               child: Text(
//                 "Register here!",
//                 style: TextStyle(
//                     color: Colors.deepPurple, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _formSignUp(BuildContext context) {
//     TextEditingController nameController = TextEditingController(text: "");
//     TextEditingController phoneController = TextEditingController(text: "");
//     TextEditingController emailController = TextEditingController(text: "");
//     TextEditingController passwordController = TextEditingController(text: "");
//     TextEditingController rePasswordController =
//         TextEditingController(text: "");
//     final RegExp phoneNumberRegex = RegExp(r'^[0-9]+$');
//     final RegExp emailRegex = RegExp(
//         r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//     RxBool invalidPhoneNumber = RxBool(true);
//     RxBool invalidEmail=RxBool(true);
//     RxBool invalidPassword=RxBool(true);
//     RxBool invalidRePassword=RxBool(true);
//
//     final controller = Get.find<AuthController>();
//     return FadeAnimation(
//       1.0, Column(
//         children: [
//           Center(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 30),
//               child: Text(
//                 'SignUp',
//                 style: TextStyle(
//                   fontSize: 45,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 30),
//           TextFormField(
//             controller: nameController,
//             maxLength: 12,
//             decoration: InputDecoration(
//               hintText: 'Name',
//               filled: true,
//               fillColor: Colors.blueGrey[50],
//               labelStyle: TextStyle(fontSize: 12),
//               contentPadding: EdgeInsets.only(left: 30),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//           SizedBox(height: 40),
//           TextFormField(
//             controller: phoneController,
//             maxLength: 10,
//             onChanged: (value) {
//               if (value == null || value.length != 10) {
//                 invalidPhoneNumber.value = true;
//               } else {
//                 if(phoneNumberRegex.hasMatch(value)==false)
//                   {
//                     invalidPhoneNumber.value = true;
//                   }
//                 else
//                   {
//                     invalidPhoneNumber.value = false;
//                   }
//
//               }
//             },
//             decoration: InputDecoration(
//               hintText: 'Phone number',
//               filled: true,
//               fillColor: Colors.blueGrey[50],
//               labelStyle: TextStyle(fontSize: 12),
//               contentPadding: EdgeInsets.only(left: 30),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//           Obx(() {
//             if (invalidPhoneNumber.value == false || phoneController.text == "") {
//
//               return Container();
//             } else {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: AutoSizeText(
//                   "A phone number should be 10 characters long",
//                   style: TextStyle(
//                       color: Colors.red,
//                       letterSpacing: 1,
//                       fontFamily: "OpenSans"),
//                 ),
//               );
//             }
//           }),
//           SizedBox(height: 40),
//           TextFormField(
//             controller: emailController,
//             onChanged: (value)
//             {
//               if(emailRegex.hasMatch(value))
//                 {
//                   invalidEmail.value=false;
//                 }
//               else
//                 {
//                   invalidEmail.value=true;
//                 }
//             },
//             decoration: InputDecoration(
//               hintText: 'email',
//
//               filled: true,
//               fillColor: Colors.blueGrey[50],
//               labelStyle: TextStyle(fontSize: 12),
//               contentPadding: EdgeInsets.only(left: 30),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//           Obx(() {
//             if (invalidEmail.value == false || emailController.text == "") {
//
//               return Container();
//             } else {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: AutoSizeText(
//                   "Enter a valid email address",
//                   style: TextStyle(
//                       color: Colors.red,
//                       letterSpacing: 1,
//                       fontFamily: "OpenSans"),
//                 ),
//               );
//             }
//           }),
//           SizedBox(height: 40),
//           TextFormField(
//             controller: passwordController,
//             onChanged: (value)
//             {
//
//               if(value.length<6)
//               {
//                 invalidPassword.value=true;
//               }
//               else
//               {
//               if(rePasswordController.text!=value)
//                 {
//                   invalidRePassword.value=true;
//                 }
//                 invalidPassword.value=false;
//               }
//             },
//             obscureText: true,
//             decoration: InputDecoration(
//               hintText: 'Password',
//               suffixIcon: Icon(
//                 Icons.visibility_off_outlined,
//                 color: Colors.grey,
//               ),
//               filled: true,
//               fillColor: Colors.blueGrey[50],
//               labelStyle: TextStyle(fontSize: 12),
//               contentPadding: EdgeInsets.only(left: 30),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//           Obx(() {
//             if (invalidPassword.value == false || passwordController.text == "") {
//
//               return Container();
//             } else {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: AutoSizeText(
//                   "Your Password must contain a minimum of 6 characters",
//                   style: TextStyle(
//                       color: Colors.red,
//                       letterSpacing: 1,
//                       fontFamily: "OpenSans"),
//                 ),
//               );
//             }
//           }),
//           SizedBox(height: 40),
//           TextFormField(
//             controller: rePasswordController,
//             onChanged: (value)
//             {
//               if(value!=passwordController.text)
//                 {
//                   invalidRePassword.value=true;
//                 }
//               else
//                 {
//                   invalidRePassword.value=false;
//                 }
//             },
//             obscureText: true,
//             decoration: InputDecoration(
//               hintText: 're-enter password',
//               suffixIcon: Icon(
//                 Icons.visibility_off_outlined,
//                 color: Colors.grey,
//               ),
//               filled: true,
//               fillColor: Colors.blueGrey[50],
//               labelStyle: TextStyle(fontSize: 12),
//               contentPadding: EdgeInsets.only(left: 30),
//               enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.blueGrey[50]),
//                 borderRadius: BorderRadius.circular(15),
//               ),
//             ),
//           ),
//           Obx(() {
//             if (invalidRePassword.value == false || rePasswordController.text == "") {
// print("592login.dart ${invalidRePassword.value } ${rePasswordController.text}");
//               return Container();
//             } else {
//               return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: AutoSizeText(
//                   "Password does not match",
//                   style: TextStyle(
//                       color: Colors.red,
//                       letterSpacing: 1,
//                       fontFamily: "OpenSans"),
//                 ),
//               );
//             }
//           }),
//           SizedBox(height: 40),
//           Container(
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(30),
//               boxShadow: [
//                 BoxShadow(
//                   color: Colors.deepPurple[100],
//                   spreadRadius: 10,
//                   blurRadius: 20,
//                 ),
//               ],
//             ),
//             child: ElevatedButton(
//               child: Container(
//                   width: double.infinity,
//                   height: 50,
//                   child: Center(child: Text("Sign In"))),
//               onPressed: () async {
//                 try {
//                   print("invalidPhoneNumber:${invalidPhoneNumber.value}");
//                   print("invalidEmail:${invalidEmail.value}");
//                   print("invalidPassword:${invalidPassword.value}");
//                   print("invalidRePassword:${invalidRePassword.value}");
//                   if(nameController.text!=null&&nameController.text!=""&&invalidPhoneNumber.value==false&&invalidEmail.value==false&&invalidPassword.value==false&&invalidRePassword.value==false)
//                     {
//                       var name = nameController.text;
//                       var phoneNumber = phoneController.text;
//                       var email = emailController.text;
//                       var password = passwordController.text;
//                       print("588-welcome.dart");
//                       var csrf = await ApiRequests.signUpUser(
//                           name, phoneNumber, email, password);
//                       print("590-welcome.dart ${json.decode(csrf.body)['status']}");
//                       if (csrf.body != null && csrf.statusCode == 200) {
//                         window.localStorage["csrf"] = csrf.body;
//                         controller.validToken.value = "true";
//                         controller.email.value =
//                         json.decode(csrf.body)['userData']['email'];
//                         controller.name.value =
//                         json.decode(csrf.body)['userData']['name'];
//                         controller.estimatedStartTime.value = null;
//                         controller.parkingHistory.value =
//                         json.decode(csrf.body)['userData']['parking_history'];
//                         controller.surveyGiven.value=json.decode(csrf.body)['survey_given'];
//                         // print("599-login.dart ${controller.estimatedStartTime.value}");
//                         // print("600-login.dart ${DateFormat("hh:mmaaa").format(controller.estimatedStartTime.value)}");
//                         controller.getData(loggedIn: false);
//                       } else {
//                         showDialog(
//                             context: context,
//                             builder: (context) {
//                               return AlertDialog(
//                                 content: Text("An error occured"),
//                               );
//                             });
//                       }
//                     }
//                   else {
//                     return null;
//                   }
//
//                 } catch (e) {
//                   return showDialog(
//                       context: context,
//                       builder: (context) {
//                         return SimpleDialog(
//                           children: [
//                             e.message ==
//                                     "a document path must be a non-empty string"
//                                 ? Padding(
//                                     padding: const EdgeInsets.only(top: 20),
//                                     child: Container(
//                                         child: Center(
//                                             child: Text(
//                                       "Enter a phone number first",
//                                       style: TextStyle(
//                                           fontSize: 15,
//                                           fontWeight: FontWeight.bold,
//                                           fontFamily: "OpenSans"),
//                                     ))),
//                                   )
//                                 : Text("${e}"),
//                             TextButton(
//                               child: Text(
//                                 "Ok",
//                                 style: TextStyle(
//                                     color: Color.fromRGBO(29, 0, 184, 1),
//                                     fontFamily: "Acme"),
//                               ),
//                               onPressed: () => null,
//                             )
//                           ],
//                         );
//                       });
//                 }
//               },
//               style: ElevatedButton.styleFrom(
//                 primary: Colors.deepPurple,
//                 onPrimary: Colors.white,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(15),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(height: 40),
//           Center(
//             child: Text(
//               "don't have an account?",
//               style:
//                   TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           MouseRegion(
//             cursor: SystemMouseCursors.click,
//             child: GestureDetector(
//               onTap: () {
//                 page.value = 0;
//               },
//               child: Center(
//                 child: Text(
//                   "Sign in!",
//                   style: TextStyle(
//                       color: Colors.deepPurple, fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
}
