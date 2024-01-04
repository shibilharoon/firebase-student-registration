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
class AddingDialogue extends StatelessWidget {
  AddingDialogue({super.key});

  TextEditingController nameController = TextEditingController();

  TextEditingController ageController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(133, 0, 0, 0),
      width: MediaQuery.of(context).size.width * 0.8,
      child: AlertDialog(
        backgroundColor: Colors.black,
        content: SingleChildScrollView(
          child: Consumer<Providers>(
            builder: (context, provider, child) => Column(
              children: [
                FutureBuilder<File?>(
                  future: Future.value(Provider.of<Providers>(context).file),
                  builder: (context, snapshot) {
                    return CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 131, 130, 130),
                      radius: 40,
                      backgroundImage: snapshot.data != null
                          ? FileImage(snapshot.data!)
                          : null,
                    );
                  },
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 35,
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<Providers>(context, listen: false)
                            .getCam(ImageSource.camera);
                      },
                      child: Text(
                        'Camera',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Provider.of<Providers>(context, listen: false)
                            .getCam(ImageSource.gallery);
                      },
                      child: Text(
                        'Gallery',
                        style: TextStyle(color: Colors.amber),
                      ),
                    ),
                  ],
                ),
                textFields(controller: nameController, text: 'Name'),
                textFields(controller: ageController, text: 'Age'),
                textFields(controller: phoneController, text: 'Mobile'),
                DropDown()
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              'Cancel',
              style: TextStyle(color: Colors.amber),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              'Add',
              style: TextStyle(color: Colors.amber),
            ),
            onPressed: () {
              addData(context);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }

  addData(BuildContext context) async {
    final provider = Provider.of<FirebaseProvider>(context, listen: false);
    final pro = Provider.of<Providers>(context, listen: false);
    final name = nameController.text;
    final age = ageController.text;
    final phone = phoneController.text;
    final group = pro.selectedGroups;
    await provider.imageAdder(File(pro.file!.path));
    final data = DataModel(
        name: name,
        age: age,
        phone: phone,
        course: group,
        image: provider.downloadurl);
    provider.addStudent(data);
    pro.file = null;
  }
}
