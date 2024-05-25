import 'package:flutter/material.dart';

class CustomContainer extends StatefulWidget {
  final String? text;
  final String? image;
  final VoidCallback onPressed;
  final IconData? icon;

  const CustomContainer({
    Key? key,
    required this.text,
    @required this.image,
    required this.onPressed,
    @required this.icon,
  }) : super(key: key);

  @override
  _CustomContainerState createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.all(15),
        width: 140,
        height: 100,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(30)),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/${widget.image}',width: 34,
            ),
           // Icon(widget.icon,size: 20,),
            const SizedBox(height: 10),
            Text("${widget.text}"),
           // استخدام قيمة الايقونة الممررة من الأعلى
          ],
        ),
      ),
    );
  }
}
