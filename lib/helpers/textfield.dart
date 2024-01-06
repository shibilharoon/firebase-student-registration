import 'package:flutter/material.dart';

TextFormField textFields(
    {required TextEditingController controller, required String text}) {
  return TextFormField(
    style: const TextStyle(color: Colors.white),
    controller: controller,
    decoration: InputDecoration(
      labelText: text,
      labelStyle: const TextStyle(color: Colors.white),
    ),
  );
}
