import 'package:flutter/material.dart';

TextFormField textFields(
    {required TextEditingController controller, required String text}) {
  return TextFormField(
    style: TextStyle(color: Colors.white),
    controller: controller,
    decoration: InputDecoration(
      labelText: text,
      labelStyle: TextStyle(color: Colors.white),
    ),
  );
}
