import 'package:flutter/material.dart';

class TextfieldAuth extends StatelessWidget {
  final TextEditingController controller;
  final bool obscureText;
  final String hintText;

  const TextfieldAuth({
    super.key,
    required this.controller,
    required this.obscureText,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: TextField(
        cursorColor: Color.fromARGB(255, 222, 100, 0),
        style: TextStyle(color: Color.fromARGB(255, 154, 69, 0)),
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.orange[800],
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Color.fromARGB(255, 255, 229, 190),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          fillColor: Color.fromARGB(255, 255, 205, 130),
          filled: true,
        ),
      ),
    );
  }
}
