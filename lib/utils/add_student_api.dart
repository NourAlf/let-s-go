import 'dart:convert';

import 'package:letsgohome/utils/api_endpoints.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/add_student.dart';

class AddStudentPost {
  Future<dynamic> addStudent(AddStudentModel newStudent) async {
    Map<String, dynamic> jsonPayload = newStudent.toJson();

    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
String token = prefs.getString('token')!;
    print("jsonPayload $jsonPayload --- $token");


        var headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        };
        var url = Uri.parse(ApiEndPoints.baseUrl + ApiEndPoints.auth.addStudent);


        // Map<String, dynamic> body = jsonPayload;

        http.Response response = await http.post(url, body: jsonPayload, headers: headers);

        print(" respppppponse = ${response.body}");
        if (response.statusCode == 200) {
          final json = jsonDecode(response.body);


          //  emailController.clear();
          // passwordController.clear();


        }else{
          throw jsonDecode(response.body)['message'] ?? "unknown erroeOccured";
        }

    }


}