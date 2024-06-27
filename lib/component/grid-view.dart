import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomContainer extends StatefulWidget {
  final String? text;
  final String? image;
  final VoidCallback onPressed;
  final IconData? icon;

  const CustomContainer({
    Key? key,
    required this.text,
    required this.image,
    required this.onPressed,
    this.icon,
  }) : super(key: key);

  @override
  _CustomContainerState createState() => _CustomContainerState();
}

class _CustomContainerState extends State<CustomContainer> {
  @override
  Widget build(BuildContext context) {
    // Debugging log
    print('Loading asset: assets/${widget.image}');

    return GestureDetector(
      onTap: widget.onPressed,
      child: Container(
        margin: const EdgeInsets.all(15),
        width: 140,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/${widget.image}',
              width: 50,
              height: 50,
            ),
            const SizedBox(height: 10),
            Text(
              "${widget.text}",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
