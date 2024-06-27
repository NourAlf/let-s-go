
import 'package:flutter/material.dart';
import 'package:letsgohome/component/evelatedbutton_set.dart';
import 'package:letsgohome/screens/notification_page.dart';
import 'package:letsgohome/screens/tracking_page.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String? selectedLanguage;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        //mainAxisAlignment: MainAxisAlignment.center,
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
              // Positioned(
              //   top: 30,
              //   left: 20,
              //   child: IconButton(
              //     onPressed: () {
              //       Navigator.of(context).push(
              //         MaterialPageRoute(builder: (context) => StudentsPage()),
              //       );
              //     },
              //     icon: const Icon(Icons.arrow_back,color: Colors.white,),
              //   ),
              // ),
              const Positioned(
                top: 40,
                left: 50,
                right: 50,
                child: Center(
                  child: Text(
                    "Settings",
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
          const SizedBox(
            height: 20,
          ),
          // Container(
          //   margin: const EdgeInsets.only(left: 20),
          //   padding: const EdgeInsets.all(10),
          //   height: 44,
          //   width: 211,
          //   decoration: const BoxDecoration(
          //     shape: BoxShape.rectangle,
          //     color: Color(0xffE2D4B0),
          //   ),
          //   child: const Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceAround,
          //     children: [
          //       Icon(Icons.settings),
          //       Text(
          //         "Settings",
          //         style: TextStyle(
          //           fontSize: 18,
          //           color: Color(0xff1C680F),
          //           fontWeight: FontWeight.bold,
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButtonWidget(
            icon: Icons.notifications,
            text: "Notification",
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const NotificationPage()));
            },
          ),
          ElevatedButtonWidget(
            icon: Icons.edit,
            text: "update Student info",
            onPressed: () {
              //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=> co()));
            },
          ),
          //ElevatedButtonWidget(image: 'addstudent.png', text: "Add New Student",),
          ElevatedButtonWidget(
            icon: Icons.language,
            text: "Language",
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select Language'),
                      content: DropdownButton<String>(
                        value: selectedLanguage,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedLanguage = newValue;
                          });
                        },
                        items: <String>['Arabic', 'English']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: const Text('OK'),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    );
                  });
            },
          ),

          //   ElevatedButtonWidget(image: 'modify.png', text: "Edit information",onPressed: (){},),
          ElevatedButtonWidget(
            icon: Icons.location_on_outlined,
            text: "Location",
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => TrackingPage()));
            },
          ),
          ElevatedButtonWidget(
            icon: Icons.info,
            text: "About",
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text("About"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                            "This is a program about..."), // Add your program description here
                        const SizedBox(height: 16),
                        const Text("Features:"),
                        ListTile(
                          leading: const Icon(Icons.check),
                          title: const Text("Call child"),
                          onTap: () {
                            // Handle calling child functionality
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.check),
                          title: const Text("Request early leave"),
                          onTap: () {
                            // Handle requesting early leave functionality
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.check),
                          title: const Text("Add child to the app"),
                          onTap: () {
                            // Handle adding child to the app functionality
                          },
                        ),
                        ListTile(
                          leading: const Icon(Icons.check),
                          title: const Text("Track child"),
                          onTap: () {
                            // Handle child tracking functionality
                          },
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text("Close"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
