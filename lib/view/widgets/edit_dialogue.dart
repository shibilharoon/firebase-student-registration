import 'dart:io';

import 'package:firebase_project/controller/data_provider.dart';
import 'package:firebase_project/controller/firebase_provider.dart';
import 'package:firebase_project/helpers/textfield.dart';
import 'package:firebase_project/model/data_model.dart';
import 'package:firebase_project/view/widgets/dropdown.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditDialogue extends StatefulWidget {
  DataModel students;
  String id;
  EditDialogue({super.key, required this.students, required this.id});

  @override
  State<EditDialogue> createState() => _EditDialogueState();
}

class _EditDialogueState extends State<EditDialogue> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController groupController = TextEditingController();
  bool clicked = true;
  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.students.name);
    ageController = TextEditingController(text: widget.students.age);
    phoneController = TextEditingController(text: widget.students.phone);
    groupController = TextEditingController(text: widget.students.course);
    Provider.of<Providers>(context, listen: false).file =
        File(widget.students.image ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: MediaQuery.of(context).size.width * 0.8,
      child: AlertDialog(
        backgroundColor: Colors.black,
        title: const Text('Add Item'),
        content: SingleChildScrollView(
          child: Consumer<Providers>(
            builder: (context, provider, child) => Column(
              children: [
                FutureBuilder<File?>(
                  future: Future.value(provider.file),
                  builder: (context, snapshot) {
                    return CircleAvatar(
                      backgroundColor: Colors.grey,
                      radius: 40,
                      backgroundImage: !clicked
                          ? FileImage(File(provider.file!.path))
                          : NetworkImage(provider.file!.path) as ImageProvider,
                    );
                  },
                ),
                Row(
                  children: [
                    const SizedBox(
                      width: 35,
                    ),
                    TextButton(
                      onPressed: () {
                        provider.getCam(ImageSource.camera);
                      },
                      child: const Text(
                        'Camera',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        provider.getCam(ImageSource.gallery);
                        clicked = !clicked;
                      },
                      child: const Text(
                        'Gallery',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  ],
                ),
                textFields(controller: nameController, text: 'Name'),
                textFields(controller: ageController, text: 'Age'),
                textFields(controller: phoneController, text: 'Mobile'),
                const DropDown()
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: const Text(
              'cancel',
              style: TextStyle(color: Colors.amber),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(
              'save',
              style: TextStyle(color: Colors.amber),
            ),
            onPressed: () {
              update(widget.students.image);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  void update(imageurl) async {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    final pro = Provider.of<Providers>(context, listen: false);
    final name = nameController.text;
    final age = ageController.text;
    final phone = phoneController.text;
    final group = pro.selectedGroups;
    await provider.imageUpdate(imageurl, File(pro.file!.path));
    final updated = DataModel(
        name: name,
        age: age,
        phone: phone,
        course: group,
        image: provider.downloadurl);
    provider.updateStudent(widget.id, updated);
  }
}
