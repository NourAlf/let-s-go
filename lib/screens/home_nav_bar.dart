import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:letsgohome/component/grid-view.dart';
import 'package:letsgohome/screens/earllycall.dart';
import 'package:letsgohome/screens/students_page.dart';
import 'package:letsgohome/screens/tracking_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import'package:http/http.dart' as http;

import 'healthStatus_page.dart';

class StudentInfo extends StatefulWidget {
  String? std_id ;
   StudentInfo( { Key? key , this.std_id }   ) : super(key: key);

  @override
  _StudentInfoState createState() => _StudentInfoState();
}

class _StudentInfoState extends State<StudentInfo> {
  bool _isLoading = false;
  String? _commingTime;
  String? _leavingTime;
  // Function to handle user input changes

  Future<void> fetchTimes(String? studentId) async {
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    var url = Uri.parse('https://present-ksa.com/api/student_action');
    String token = prefs.getString('token')!;
    var requestBody = jsonEncode({
      'student_id': studentId,
    });
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: requestBody,
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final String commingTime = jsonResponse['student_action']['comming_time'];
      final String leavingTime = jsonResponse['student_action']['leaving_time'];
      setState(() {
        _commingTime = commingTime;
        _leavingTime = leavingTime;
      });
    } else {
      throw Exception('Failed to load times');
    }
  }
  void callStudentAPI(BuildContext context, stdId) async {
    setState(() {
      _isLoading = true; // Set loading state to true
    });

    var url = Uri.parse('https://present-ksa.com/api/call_student');
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    String token = prefs.getString('token')!;
    print("widget sjkb      ${widget.std_id}");

    var requestBody = jsonEncode({
      'student_id': widget.std_id,
      'school_id': 17,

    });


    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: requestBody,
    );
    var arrivetime = response.body;
    print("respooonse         ${response.body}");

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Response:'),
          content: const Text("Your son/daughter has been called :)"),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            // TextButton(
            //   onPressed: () {
            //     Navigator.of(context).pop(); // Close dialog
            //   },
            //   child: Text('OK'),
            // ),
          ],
        );
      },
    ).then((_) {
      setState(() {
        _isLoading = false; // Set loading state to false after dialog is closed
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                      "Student's Info",
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
            SizedBox(height: MediaQuery.of(context).size.height*0.03,),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(left: 5),
                     // padding: const EdgeInsets.all(10),
                      height: 44,
                      width: 320,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xFFD3D3D3)

                        ,
                      ),
                      child: const Row(

                       // padding: EdgeInsets.all(10),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.calendar_today_outlined),
                          SizedBox(width: 10,),
                          Text(
                            "Daily Report",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black
                              ,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.all(30),
                    margin: EdgeInsets.only(left: 10, right:10),
                    width: 340,
                    height: 150,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Color(0xFF5C955D),
                          Color(0xFF1C680F),
                        ],
                        begin: Alignment.bottomRight,
                        end: Alignment.topCenter,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(23)),
                    ),
                    child: Row(
                      children: [
                        Container(width: 125,height: 100,  decoration: const BoxDecoration(
    borderRadius: BorderRadius.all(Radius.circular(20)),
    color: Color(0xFFD3D3D3)

    ,
    ),child: Center(child:
                        Text("Leaving time\n $_leavingTime"  ?? "Leaving time didn't leaving time",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.center,
                            ),),),
                        SizedBox(width: 10,),
                        Container(width: 125,height: 100,  decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                          color: Color(0xFFD3D3D3)

                          ,
                        ),child: Center(child:
                        Text( style: TextStyle(fontSize: 16),textAlign: TextAlign.center, "Comming time\n $_commingTime " ?? "Comming time didn't Comming yet",

                        ),),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                   // padding: const EdgeInsets.all(10),
                    height: 44,
                    width: 320,
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                        color: Color(0xFFD3D3D3)
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Text(
                          " Services ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
           //   crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [

                CustomContainer(
                  text: "Health Status",
                  image: 'h.svg',
                  onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HeathStatus(std_id: widget.std_id)));
                    // Navigator.of(context).pushReplacementNamed('healthstatus');
                  },
                  icon: null,
                ),
                CustomContainer(text: 'Permission', image: 'perm.svg',onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EarllyCall(std_id: widget.std_id)))
    ;



                }, icon: null,),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                CustomContainer( icon: null,text: "Tracking", image: 'tracking.svg',onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const TrackingPage()));},),
           CustomContainer(
             text: 'Call',
                icon: null,
              image: 'phone.svg',
              onPressed:  (){callStudentAPI(context,widget.std_id);}  , // Disable button when loading
   // Pass the loading state to the widget
    ),




              ],
            ),


          ],
        ),
      ),
    );
  }
}
