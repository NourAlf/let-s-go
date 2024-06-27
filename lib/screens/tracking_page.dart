import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:letsgohome/screens/home_nav_bar.dart';
import 'package:letsgohome/screens/settingsPage.dart';

class TrackingPage extends StatefulWidget {
  const TrackingPage({super.key});

  @override
  State<TrackingPage> createState() => _TrackingPageState();
}

class _TrackingPageState extends State<TrackingPage> {
  StreamSubscription<Position>? positionStream;
  double? latitude;
  double? longitude;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  void dispose() {
    positionStream?.cancel();
    super.dispose();
  }

  Future<void> getCurrentLocation() async {
    bool servicesEnabled;
    LocationPermission permission;
    servicesEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();

    if (servicesEnabled == false) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text("Please enable location services on your phone"),
        ),
      );
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.whileInUse) {
      positionStream = Geolocator.getPositionStream().listen(
            (Position? position) {
          setState(() {
            latitude = position!.latitude;
            longitude = position.longitude;
          });
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
                    "Tracking",
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
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Coordinates:",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Latitude: ${latitude ?? '00.000'}",
                      style: const TextStyle(fontSize: 16),
                    ),
                    Text(
                      "Longitude: ${longitude ?? '00.000'}",
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  "Google Maps will be available in future services.",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    color: Colors.grey,
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
