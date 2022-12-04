// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import '../pages/main_menu.dart';

Future<User?> loginUsingEmailPassword1(
    {required String username,
    required String password,
    required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: snap.docs[0]["email"], password: password);
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      print("No User Found");
    }
  }

  return user;
}

Future<void> loginWithUsername(
  String email,
  String password,
  var context,
) async {
  User? user = await loginUsingEmailPassword1(
      username: email, password: password, context: context);
  print(user);
  if (user != null) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => MainMenu(
              username: email,
            )));
  }
}
