import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseController{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addData(List<Map<String, dynamic>> order) async {
    WriteBatch batch = _firestore.batch();

    for (var map in order) {
      DocumentReference docRef = _firestore.collection('your_collection_name').doc();
      batch.set(docRef, map);
    }

    await batch.commit();
  }
}