import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final TextInputType? keyboardType;
  final int? maxLine;
  final String? hintText;

  const CustomTextField({
    Key? key,
    this.hintText,
    required this.onChanged,
    required this.keyboardType,
    this.maxLine = 1,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      maxLines: maxLine ?? 1,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        filled: true,
        hintStyle: TextStyle(color: Colors.grey[800]),
        fillColor: Colors.white70,
      ),
    );
  }
}
