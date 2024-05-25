import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:letsgohome/component/grid-view.dart';
import 'package:letsgohome/screens/earllycall.dart';
import 'package:letsgohome/screens/students_page.dart';
import 'package:letsgohome/screens/tracking_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import'package:http/http.dart' as http;

import 'healthStatus_page.dart';

class HomeNavigation extends StatefulWidget {
  String? std_id ;
   HomeNavigation( { Key? key , this.std_id }   ) : super(key: key);

  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  bool _isLoading = false;
  // Function to handle user input changes
  void onTimeChanged(String value) {
    setState(() {});
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
                      Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => StudentsPage()),
                      );
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
            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    child: Container(
                      margin: const EdgeInsets.only(left: 5),
                      padding: const EdgeInsets.all(10),
                      height: 44,
                      width: 211,
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Color(0xffE2D4B0),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Icon(Icons.calendar_today_outlined),
                          Text(
                            "Daily Report",
                            style: TextStyle(
                              fontSize: 18,
                              color: Color(0xff1C680F),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.all(30),
                    margin: EdgeInsets.only(left: 10, right:10),
                    width: 325,
                    height: 120,
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
                        Container(width: 125,height: 60, color: Color(0xffE2D4B0),child: Center(child:
                        Text(textAlign: TextAlign.center,"Arriving time not available Now"
                            ),),),
                        SizedBox(width: 10,),
                        Container(width: 125,height: 60, color: Color(0xffE2D4B0),child: Center(child:
                        Text(textAlign: TextAlign.center,"Arriving time not available Now"
                        ),),),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(left: 5),
                    padding: const EdgeInsets.all(10),
                    height: 44,
                    width: 211,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Color(0xffE2D4B0),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [

                        Text(
                          " Services ",
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff1C680F),
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
                CustomContainer(text: "Health Status", image: 'heart.png',onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> HeathStatus(std_id: widget.std_id)));
                  // Navigator.of(context).pushReplacementNamed('healthstatus');
                },) ,
                CustomContainer(text: 'Permission', image: 'access.png',onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EarllyCall(std_id: widget.std_id)))
    ;



                },),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   crossAxisAlignment: CrossAxisAlignment.baseline,
              children: [
                CustomContainer(text: "Tracking", image: 'SD.png',onPressed: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const TrackingPage()));},),
           CustomContainer(
             text: 'Call',
              image: 'phone.jpg',
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
