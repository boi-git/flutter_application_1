import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/components/constants/importstaff.dart';

class Triying extends StatefulWidget {
  const Triying({super.key});

  @override
  State<Triying> createState() => TriyingState();
}

class TriyingState extends State<Triying> {
  List<String> getUserID = [];

  String classDoc = '';

  @override
  void initState() {
    // getClassDoc();

    // super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      child: Center(
          child: ListView.builder(
              itemCount: getUserID.length,
              itemBuilder: ((context, index) {
                return Text(getUserID[index]);
              }))),
    ));
  }
}

class Course {
  final String? classdetail;
  final String? coursecode;
  final String? coursename;
  final String? lectureid;
  final List<String>? member;

  Course(
      {this.classdetail,
      this.coursecode,
      this.coursename,
      this.lectureid,
      this.member});

  factory Course.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    return Course(
      classdetail: data?['course_detail'],
      coursecode: data?['coursecode'],
      coursename: data?['coursename'],
      lectureid: data?['lectureid'],
      member: data?['member'] is Iterable ? List.from(data?['member']) : null,
    );
  }
  Map<String, dynamic> toFirestore() {
    return {
      if (classdetail != null) "couse_detail": classdetail,
      if (coursecode != null) "coursecode": coursecode,
      if (coursename != null) "coursename": coursename,
      if (lectureid != null) "lectureid": lectureid,
      if (member != null) "member": member,
    };
  }
}

// Future<String> getClassDoc() async {
//   var output = '';
//   await FirebaseFirestore.instance
//       .collection('classlist')
//       .where("coursecode", isEqualTo: 'CSCI 1303')
//       .get()
//       .then(
//         (snapshot) => snapshot.docs.forEach(
//           (element) {
//             print(element.id);
//             output = element.id;
//           },
//         ),
//       );
//   return output;
// }

// getSomething() async {
//   String? classDoc = await getClassDoc();
//   final ref = FirebaseFirestore.instance
//       .collection('classlist')
//       .doc(classDoc)
//       .withConverter(
//           fromFirestore: Course.fromFirestore,
//           toFirestore: (Course course, _) => course.toFirestore());
//   final docSnap = await ref.get();
//   final course = docSnap.data();
//   if (course != null) {
//     print(course);
//     return course.member!.toList();
//   } else {
//     return [];
//   }
// }
