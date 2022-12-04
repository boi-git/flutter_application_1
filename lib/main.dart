// ignore_for_file: depend_on_referenced_packages, unused_import

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/backend_components/backend_auth.dart';
import 'package:flutter_application_1/components/constants/route_paths.dart'
    as routes;
import 'package:flutter_application_1/components/constants/router.dart'
    as router;
import 'package:flutter_application_1/components/services/nav_services.dart';
import 'package:flutter_application_1/pages/chat_temp.dart';
import 'package:flutter_application_1/pages/login_page.dart';
import 'package:flutter_application_1/pages/main_menu.dart';
import 'package:flutter_application_1/pages/profile_page.dart';

import 'components/locator.dart';

void main() async {
  setupLocator();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(backgroundColor: Colors.grey[800]),
      onGenerateRoute: router.generateRoute,
      initialRoute: routes.MainMenuRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      debugShowCheckedModeBanner: false,
    );
  }
}

