import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:letsgohome/utils/api_endpoints.dart';

class SchoolController extends GetxController {
  final RxString commingAlarmController = "On".obs;
  final RxString outAlarmController = "On".obs;
  final RxString levelController = "Elementary".obs;
  final RxString schoolController = "".obs;

  var selectedDays = <String>[].obs; // List of selected days
  var allDays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday']; // All days

  final List<String> commingAlarm = ['On', 'Off'];
  final List<String> outAlarm = ['On', 'Off'];
  final List<String> levelDropdownOptions = ['Elementary', 'Middle', 'High'];

  RxList schoolData = [].obs;

  Future<void> fetchSchoolData() async {
    try {
      final response = await http.get(Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.auth.getSchools));
      if (response.statusCode == 200) {
        schoolData.value = json.decode(response.body);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  void handleDropdownChangeLevel(String? value) {
    if (value != null) {
      levelController.value = value;
    }
  }

  void handleDropdownChangeComming(String? value) {
    if (value != null) {
      if(value =="On"){
      commingAlarmController.value = 'true';
      print("objectcommingAlarmController.value $commingAlarmController.value");}
      else if(value == "OFF"){
        commingAlarmController.value='false';
      }

    }
    ;
  }

  void handleDropdownChangeOut(String? value) {
    if (value != null) {
      if (value == 'On') {
        outAlarmController.value = "true";
        print("objectout gAlarmController.value $outAlarmController.value");
      } else if (value == 'OFF') {
        outAlarmController.value = 'false';
      }
    }
  }

  // bool handleDropdownChangeOut(String? value) {
  //   if (value != null) {
  //     outAlarmController.value = value;
  //     return value == 'On' ? true : false;
  //   }
  //   return false;
  // }


  @override
  void onInit() {
    super.onInit();
    //fetchSchoolData();
    schoolController.value = 'pick your school';
    levelController.value = 'Pick your level';
  }
}
