import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/components/constants/route_paths.dart';
import 'package:flutter_application_1/pages/chat_temp.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/main_menu.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ChatRoute:
      return MaterialPageRoute(builder: (context) => const ChatTemp());
    case MainMenuRoute:
      return MaterialPageRoute(
          builder: (context) => const MainMenu(
                username: '1000146',
              ));
    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No path for ${settings.name}'),
          ),
        ),
      );
  }
}
