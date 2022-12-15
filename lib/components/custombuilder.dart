// ignore_for_file: prefer_const_constructors
import 'dart:typed_data';

import 'package:flutter_application_1/backend_components/user.dart' as user;
import 'package:flutter_application_1/components/constants/importstaff.dart';

final NavigationService _navigationService = locator<NavigationService>();

Widget buildClass(user.Classes user) {
  return GestureDetector(
    onTap: (() async {
      _navigationService.navigateTo(ChatRoute,
          arguments: user.coursecode.toString());

      print(
        user.coursecode,
      );
    }),
    child: ClassListTile(
      coursecode: user.coursecode,
      coursename: user.coursename,
      lectureid: user.lectureid,
    ),
  );
}

Widget buildclassMember(user.Classes user) {
  return Expanded(
    child: ListView.builder(
        itemCount: user.members.length,
        itemBuilder: ((context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Center(
              child: CircleAvatar(
                child: GestureDetector(
                  onTap: () {
                    print(user.members[index]);
                  },
                  child: Text(
                    user.members[index],
                  ),
                ),
              ),
            ),
          );
        })),
  );
}

List listmember(user.Classes user, int number) {
  return user.members;
}

//create a new widget for class profile
Widget buildText(user.User user) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                user.name,
                style: header1(orangeColor),
              ),
              Text(
                user.role,
                style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
              ),
            ],
          ),
          Spacer(),
        ],
      ),
      Spacer(),
      Text(
        'Level',
        style: TextStyle(
            color: orangeColor, fontWeight: FontWeight.w500, fontSize: 16),
      ),
      Text(
        '4',
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
      ),
      Text(
        'Degree',
        style: TextStyle(
            color: orangeColor, fontWeight: FontWeight.w500, fontSize: 16),
      ),
      Text(
        'Computer Science',
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
      ),
      Text(
        'Major',
        style: TextStyle(
            color: orangeColor, fontWeight: FontWeight.w500, fontSize: 16),
      ),
      Text(
        'Software Engineering',
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
      ),
      Spacer(),
      Text(
        'About',
        style: TextStyle(
            color: orangeColor, fontWeight: FontWeight.w500, fontSize: 16),
      ),
      Text(
        user.about != null ? user.about : 'data',
        style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
      ),
      Spacer(),
    ],
  );
}

const aboutText =
    'Donec et augue varius, malesuada dolor sed, mattis ante. Pellentesque vel leo et massa mattis feugiat vel maximus dolor. ';

Widget buildDisplayImage(user.User user) {
  if (user.displayimage != '') {
    return CircleAvatar(
      radius: 35,
      backgroundColor: Colors.transparent,
      backgroundImage: NetworkImage(user.displayimage),
    );
  } else {
    return CircleAvatar(
        radius: 35,
        backgroundColor: darkColor,
        child: Icon(
          Icons.no_accounts,
          color: orangeColor,
        ));
  }
}

final placeholderimage =
    'https://firebasestorage.googleapis.com/v0/b/flutter-log-in-d62c8.appspot.com/o/iiumlogo.png?alt=media&token=8bcf0d8e-b2ff-48e3-9cf3-4071b6c11f93';
Widget buildBackgroundImage(
  user.User user,
) {
  if (user.backgroundimage != '') {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(user.backgroundimage),
      ),
    ));
  } else {
    return Container(
        decoration: BoxDecoration(
      image: DecorationImage(
        image: NetworkImage(placeholderimage),
      ),
    ));
  }
}

Widget buildtry(user.User user) {
  return Text(user.name);
}
