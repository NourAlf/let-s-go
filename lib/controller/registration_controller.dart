import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:letsgohome/screens/login_page.dart';
import 'package:letsgohome/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RegistrationController extends GetxController {
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> registerWithEmail() async {
    try {
      var headers = {
        'Accept': 'application/json',
      };
      var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.auth.registrationwithEmail);

      if (fullNameController.text.isEmpty ||
          emailController.text.isEmpty ||
          phoneController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        // Display error or show validation message to the user
        return;
      }

      Map<String, String> body = {
        'role': 'parent',
        'name': fullNameController.text.trim(),
        'email': emailController.text.trim(),
        'phone': phoneController.text.trim(),
        'password': passwordController.text.trim(),
        'password_confirmation': confirmPasswordController.text.trim(),
      };

      http.Response response = await http.post(url, body: body, headers: headers);
      print('''
      $url
      'name': ${fullNameController.text.trim()},
          'email': ${emailController.text.trim()},
    'phone': ${phoneController.text.trim()},
    'password': ${passwordController.text.trim()},
    'password_confirmation': ${confirmPasswordController.text.trim()},
          }
      ''');
      print(" respppppponse = ${response.body}");
      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);

        if (json['status'] == true) {
          var token = json['token'];
          var id = json['id'];
          var name = fullNameController.text; // Retrieve name from the form
          print(token);
          final SharedPreferences prefs = await _prefs;
          await prefs.setString('token', token);
          await prefs.setString('Parent_id', id.toString());
          await prefs.setString('name', name); // Store the name in SharedPreferences

        }

        fullNameController.clear();
        emailController.clear();
        passwordController.clear();
        confirmPasswordController.clear();
        phoneController.clear();
        Get.to( LoginPage());
      } else {
        throw jsonDecode(response.body)['message'] ?? "unknown error occurred";
      }
    } catch (e) {
      Get.back();
      showDialog(
        context: Get.context!,
        builder: (context) {
          return SimpleDialog(
            title: const Text("error"),
            contentPadding: const EdgeInsets.all(20),
            children: [Text(e.toString())],
          );
        },
      );
    }
  }
}
