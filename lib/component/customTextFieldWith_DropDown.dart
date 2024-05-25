import 'package:flutter/material.dart';
import 'package:letsgohome/controller/schoolController.dart';
class CustomDropdownButton extends StatelessWidget {
  final List<Map<String , String>> items;
  final String? selectedItemId;
  final ValueChanged<String?> onChanged;
  final String hintText;

  CustomDropdownButton({
    required this.items,
    required this.selectedItemId,
    required this.onChanged,
    this.hintText = 'Select an School',
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      hint: Text(hintText),
      value: selectedItemId,
      onChanged: onChanged,
      items: items.map((Map<String, String> item) {
        return DropdownMenuItem<String>(
          value: item["id"],
          child: Text(item["name"]!),
        );
      }).toList(),
    );
  }
}
class CustomTextFieldDrop1 extends StatelessWidget {
  final IconData prefixIcon;
  final String labelText;
  final List<Map<String, dynamic>> options;
  final String? selectedOption;
  final ValueChanged<String?>? onChanged;
final SchoolController controller ;



  const CustomTextFieldDrop1({super.key,
    required this.prefixIcon,
    required this.labelText,
    required this.options,
    this.onChanged,
    this.selectedOption,
    required this.controller


  });

  @override
  Widget build(BuildContext context) {
    // List<String> selectedValues = [];
    return Container(
      width: 250,
      height: 60,
      //margin: const EdgeInsets.only(top:8),
      child: DropdownButtonFormField<String>(
        value: controller.levelController.value,
        onChanged:(value) {
          controller.handleDropdownChangeLevel(value);
        } ,
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
        ),
        items: [
          if (selectedOption != null && !options.any((option) => option['id'] == selectedOption))
            DropdownMenuItem<String>(
              value: selectedOption,
              child: Text(selectedOption!),
            ),
          ...options.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value['id'].toString(),
              child: Text(value['name']),
            );
          }),
        ],

      ),
    );
  }
}
class CustomTextFieldDrop2 extends StatelessWidget {
  final IconData prefixIcon;
  final String labelText;
  final List<Map<String, dynamic>> options;
  final String? selectedOption;
  final ValueChanged<String?>? onChanged;
  final SchoolController controller ;



  const CustomTextFieldDrop2({super.key,
    required this.prefixIcon,
    required this.labelText,
    required this.options,
    this.onChanged,
    this.selectedOption,
    required this.controller


  });

  @override
  Widget build(BuildContext context) {
    // List<String> selectedValues = [];
    return Container(

      width: 250,
      height: 60,
      margin: const EdgeInsets.only(bottom: 8),
      child: DropdownButtonFormField<String>(
        value: controller.commingAlarmController.value,
        onChanged:(value) {
          controller.handleDropdownChangeComming;
        } ,
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
        ),
        items: [
          if (selectedOption != null && !options.any((option) => option['id'] == selectedOption))
            DropdownMenuItem<String>(
              value: selectedOption,
              child: Text(selectedOption!),
            ),
          ...options.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value['id'].toString(),
              child: Text(value['name']),
            );
          }),
        ],

      ),
    );
  }
}
class CustomTextFieldDrop3 extends StatelessWidget {
  final IconData prefixIcon;
  final String labelText;
  final List<Map<String, dynamic>> options;
  final String? selectedOption;
  final ValueChanged<String?>? onChanged;
  final SchoolController controller ;



  const CustomTextFieldDrop3({super.key,
    required this.prefixIcon,
    required this.labelText,
    required this.options,
    this.onChanged,
    this.selectedOption,
    required this.controller


  });

  @override
  Widget build(BuildContext context) {
    // List<String> selectedValues = [];
    return Container(
      width: 250,
      height: 90,
     // margin: const EdgeInsets.only(top:8),
      child: DropdownButtonFormField<String>(
        value: controller.outAlarmController.value,
        onChanged:(value) {
          controller.handleDropdownChangeOut;
        } ,
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
        ),
        items: [
          if (selectedOption != null && !options.any((option) => option['id'] == selectedOption))
            DropdownMenuItem<String>(
              value: selectedOption,
              child: Text(selectedOption!),
            ),
          ...options.map<DropdownMenuItem<String>>((value) {
            return DropdownMenuItem<String>(
              value: value['id'].toString(),
              child: Text(value['name']),
            );
          }),
        ],

      ),
    );
  }
}
class CustomTextFieldDrop extends StatelessWidget {
  final IconData prefixIcon;
  final String labelText;
  final List<Map<String, dynamic>> options;
  final String? selectedOption;
  final ValueChanged<String?>? onChanged;




  const CustomTextFieldDrop({super.key,
    required this.prefixIcon,
    required this.labelText,
    required this.options,
     this.onChanged,
    this.selectedOption,


  });

  @override
  Widget build(BuildContext context) {
    List<String> selectedValues = [];
    return Container(
      width: 250,
      height: 90,
      margin: const EdgeInsets.only(top:8),
      child: DropdownButtonFormField<String>(
        // value: selectedOption,
        onChanged:(value) {
          onChanged!(value);
        } ,
        decoration: InputDecoration(
          prefixIcon: Icon(prefixIcon, color: Colors.black),
          labelText: labelText,
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
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
        ),
        items: options.map<DropdownMenuItem<String>>((Map<String, dynamic> value) {
          return DropdownMenuItem<String>(
            value: value['id'].toString(),
            child: Text(value['name']),
          );
        }).toList(),

      ),
    );
  }
}
