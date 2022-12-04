import 'package:cloud_firestore/cloud_firestore.dart' as fs;
import 'package:firebase_auth/firebase_auth.dart';

import '../backend_components/user.dart' as user;

Stream<List<user.Classes>> readClassQuerywithUsername(String username) {
  return fs.FirebaseFirestore.instance
      .collection('classlist')
      .where("member", arrayContains: username)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => user.Classes.fromJson(doc.data()))
          .toList());
}

Stream<List<user.Classes>> readClassDetails(String classname) {
  return fs.FirebaseFirestore.instance
      .collection('classlist')
      .where("coursecode", isEqualTo: classname)
      .snapshots()
      .map((snapshot) => snapshot.docs
          .map((doc) => user.Classes.fromJson(doc.data()))
          .toList());
}

Stream<List<user.User>> readUser(String username) {
  final user_ = FirebaseAuth.instance.currentUser!;
  return fs.FirebaseFirestore.instance
      .collection('users')
      .where('username', isEqualTo: username)
      .snapshots()
      .map((snapshot) =>
          snapshot.docs.map((doc) => user.User.fromJson(doc.data())).toList());
}
//arraycontains : username (used when log ing )


