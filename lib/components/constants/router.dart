import 'importstaff.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ChatRoute:
      return MaterialPageRoute(builder: (context) => const ChatTemp());
    case ChatProfile:
      return MaterialPageRoute(builder: (context) => const ClassBackDetail());
    case MainMenuRoute:
      var username = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => MainMenu(
          username: username,
        ),
      );
    case LoginRoute:
      return MaterialPageRoute(builder: (context) => const LoginPage());
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
