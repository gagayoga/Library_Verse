import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextFormField extends StatelessWidget {
  final controller;
  final bool obsureText;
  final Widget? surficeIcon;
  final String? label;
  final FormFieldValidator<String>? validator;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.obsureText,
    this.surficeIcon,
    this.validator,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.w600,
        fontSize: 16,
        color: Colors.black
      ),
      controller: controller,
      autocorrect: true,
      validator: validator,
      obscureText: obsureText,
      decoration: InputDecoration(
          filled: true,
          fillColor: const Color(0xFFB6B3B3)
              .withOpacity(0.4),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                color: Colors.red,
                width: 2.0),
            borderRadius:
            BorderRadius.circular(
                15.15),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                  color: Colors.red,
                  width: 2.0),
              borderRadius:
              BorderRadius.circular(
                  15.15)),
          hintText: 'Masukan $label',
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          hintStyle: const TextStyle(
              fontFamily: 'Poppins',
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.deepOrange),
          suffixIcon: surficeIcon,
    ));
  }
}
