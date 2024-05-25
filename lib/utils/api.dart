import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<dynamic> get({ required String url ,  String? token}) async {
    Map<String ,String > headers ={};
    if(token != null){
      headers.addAll({'Authorization': 'Bearer $token'});

    }
    http.Response response =await http.get(Uri.parse(url),headers: headers);
    if(response.statusCode == 200){
      return jsonDecode(response.body);

    }else {
      throw Exception('there is  a problem with status code ${response.statusCode}');
    }
  }

  Future<dynamic> post({required String url ,@required dynamic body , @required String? token})async{
    Map<String ,String > headers ={};
    if(token != null){
      headers.addAll({'Authorization': 'Bearer $token'});

    }
    http.Response response =await http.post(Uri.parse(url),headers: headers , body:  body);
    print("my body $body");
    if(response.statusCode == 200){
      Map<String , dynamic> data =jsonDecode(response.body);
      return data;

    }else if (response.statusCode == 302) {
      // Get the redirected URL
      String redirectUrl = response.headers['location'] ?? '';
      // Retry the request with the new URL
      response = await http.post(
        Uri.parse("https://present-ksa.com/api/addstudent"),
        headers: <String, String>{
          // 'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: body,
      );
      print("jnjnjnj $redirectUrl ${response.body}");
    }else {
      throw Exception('there is  a problem with status code ${response.statusCode} with body ${jsonDecode(response.body)}');
    }
  }

}