import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
  String noChildrenMessage = '';
  String parentIdMessage = '';

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
  }

  Future<void> fetchChildrenData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? parentId = prefs.getString('Parent_id');

    if (parentId != null) {
      setState(() {
        isLoading = true;
      });

      final List<AddStudentModel> fetchedChildren = await getChildren(parentId);

      setState(() {
        children = fetchedChildren;
        isLoading = false;
        noChildrenMessage = children.isEmpty
            ? 'You do not have any children in the schools.'
            : '';
      });
    } else {
      setState(() {
        parentIdMessage = 'Failed to retrieve parent ID.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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
             child: const Center(
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
          const SizedBox(height: 30),
          // const Text(
          //   "You can choose the student ",
          //   style: TextStyle(
          //     fontSize: 14,
          //     color: Color(0xFF5C955D),
          //   ),
          // ),
          Container(
            width: 250,
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFF5C955D),
              borderRadius: const BorderRadius.all(Radius.circular(8)),
              border: Border.all(
                color: Colors.white,
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
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.0,vertical: 8),
                child: Text(
                "List of Students",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color:  Color(0xFF5C955D),
                ),),
              ),
            ]
          ),
          Text(
            noChildrenMessage.isNotEmpty ? noChildrenMessage : parentIdMessage,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
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
                          builder: (context) => StudentInfo(
                            std_id: children[index].id!,
                          )));
                    },
                    style: OutlinedButton.styleFrom(
                      foregroundColor:const   Color(0xFFD3D3D3),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.person,color: Color(0xFF5C955D),),
                      title: Text(children[index].name ?? "",style: const TextStyle(fontSize: 18,color: Colors.black),),
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


