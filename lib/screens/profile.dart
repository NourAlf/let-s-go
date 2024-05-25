import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:letsgohome/component/evelatedbutton_set.dart';
import 'package:letsgohome/screens/homepage.dart';
import 'package:letsgohome/screens/register_page.dart';
import 'package:letsgohome/screens/settingsPage.dart';
import 'package:letsgohome/screens/students_page.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String parentName = "ParentPage"; // Default value for parent's name

  @override
  void initState() {
    super.initState();
    fetchParentName(); // Fetch parent's name when the profile page is initialized
  }

  Future<void> fetchParentName() async {
    final SharedPreferences prefs = await _prefs;
    final String? token = prefs.getString('token'); // Retrieve the token from SharedPreferences

    if (token != null) {
      final response = await http.post(
        Uri.parse('https://present-ksa.com/api/user_name'),
        headers: {'Authorization': 'Bearer $token'}, // Include the token in the headers
      );
print("response.code ${response.statusCode}");
      if (response.statusCode == 200) {
        print("""response.body ${response.body}""");
        Map<String, dynamic> responseData = jsonDecode(response.body);
        String userName = responseData['user_name'];
        // Extract the user name from the response
        setState(() {
          parentName = userName; // Set the parent's name to the variable
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 129,
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
                top: 30,
                left: 20,
                child: IconButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (context) => const SettingsPage()));
                  },
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              const Positioned(
                top: 40,
                left: 50,
                right: 50,
                child: Center(
                  child: Text(
                    "Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),

            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: ListTile(
              leading: CircleAvatar(
                radius: 50,
                child: Image.asset(
                  'assets/student.png',
                  fit: BoxFit.cover,
                ),
              ),
              title: Text(
                parentName, // Display parent's name
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              subtitle: const Text(
                "My Profile",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButtonWidget(
            image: 'modify.png',
            text: "Edit Information",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const RegisterPage()));
            },
          ),
          ElevatedButtonWidget(
            image: 'student.png',
            text: "My Children",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => const StudentsPage()));
            },
          ),
          ElevatedButtonWidget(
            image: 'logout.png',
            text: "Logout",
            onPressed: () async {
              final SharedPreferences prefs = await _prefs;
              prefs.clear();
              Get.offAll(() => const HomePage());
            },
          ),
        ],
      ),
    );
  }
}
