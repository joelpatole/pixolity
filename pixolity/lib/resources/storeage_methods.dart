import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //add image to firebase storage
  Future<String> uploadImageToStorage(
      String childName, Uint8List file, bool isPost) async {
    Reference ref =
        _storage.ref().child(childName).child(_auth.currentUser!.uid);

    if (isPost) {
      String id = const Uuid().v1();
      ref = ref.child(id);
    }

    UploadTask uploadTask = ref.putData(file);

    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}

// Reference ref -> Represents a reference to a Google Cloud Storage object. (package:firebase_storage/firebase_storage.dart)
//                  Developers can upload, download, and delete objects, as well as get/set object metadata.

//UploadTask uploadTask -> A class which indicates an on-going upload task. (package:firebase_storage/firebase_storage.dart)

//TaskSnapshot snap -> A [TaskSnapshot] is returned as the result or on-going process of a [Task]. (package:firebase_storage/firebase_storage.dart)
