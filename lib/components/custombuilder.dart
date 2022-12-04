// ignore_for_file: prefer_const_constructors
import 'package:flutter_application_1/components/constants/route_paths.dart'
    as routes;
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/locator.dart';
import 'package:flutter_application_1/components/services/nav_services.dart';
import '../backend_components/user.dart' as user;
import 'classlisttile.dart';
import 'constants/colourandfont.dart';

final NavigationService _navigationService = locator<NavigationService>();

Widget buildClass(user.Classes user) {
  return GestureDetector(
    onTap: (() async {
      _navigationService.navigateTo(routes.ChatRoute);

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

Widget buildUser(user.User user) {
  return ListTile(
      leading: CircleAvatar(child: Text(user.name)), title: Text(user.role));
}

//create a new widget for class profile
Widget buildText(user.User user) {
  return Expanded(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
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
        Spacer(),
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
          aboutText,
          style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
        ),
        Spacer(),
      ],
    ),
  );
}

const aboutText =
    'Aliquam gravida mattis nisl, sodales eleifend magna fringilla vel. Donec et augue varius, malesuada dolor sed, mattis ante. Mauris egestas non lectus sit amet tempus. Pellentesque vel leo et massa mattis feugiat vel maximus dolor. ';
