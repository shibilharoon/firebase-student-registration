import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/model/data_model.dart';
import 'package:firebase_project/service/database_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class FirebaseProvider extends ChangeNotifier {
  DatabaseService service = DatabaseService();
  String imagename = DateTime.now().microsecondsSinceEpoch.toString();
  String downloadurl = "";
  Stream<QuerySnapshot<DataModel>> getStudents() {
    return service.studentRef.snapshots();
  }

  imageAdder(image) async {
    Reference imagefolder = service.main.child('images');
    Reference uploadimage = imagefolder.child("${imagename}.jpg");
    try {
      await uploadimage.putFile(image);
      downloadurl = await uploadimage.getDownloadURL();

      print(downloadurl); 
    } catch (error) {
      return Exception('image cant be added $error');
    }
  }

  imageUpdate(imageurl, updatedimage) async {
    try {
      Reference editpic = FirebaseStorage.instance.refFromURL(imageurl);
      await editpic.putFile(updatedimage);
      downloadurl = await editpic.getDownloadURL();
    } catch (error) {
      return Exception('image is not updated$error');
    }
  }

  deleteImage(imageurl) async {
    try {
      Reference delete = FirebaseStorage.instance.refFromURL(imageurl);
      await delete.delete();
      print('image deleted successfully');
    } catch (error) {
      return Exception('image is not deleted $error');
    }
  }

  Future<void> addStudent(DataModel data) async {
    await service.studentRef.add(data);
    notifyListeners();
  }

  Future<void> updateStudent(id, DataModel student) async {
    service.studentRef.doc(id).update(student.toJson());
    notifyListeners();
  }

  Future<void> deleteStudent(id) async {
    service.studentRef.doc(id).delete();
    notifyListeners();
  }
}
