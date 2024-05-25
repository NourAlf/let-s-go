import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:letsgohome/screens/scaneQR_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/add_student.dart';
import '../utils/api_endpoints.dart';
import 'home_nav_bar.dart';

class StudentsPage extends StatefulWidget {
  const StudentsPage({Key? key}) : super(key: key);

  @override
  State<StudentsPage> createState() => _StudentsPageState();
}

class _StudentsPageState extends State<StudentsPage> {
  List<AddStudentModel> children = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchChildrenData();
  }

  Future<List<AddStudentModel>> getChildren(String parentId) async {
    final String childrenUrl =
        ApiEndPoints.baseUrl + ApiEndPoints.auth.parent_children;
    print("$childrenUrl/$parentId");

    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    String token = prefs.getString('token')!;
    print("$childrenUrl/$parentId / $token");
    try {
      final response = await http.post(Uri.parse(childrenUrl),
          headers: {'Authorization': 'Bearer $token'}, body: {'id': parentId});

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(" 65454 ${response.body} ${response.statusCode} ");
        }
        List<AddStudentModel> childrenList = [];
        Map<String, dynamic> responseData = jsonDecode(response.body);
        List<dynamic> responsChildrenData = responseData['students'];
        for (var childData in responsChildrenData) {
          AddStudentModel child = AddStudentModel.fromJson(childData);
          childrenList.add(child);
        }
        return childrenList;
      } else {
        throw Exception('Failed to fetch children');
      }
    } catch (e) {
      print('Error fetching children: $e');
      return [];
    }
  }

  Future<void> fetchChildrenData() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final String? parentId = prefs.getString('Parent_id');

      if (parentId != null) {
        setState(() {
          isLoading = true;
        });

        final List<AddStudentModel> fetchedChildren =
        await getChildren(parentId);

        setState(() {
          children = fetchedChildren;
          isLoading = false;
        });

        if (children.isEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('No Children Found'),
                content: const Text('You do not have any children in the schools.'),
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
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Parent ID Not Found'),
              content: const Text('Failed to retrieve parent ID.'),
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
    } catch (e) {
      print('Error fetching parent ID: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to retrieve parent ID: $e'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 200,
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
                top: 20,
                left: 20,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.arrow_back),
                ),
              ),
              const Positioned(
                top: 40,
                left: 50,
                right: 50,
                child: Center(
                  child: Text(
                    "Home",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              const Positioned(
                top: 130,
                left: 27,
                child: Text(
                  "Menu of Students",
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
                  "You can choose the student ",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF5C955D),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: Colors.green,
                width: 2,
              ),
            ),
            child: OutlinedButton(
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const ScanQR()));
              },
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFF5C955D),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                "Add Student",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
              itemCount: children.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(top: 10, left: 30, right: 30),
                  height: 50,
                  decoration: const BoxDecoration(
                    color: Color(0xffE0E0E0),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  ),
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => HomeNavigation(
                            std_id: children[index].id!,
                          )));
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor:const Color(0xFF5C955D),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: ListTile(
                      leading: Image.asset('assets/student.png',
                          width: 20, height: 20),
                      title: Text(children[index].name ?? " fffff"),
                    ),
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
