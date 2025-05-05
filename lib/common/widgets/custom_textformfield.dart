import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType input;
  final String? hintText;
  final String? helperText;
  final String? prefixText;
  final bool obscureText;
  final Widget? suffixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final bool readOnly;
  final bool enabled;
  final Color prefixColor;

  const CustomTextFormField({
    super.key,
    required this.labelText,
    required this.controller,
    this.input = TextInputType.text,
    this.hintText,
    this.helperText,
    this.prefixText,
    this.obscureText = false,
    this.suffixIcon,
    this.inputFormatters,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.enabled = true,
    this.prefixColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          readOnly: readOnly,
          validator: validator,
          controller: controller,
          keyboardType: input,
          inputFormatters: inputFormatters,
          obscureText: obscureText,
          onChanged: onChanged,
          decoration: InputDecoration(
            enabled: enabled,
            labelText: labelText,
            border: const OutlineInputBorder(),
            hintText: hintText,
            helperText: helperText,
            hintStyle: const TextStyle(color: Colors.grey),
            prefixIcon: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                prefixText ?? '',
                style: TextStyle(color: prefixColor, fontSize: 16),
              ),
            ),
            suffixIcon: suffixIcon,
            prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          ),
        ),
      ],
    );
  }
}
