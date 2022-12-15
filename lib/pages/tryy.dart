import '../backend_components/user.dart' as user;
import '../components/constants/importstaff.dart';
import 'package:cloud_firestore/cloud_firestore.dart' as fs;

class ttry extends StatefulWidget {
  const ttry({super.key});

  @override
  State<ttry> createState() => ttryState();
}

Future<user.User?> readFUser(String username) async {
  final doc = fs.FirebaseFirestore.instance
      .collection('users')
      .doc('wsW1Un8mCzniLW4Yyn6Y');
  final snapshot = await doc.get();

  if (snapshot.exists) {
    return user.User.fromJson(snapshot.data()!);
  }
}

Future<user.User?> getData(String username) async {
  final doc = fs.FirebaseFirestore.instance.collection('users');
  final docs1 = await doc.where('username', isEqualTo: username).get();
  if (docs1.docs.first.exists) {
    return user.User.fromJson(docs1.docs.first.data!());
  } else {
    return null;
  }
}

Future<user.Classes?> getDataClass(String username) async {
  final doc = fs.FirebaseFirestore.instance.collection('classlist');
  final docs1 = await doc.where('coursecode', isEqualTo: username).get();
  if (docs1.docs.first.exists) {
    return user.Classes.fromJson(docs1.docs.first.data!());
  } else {
    return null;
  }
}

class ttryState extends State<ttry> {
  @override
  final reads = getDataClass('CSCI 1303');
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        child: FutureBuilder(
          future: reads,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final userfield = snapshot.data!;
              return Text(userfield.coursecode);
            } else {
              return Center(
                  child: CircularProgressIndicator(
                color: orangeColor,
              ));
            }
          },
        ),
      )),
    );
  }
}
