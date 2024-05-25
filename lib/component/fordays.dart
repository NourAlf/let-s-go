import 'package:flutter/material.dart';
class CustomTextFieldDropDays extends StatefulWidget {
  final IconData prefixIcon;
  final String labelText;
  final Function(List<String>?) onChanged;
  final List<Map<String, String>> options;

  const CustomTextFieldDropDays({super.key, 
    required this.prefixIcon,
    required this.labelText,
    required this.onChanged,
    required this.options,
  });

  @override
  _CustomTextFieldDropDaysState createState() => _CustomTextFieldDropDaysState();
}

class _CustomTextFieldDropDaysState extends State<CustomTextFieldDropDays> {
  final List<String> _selectedValues = [];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      icon: Icon(widget.prefixIcon),
      decoration: InputDecoration(
        labelText: widget.labelText,
        border: const OutlineInputBorder(),
      ),
      value: _selectedValues.isNotEmpty ? _selectedValues.first : null,
      onChanged: (newValue) {
        setState(() {
          if (_selectedValues.contains(newValue)) {
            _selectedValues.remove(newValue);
          } else {
            _selectedValues.add(newValue!);
          }
          widget.onChanged(_selectedValues);
        });
      },
      items: widget.options.map<DropdownMenuItem<String>>((option) {
        return DropdownMenuItem<String>(
          value: option['id'],
          child: Text(option['name']!),
        );
      }).toList(),
      isExpanded: true,
      isDense: true,
      hint: Text('Select ${widget.labelText}'),
      selectedItemBuilder: (BuildContext context) {
        return widget.options.map<Widget>((option) {
          return Text(option['name']!);
        }).toList();
      },
    );
  }
}