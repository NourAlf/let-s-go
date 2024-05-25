import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:letsgohome/component/healthcontainer.dart';
import 'package:shared_preferences/shared_preferences.dart';
class HeathStatus extends StatefulWidget {
  String? std_id ;
   HeathStatus({Key? key , this.std_id}) : super(key: key);

  @override
  State<HeathStatus> createState() => _HeathStatusState();
}

class _HeathStatusState extends State<HeathStatus> {
  double? studentTemperature;
  int? studentHeartRate;
  int? height;
  int? weight;
  int ? age ;
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    print(widget.std_id);
    final Future<SharedPreferences> prefs0 = SharedPreferences.getInstance();
    final SharedPreferences prefs = await prefs0;
    String token = prefs.getString('token')!;
    http.Response response = await http.post(
        Uri.parse('https://present-ksa.com/api/studentinfo' ,  ) ,body: {
            "id": widget.std_id,
        } ,   headers: <String, String>{
      // 'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    }, );
    print(response.statusCode);
    if (response.statusCode == 302) {
      // Get the redirected URL
      String redirectUrl = response.headers['location'] ?? '';
      // Retry the request with the new URL
      response = await http.post(
        Uri.parse("https://present-ksa.com/api/addstudent"),
        headers: <String, String>{
          // 'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: {
        "id": widget.std_id,
      } ,
      );
      print("jnjnjnj $redirectUrl ${response.body}");
    }
    if (response.statusCode == 200) {
print(response.body);
      final data1 = jsonDecode(response.body);
      final data = data1['info'];
      setState(() {
        studentTemperature = double.parse(data['student_temp'] ?? "0.0");
        studentHeartRate = int.parse(data['student_heart']?? "0");
        height= data['height'];
        weight=data['weight'];
        DateTime birthdate = DateTime.parse(data['birthdate']);
        age = DateTime.now().year - birthdate.year;
        print("5555555 --- $studentTemperature $studentHeartRate $height $weight");
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  height == null ? const Center(child: SizedBox( height: 50 , child: CircularProgressIndicator())) :Column(
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
              // Positioned(
              //   top: 30,
              //   left: 20,
              //   // child: IconButton(
              //   //
              //   //   icon: const Icon(Icons.arrow_back),
              //   // ),
              // ),
              const Positioned(
                top: 40,
                left: 50,
                right: 50,
                child: Center(
                  child: Text(
                    "Health Status",
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
                  child: Center(
                    child: IconButton(
                      onPressed: () {
                        // Navigator.of(context).push(
                        // MaterialPageRoute(builder: (context) => HomePage()),
                        // );
                      },
                      icon: const Icon(
                        Icons.add_alert,
                        size: 23,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child:
           Column(
              children: [
                Expanded(
                  child: GridView.count(
                      crossAxisCount: 2,
                      padding: const EdgeInsets.all(20),
                      children: [
                        HealthContainer(toptext: "Heart Beats",
                      image: 'beats.png', numb: studentHeartRate ?? 0),
                        HealthContainer(
                      toptext: "Height", image: 'height.png', numb: height?? 0),
                  // Assuming student's temperature is displayed in Celsius
                  // You can adjust the unit as needed
                        HealthContainer(toptext: "Temperature",
                    image: 'temp.png',
                    numb: studentTemperature?.round() ?? 0,),
                        HealthContainer(toptext: "Age", image: 'age.png', numb: age?? 0),
                    ],
                  ),
                ),
                const SizedBox(height: 30,),
                Container(
                  height: 300,
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 44,
                        width: 211,
                        decoration: const BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Color(0xffE2D4B0),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.file_copy_outlined),
                            Text(
                              "Student's health file",
                              style: TextStyle(
                                fontSize: 18,
                                color: Color(0xff1C680F),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (studentTemperature != null &&
                          studentHeartRate != null)
                        Text(
                          'Temperature: $studentTemperature °C\nHeart Rate: $studentHeartRate bpm',
                          style: const TextStyle(fontSize: 16),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class HealthContainer extends StatelessWidget {
//   final String toptext;
//   final String image;
//   final int numb;
//
//   HealthContainer({
//     required this.toptext,
//     required this.image,
//     required this.numb,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(10),
//       margin: EdgeInsets.all(10),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(15),
//         border: Border.all(
//           color: Colors.black,
//           width: 1,
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Image.asset(
//             'assets/$image',
//             height: 70,
//             width: 70,
//           ),
//           SizedBox(height: 10),
//           Text(
//             toptext,
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 16,
//             ),
//           ),
//           SizedBox(height: 5),
//           Text(
//             '$numb',
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
