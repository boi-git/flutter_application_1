import 'package:flutter_application_1/components/constants/importstaff.dart';
import '../backend_components/user.dart' as user;

class ChatTemp extends StatefulWidget {
  final String coursename;
  const ChatTemp({super.key, required this.coursename});

  @override
  State<ChatTemp> createState() => _ChatTempState(coursename);
}

class _ChatTempState extends State<ChatTemp> {
  final NavigationService _navigationService = locator<NavigationService>();

  String coursename;
  _ChatTempState(this.coursename);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: GestureDetector(
            onTap: () {
              _navigationService.navigateTo(ChatProfile, arguments: coursename);
            },
            child: StreamBuilder<List<user.Classes>>(
              stream: readClassDetails('CSCI 1301'),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error : ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final users = snapshot.data!;

                  return Column(
                    children: users.map(buildclassMember).toList(),
                  );
                } else {
                  return const Center(child: CircularProgressIndicator());
                }
              },
            )),
      ),
    );
  }
}
