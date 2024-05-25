import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final IconData prefixIcon;
  final String labelText;
  final TextEditingController controller;
  final Function? onTap;
  final TextInputType? keyboardType;
  final List? inputFormatters;
  final  validator; // Add validator function parameter


  const CustomTextField({
    Key? key,
    required this.prefixIcon,
    required this.labelText,
    required this.controller,
    this.onTap,
    @required this.keyboardType,
    @required this.inputFormatters,
    @required this.validator, // Add validator function parameter
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      height: 60,
      margin: const EdgeInsets.only(top: 8),
      child: TextFormField(
        controller: controller,
        validator: validator, // Pass the validator function
        keyboardType: keyboardType,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: Colors.black),
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: const BorderSide(color: Colors.grey, width: 2.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.black54, width: 2.0),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(color: Colors.red, width: 2.0),
          ),
          errorStyle: const TextStyle(color: Colors.black54),
          errorMaxLines: 2,
          // contentPadding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        ),
      ),
    );
  }
}
