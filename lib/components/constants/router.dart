import 'importstaff.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ChatRoute:
      var coursename = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => ChatTemp(
                coursename: coursename,
              ));

    case ChatProfile:
      var coursename = settings.arguments as String;

      return MaterialPageRoute(
          builder: (context) => ClassBackDetail(coursename: coursename));

    case MainMenuRoute:
      var username = 'x'; //settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => const MainMenu(
          username: '1000146',
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
