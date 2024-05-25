import 'package:flutter/material.dart';

class UnreadedContainer extends StatefulWidget {
  const UnreadedContainer({Key? key}) : super(key: key);

  @override
  State<UnreadedContainer> createState() => _UnreadedContainerState();
}

class _UnreadedContainerState extends State<UnreadedContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 85,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffE2D4B0),
              ),
              child: Image.asset("assets/bell.png"),
            ),
          ),
          const ListTile(
            title: Text(
              "My School",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: Color(0xff1C680F),
              ),
            ),
          ),
        ],
      ),
    );
  }
}