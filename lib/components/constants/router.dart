import '../../pages/main_menu.dart';
import 'importstaff.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case ChatRoute:
      return MaterialPageRoute(
          builder: (context) => ChatTemp(
              groupId: "0n2hoCCGmOrA4sRUoSk6",
              groupName: "Mathematics for Computing I",
              userName: "1000117"));
    case ChatProfile:
      return MaterialPageRoute(
          builder: (context) => const ClassBackDetail(
                coursename: '',
              ));
    case MainMenuRoute:
      var username = settings.arguments as String;
      return MaterialPageRoute(
        builder: (context) => MainMenu(
          userName: username,
          groupId: "0n2hoCCGmOrA4sRUoSk6",
          groupName: "Mathematics for Computing I",
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
