import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/controller/firebase_provider.dart';
import 'package:firebase_project/model/data_model.dart';
import 'package:firebase_project/view/widgets/dialogue.dart';
import 'package:firebase_project/view/widgets/edit_delete.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Sudent Hub',
          style: GoogleFonts.aBeeZee(
              fontWeight: FontWeight.w800, color: Colors.white),
        ),
        centerTitle: true,
        elevation: 0,
      ),
      body: Consumer<FirebaseProvider>(builder: (context, provider, child) {
        return StreamBuilder<QuerySnapshot<DataModel>>(
          stream: provider.getStudents(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            List<QueryDocumentSnapshot<DataModel>> studentDocs =
                snapshot.data?.docs ?? [];

            return ListView.separated(
              itemCount: studentDocs.length,
              itemBuilder: (context, index) {
                DataModel students = studentDocs[index].data();
                final id = studentDocs[index].id;

                return ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(students.image!),
                  ),
                  title: Text(
                    students.name ?? '',
                    style: GoogleFonts.figtree(
                        fontWeight: FontWeight.w700, fontSize: 20),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(students.phone ?? ''),
                      Text(students.age ?? ''),
                    ],
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(students.course ?? '',
                          style: GoogleFonts.acme(
                              color: const Color.fromARGB(255, 90, 10, 4),
                              fontSize: 25)),
                      SizedBox(
                        width: 20,
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return EditDelete(
                                students: students,
                                id: id,
                              );
                            },
                          );
                        },
                        child: Icon(
                          Icons.more_horiz,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AddingDialogue();
            },
          );
        },
      ),
    );
  }
}
