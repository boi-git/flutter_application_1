import 'package:flutter_application_1/components/constants/importstaff.dart';
import 'package:flutter_application_1/pages/refine_class_profile.dart';
import 'package:flutter_application_1/pages/refine_user_profile.dart';

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
      onGenerateRoute: generateRoute,
      initialRoute: LoginRoute,
      navigatorKey: locator<NavigationService>().navigatorKey,
      //home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
