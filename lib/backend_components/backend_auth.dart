import '../components/constants/importstaff.dart';
import '../backend_components/user.dart' as user;

final NavigationService _navigationService = locator<NavigationService>();
Future<User?> loginUsingEmailPassword1(
    {required String username,
    required String password,
    required BuildContext context}) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? user;
  try {
    QuerySnapshot snap = await FirebaseFirestore.instance
        .collection("users")
        .where("username", isEqualTo: username)
        .get();
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: snap.docs[0]['email'], password: password);

    //1000124@gmail.com
    user = userCredential.user;
  } on FirebaseAuthException catch (e) {
    if (e.code == "user-not-found") {
      print("No User Found");
    }
  }

  return user;
}

Future<void> loginWithUsername(
  String email,
  String password,
  var context,
) async {
  User? user = await loginUsingEmailPassword1(
      username: email, password: password, context: context);
  print(user);
  if (user != null) {
    _navigationService.navigateTo(MainMenuRoute, arguments: email);
  }
}
