import 'importstaff.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ChatRoute:
<<<<<<< HEAD
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
=======
      return MaterialPageRoute(
          builder: (context) => ChatTemp(
              groupId: "0n2hoCCGmOrA4sRUoSk6",
              groupName: "Mathematics for Computing I",
              userName: "1000117"));
    case ChatProfile:
      return MaterialPageRoute(builder: (context) => const ClassBackDetail());
    case MainMenuRoute:
      var username = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => MainMenu(
          userName: username,
          groupId: "0n2hoCCGmOrA4sRUoSk6",
          groupName: "Mathematics for Computing I",
>>>>>>> 0e913141d6c0a8a55879e5a6d237e4bf9e0385af
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
