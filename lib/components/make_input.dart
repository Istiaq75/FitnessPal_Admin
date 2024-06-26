// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MakeInput extends StatelessWidget {
  final String? label;
  final bool? obscureText;
  final TextEditingController? controllerID;
  
  const MakeInput({super.key, this.label, this.obscureText, this.controllerID});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toString(),
          style: TextStyle(
            fontSize: 15.0,
            fontWeight: FontWeight.w700,
            color: Colors.black87,
          ),
        ),
        SizedBox(
          height: 5.0,
        ),
        TextField(
          controller: controllerID,
          // obscureText: obscureText?,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(
              vertical: 0.0,
              horizontal: 10.0,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey
                  // color: Colors.grey[400],
                  ),
            ),
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }
}
