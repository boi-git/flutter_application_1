// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';

import '../pages/login_page.dart';
import 'constants/colourandfont.dart';

class CustomBtmNavBar extends StatelessWidget {
  const CustomBtmNavBar({
    Key? key,
    required int selectedIndex,
    required this.ontap,
  })  : _selectedIndex = selectedIndex,
        super(key: key);

  final int _selectedIndex;
  final Function ontap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          border: Border(top: BorderSide(color: orangeColor, width: 3.0))),
      child: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 37, 39, 51),
        selectedItemColor: orangeColor,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: ((value) {
          ontap;
          print(value);
        }),

        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
