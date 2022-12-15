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

Future<user.Classes?> readFClassDetails(String classname) async {
  final doc = fs.FirebaseFirestore.instance
      .collection('classlist')
      .where("coursecode", isEqualTo: classname)
      .limit(1)
      .get()
      .then((value) {
    value.docs.map((doc) {
      if (doc.exists) {
        print('0');
        return user.User.fromJson(doc.data());
      } else {
        print('object que class');
      }
    });
  });
}

Future<user.Classes?> readFClassQuerywithUsername(String username) async {
  final doc = await fs.FirebaseFirestore.instance
      .collection('classlist')
      .where("member", arrayContains: username)
      .limit(1);
  final docs = doc.get().then((value) {
    value.docs.map((doc) {
      if (doc.exists) {
        print('0');
        return user.User.fromJson(doc.data());
      } else {
        print('object que class');
      }
    });
  });
}

Future<user.User?> readFUser(String username) async {
  final doc = fs.FirebaseFirestore.instance
      .collection('users')
      .where('username', isEqualTo: username);
  final docs = await doc.get().then((value) {
    value.docs.map((doc) {
      if (doc.exists) {
        print('1');
        return user.User.fromJson(doc.data());
      } else {
        print('object');
      }
    }).toList();
  });
}

Future<user.User?> getData(String username) async {
  final doc = fs.FirebaseFirestore.instance.collection('users');
  final docs1 = await doc.where('username', isEqualTo: username).get();
  if (docs1.docs.first.exists) {
    return user.User.fromJson(docs1.docs.first.data());
  } else {
    return null;
  }
}

Future<user.Classes?> getDataClass(String username) async {
  final doc = fs.FirebaseFirestore.instance.collection('classlist');
  final docs1 = await doc.where('coursecode', isEqualTo: username).get();
  if (docs1.docs.first.exists) {
    return user.Classes.fromJson(docs1.docs.first.data());
  } else {
    return null;
  }
}
