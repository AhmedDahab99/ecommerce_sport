import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  // get User ID
  String getUserID() {
    return _firebaseAuth.currentUser.uid;
  }

  // Collection Of Products
  final CollectionReference productReference =
      FirebaseFirestore.instance.collection("Products");

  //Collection Of CartUsers
  final CollectionReference usersReference = FirebaseFirestore.instance
      .collection("Users"); // User => UserID(Docs) => Cart => ProductID(Docs)
}
