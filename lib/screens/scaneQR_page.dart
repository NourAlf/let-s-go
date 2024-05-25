import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:http/http.dart' as http;
import 'package:letsgohome/screens/newstudent_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanQR extends StatefulWidget {
  const ScanQR({Key? key}) : super(key: key);

  @override
  State<ScanQR> createState() => _ScanQRState();
}

class _ScanQRState extends State<ScanQR> {
  String _scanResult = "";
  bool _isScanning = false;

  Future<void> scanCode() async {
    try {
      String qr = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR,
      );

      if (qr.isEmpty) {
        // User canceled the scan
        return;
      }

      setState(() {
        _scanResult = qr;
        _isScanning = false;
      });
      print('Scan Result: $_scanResult'); // Add this print statement

      checkStudentCode(_scanResult);
    } on PlatformException catch (e) {
      // Handle platform exceptions (e.g., permission denied)
      print("Platform Exception: ${e.message}");
    }
  }


  Future<void> checkStudentCode(String _scanResult) async {

    try {
      print("cQQQQQQQQ $_scanResult");
      final String apiUrl = '$_scanResult';
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{

          'Authorization': 'Bearer $token',
        },
      );
      print('respoooonse ${response.body} ${response.statusCode}');

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final result = responseData['result'];

        if (result == true) {
          final studentCode = responseData['student_code'];
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Student Found'),
                content: Text('You want add this child ?? '),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> AddStudentPage(studentCode: studentCode,)));
                    },
                    child: const Text('OK'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                ],
              );
            },
          );
        } else {
          final message = responseData['result'];
          showErrorDialog(message );
        }
      } else if (response.statusCode == 500) {
        final responseData = json.decode(response.body);
        final message = responseData['result'];
        showErrorDialog(message);
      } else {
        showErrorDialog('Unknown error occurred');
      }
    } on SocketException catch (e) {
      print("Socket Exception: ${e.message}");
      showErrorDialog('No internet connection');
    } catch (e) {
      // Handle other exceptions
      print("Exception: $e");
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 300,
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color(0xFF5C955D),
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
                ),
              ),
              Positioned(
                top: 80,
                left: 20,
                child: GestureDetector(
                  onTap: () {
                    if (!_isScanning) {
                      setState(() {
                        _isScanning = true;
                      });
                      scanCode();
                    }
                  },
                  child: const Icon(
                    Icons.qr_code,
                    size: 45,
                  ),
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Image.asset('assets/logo.png',fit: BoxFit.contain ,),
                  // Add your content for the small container here
                ),
              ),
              const Positioned(
                top: 130,
                left: 27,
                child: Text(
                  "Scan the QR code",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const Positioned(
                top: 170,
                left: 27,
                child: Text(
                  "You can add a student after scanning the QR \n code on the fences ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 40),
          Center(
            child: Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(24)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _isScanning
                      ? const CircularProgressIndicator()
                      :   GestureDetector(
    onTap: () {
    if (!_isScanning) {
    setState(() {
    _isScanning = true;
    });
    scanCode();
    }
    },
    child: const Icon(
    Icons.qr_code,
    size: 80,
    ),
    ),

                  const SizedBox(height: 16),

                  Text(
                    _scanResult.isNotEmpty ? "Scanned QR Code" : "press icon  to \n Scan the QR",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
