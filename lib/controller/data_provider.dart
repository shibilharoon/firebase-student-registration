import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Providers extends ChangeNotifier {
  final courses = [
    'BCA',
    'Bsc CS',
    'BAFE',
    'BMMC',
    'BCOM',
    'PSY',
    'Bsc Maths',
    'BT'
  ];
  File? file;
  var selectedGroups = 'BCA';
  ImagePicker image = ImagePicker();
  Future<void> getCam(ImageSource source) async {
    var img = await image.pickImage(source: source);
    file = File(img!.path);
    notifyListeners();
  }

  dropdownValuechange(newValue) {
    selectedGroups = newValue;
    notifyListeners();
  }
}
