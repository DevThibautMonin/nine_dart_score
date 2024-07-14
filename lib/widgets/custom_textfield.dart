import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextCapitalization textCapitalization;
  final Function(String)? onChanged;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    this.textCapitalization = TextCapitalization.sentences,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: labelText,
      ),
      textCapitalization: textCapitalization,
    );
  }
}
