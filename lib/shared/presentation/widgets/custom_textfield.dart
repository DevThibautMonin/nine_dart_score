import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextCapitalization textCapitalization;
  final TextInputType keyboardType;
  final TextInputAction textInputAction;
  final Function(String)? onChanged;
  final bool isMandatory;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    this.textCapitalization = TextCapitalization.sentences,
    this.textInputAction = TextInputAction.next,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.isMandatory = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onChanged: onChanged,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: isMandatory ? "$labelText*" : labelText,
      ),
      textCapitalization: textCapitalization,
    );
  }
}
