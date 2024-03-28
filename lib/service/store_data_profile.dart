// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';

FirebaseStorage _storage = FirebaseStorage.instance;
FirebaseFirestore _firestore = FirebaseFirestore.instance;

class StoreData {
  Future<String> uploadImageToStorage(String childName, Uint8List file) async {
    Reference ref = _storage.ref().child(childName).child("id");
    UploadTask uploadTask = ref.putData(file);
    TaskSnapshot snapshot = await uploadTask;
    String downLoadUrl = await snapshot.ref.getDownloadURL();
    return downLoadUrl;
  }

  Future<String> saveData({required Uint8List file}) async {
    String resp = "Some Error Occurred";
    try {
      String imageUrl = await uploadImageToStorage("profile image", file);
      await _firestore.collection("userProfile").add({
        "imageLink": imageUrl,
      });
      resp = "success";
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}
