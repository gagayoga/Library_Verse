

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final Widget? preficIcon;


  const CustomSearchBar({
    super.key,
    this.preficIcon,
  });

  @override
  Widget build(BuildContext context) {

    return TextFormField(
      decoration: InputDecoration(
          filled: true,
          prefixIcon: preficIcon,
          fillColor: Color(0xFFB6B3B3).withOpacity(0.4),
          focusedBorder: OutlineInputBorder(
            borderSide:
            BorderSide(color: Colors.red, width: 5.0),
            borderRadius: BorderRadius.circular(15.15),
          ),
          enabledBorder: OutlineInputBorder(
              borderSide:
              BorderSide(color: Colors.red, width: 5.0),
              borderRadius: BorderRadius.circular(15.15)),
          hintText: 'What do you want?',
          hintStyle: TextStyle(fontFamily: 'Poppins', color: Colors.black12)
      ),
    );
  }
}
