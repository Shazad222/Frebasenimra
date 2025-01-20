import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> saveUserData({
    required String username,
    required String gender,
    required String location,
    required String ideas,
    required String futureTask,
  }) async {
    await _firestore.collection('users').add({
      'username': username,
      'gender': gender,
      'location': location,
      'ideas': ideas,
      'future_task': futureTask,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
