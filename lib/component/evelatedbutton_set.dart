import 'package:flutter/material.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const ElevatedButtonWidget({Key? key, required this.icon, required this.text, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 10,bottom:20 ),
      width: 300,
      height: 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          side: MaterialStateProperty.all<BorderSide>(
            const BorderSide(color: Colors.grey, width: 2.0),
          ),
          overlayColor: MaterialStateProperty.all<Color>(Colors.black54),
          foregroundColor: MaterialStateProperty.all<Color>(Colors.black),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Icon(icon,color: const Color(0xFF5C955D)),
              ),
              const SizedBox(width: 18.0),
              Text(
                text,
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}