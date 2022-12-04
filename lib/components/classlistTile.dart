// ignore: file_names
import 'package:flutter_application_1/components/constants/importstaff.dart';

class ClassListTile extends StatelessWidget {
  final String coursecode;
  final String coursename;
  final String lectureid;
  const ClassListTile({
    Key? key,
    required this.coursecode,
    required this.coursename,
    required this.lectureid,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            shape: BoxShape.circle,
            border: Border.all(
              width: 3,
              color: orangeColor,
            ),
          ),
          height: size.height * 0.34,
          child: const Image(
            image: AssetImage('lib/images/iiumlogo.png'),
          ),
        ),
        title: Text(coursename),
        subtitle: Text(lectureid),
        //isThreeLine: Text(coursename),
        trailing: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: orangeColor,
              border: Border.all(width: 2, color: orangeColor)),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              '2',
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 51, 51, 51)),
            ),
          ),
        ),
      ),
    );
  }
}
