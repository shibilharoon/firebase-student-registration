import 'package:firebase_project/controller/firebase_provider.dart';
import 'package:firebase_project/model/data_model.dart';
import 'package:firebase_project/view/widgets/edit_dialogue.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class EditDelete extends StatelessWidget {
  DataModel students;
  String id;
  EditDelete({super.key, required this.students, required this.id});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            title: const Text(
              'Edit',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return EditDialogue(
                    students: students,
                    id: id,
                  );
                },
              );
            },
          ),
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
            title: const Text(
              'Delete',
              style: TextStyle(color: Colors.white),
            ),
            onTap: () {
              Provider.of<FirebaseProvider>(context, listen: false)
                  .deleteStudent(id);
              Provider.of<FirebaseProvider>(context, listen: false)
                  .deleteImage(students.image!);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
