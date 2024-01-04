import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/model/data_model.dart';
import 'package:firebase_storage/firebase_storage.dart';


class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  late final CollectionReference<DataModel> studentRef;
  Reference main = FirebaseStorage.instance.ref();
  
  DatabaseService() {
    studentRef = firestore.collection("student details").withConverter<DataModel>(
          fromFirestore: (snapshot, snapshotOptions) => DataModel.fromJson(snapshot.data()!),
          toFirestore: (data, setOptions) => data.toJson(),
        );
  }
}
