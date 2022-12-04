import 'package:flutter_application_1/components/constants/importstaff.dart';

class ChatTemp extends StatefulWidget {
  const ChatTemp({super.key});

  @override
  State<ChatTemp> createState() => _ChatTempState();
}

class _ChatTempState extends State<ChatTemp> {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: Center(
        child: GestureDetector(
          onTap: () {
            _navigationService.navigateTo(ChatProfile);
            // Navigator.of(context).pushReplacement(MaterialPageRoute(
            //     builder: (context) => const ClassBackDetail()))
            ;
          },
          child: const Text('go'),
        ),
      ),
    );
  }
}
