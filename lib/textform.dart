import 'package:flutter/material.dart';

class TextFormConst extends StatelessWidget {
  const TextFormConst({
    super.key,
    required this.hintText,
    required this.controller,
    this.onChanged,
    required TextInputType keyboardType,
    InputDecoration? decoration,
    this.validator,
  });
  final String hintText;
  final TextEditingController controller;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
