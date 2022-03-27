import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as GET;
import 'package:http/browser_client.dart';
import 'package:http/http.dart';
import 'package:parking_management/api/podo.dart';
import 'package:parking_management/controllers/authController.dart';

import '../pages/welcome/welcome.dart';
import '../main.dart';





class ApiRequests {
  static Future<List> getStreets() async {
    List streetList = [];

    //var newDate=Date_Get.getNewDate(0);
    var url = "http://127.0.0.1:5000/";

    //var url="https://cdn-api.co-vin.in/api/v2/appointment/sessions/public/findByPin?pincode=%22+pincode+%22&date=%22+$today";
    Response response = await get(Uri.parse(url));

    if (response.statusCode == 200) {

      for (var element in json.decode(response.body)) {
        var obj = Street.fromJson(element);
        print(obj.id);
        print(obj.availableSpaces);
        print(obj.startLatitude);
        print(obj.startLongitude);
        print(obj.stopLatitude);
        print(obj.stopLongitude);
        print(obj.coordinateString);
        print("_____");
        streetList.add(obj);
      }
      // print("73,api.dart $streetList");
      return streetList;
    } else {
      throw Exception("Error recieving data");
    }
  }

  static Future loginUser(String email, String password) async {
    GET.Get.find<AuthController>().isLoggingIn.value=true;
    Response response = await post(Uri.parse("http://127.0.0.1:5000/login"),
        body: {'email': email, 'password': password});
    GET.Get.find<AuthController>().isLoggingIn.value=false;
    if (response.statusCode == 200) {
      // print("we are here");
      // print(response.headers);
      return response;
    } else {
      // print("91-api.dart ${response.body}");
      return response;

      throw Exception("Error recieving data");
    }
  }

  static Future signUpUser(String name, String phoneNumber, String email, String password) async {
    GET.Get.find<AuthController>().isSigningUp.value=true;
    Response response = await post(Uri.parse("http://127.0.0.1:5000/signup"),
        body: {'name':name,'phone_number':phoneNumber,'email': email, 'password': password});
    GET.Get.find<AuthController>().isSigningUp.value=false;
    if (response.statusCode == 200) {
      // print("we are here");
      // print(response.headers);
      return response;
    } else {
      // print("91-api.dart ${response.body}");
      return response;

      throw Exception("Error recieving data");
    }
  }

  static Future getData() async {
    Response response = await get(Uri.parse('http://127.0.0.1:5000/user'),
        headers: {
          'X-CSRFToken': json.decode(window.localStorage["csrf"])['csrf']
        });
    if (response.statusCode == 200) {
      // print("response body is here${response.body}");
      return response.body;
    } else {
      // print("103-api.dart ${response.body}");
      throw Exception(response.body);
    }
  }

  static Future validate() async {
    var csrfTokenOrEmpty = window.localStorage.containsKey("csrf")
        ? window.localStorage["csrf"]
        : "";
    // print("107-api.dart $csrfTokenOrEmpty");

    // print("123podo.dart ");
    if (csrfTokenOrEmpty != "") {
      Response response = await post(Uri.parse('http://127.0.0.1:5000/validate'),
          headers: {
            'X-CSRFToken': json.decode(window.localStorage["csrf"])['csrf']
          },
          body: {});

      if (response.statusCode == 200) {
        // print("response body is here${response.body}");
        // print("128 api.dart- ${response.body}");
        return json.decode(response.body);
      } else {
        // print("115-api.dart ${response.body}");
        window.localStorage["csrf"]="";
        return {'validToken':'error'};
      }
    }else
    {
      return {'validToken':'false'};
    }


  }

  static Future book({String time,String id,String parkingStatus=""}) async
  {
    if(parkingStatus!="")
    {
      Response response = await post(Uri.parse("http://127.0.0.1:5000/book"),headers: {
        'X-CSRFToken': json.decode(window.localStorage["csrf"])['csrf']
      },body: {'parking_status':parkingStatus});
      // print("150-api.dart ${response.body}");
      return response;
    }
    else
    {
      Response response = await post(Uri.parse("http://127.0.0.1:5000/book"),headers: {
        'X-CSRFToken': json.decode(window.localStorage["csrf"])['csrf']
      },body: {'estimated_start_time':time,'street_id':id});
      return response;
    }



  }
  static Future logout() async
  {
    Response response = await get(Uri.parse("http://127.0.0.1:5000/logout"));
    if(response.statusCode==200)
    {
      window.localStorage.remove('csrf');
      return json.decode(response.body);
    }
  }
  static Future submitSurvey(String answer1,String answer2,String answer3,{String review}) async
  {
    Response response = await post(Uri.parse("http://127.0.0.1:5000/survey"),headers: {
      'X-CSRFToken': json.decode(window.localStorage["csrf"])['csrf']
    },body: {
      'answer1':answer1,
      'answer2':answer2,
      'answer3':answer3,
      'review':review
    });
    return response;
  }
}
