import 'package:flutter/material.dart';

import 'constants/colourandfont.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Padding(
        padding: EdgeInsets.all(5.0),
        child: Image(
          image: AssetImage('lib/images/iiumlogo.png'),
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(4.0),
        child: Container(
          color: orangeColor,
          height: 4,
        ),
      ),
      // ignore: prefer_const_constructors
      backgroundColor: Color.fromARGB(255, 37, 39, 51),
      actions: [
        IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.menu,
              color: orangeColor,
            ))
      ],
    );
  }

  @override
  final Size preferredSize = const Size.fromHeight(kToolbarHeight);
}
