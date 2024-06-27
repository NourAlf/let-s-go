import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({Key? key}) : super(key: key);
  static const route = "/notification-screen";

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  Future<void> fetchNotifications() async {
    const String apiUrl = 'https://present-ksa.com/api/getnotifications';
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    String token = prefs.getString('token')!;

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );
      print("Resssssssponse ${response.body}");
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          notifications = data.cast<Map<String, dynamic>>();
        });
      } else {
        throw Exception('Failed to fetch notifications');
      }
    } catch (e) {
      print('Error fetching notifications: $e');
    }
  }

  void deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final message = ModalRoute.of(context)!.settings.arguments as String?;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.height*0.15,
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
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back,color: Colors.white,),
                ),
              ),
              const Positioned(
                top: 40,
                left: 50,
                right: 50,
                child: Center(
                  child: Text(
                    "Notification",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 30,
                right: 20,
                child: Container(
                  width: 35,
                  height: 35,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Image.asset('assets/logo.png',fit: BoxFit.contain ,),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10),
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                notification['title'] ?? '',
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Color(0xff1C680F),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                notification['body'] ?? '',
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          deleteNotification(index);
                        },
                        icon: const Icon(
                          Icons.delete,
                          size: 30,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
