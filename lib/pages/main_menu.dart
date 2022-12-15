// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'package:flutter_application_1/components/constants/importstaff.dart';
import '../backend_components/user.dart' as user;

int _selectedIndex = 0;

class MainMenu extends StatefulWidget {
  /*final String username;
  const MainMenu({
    super.key,
    required this.username,
  });*/

  final String groupId;
  final String groupName;
  final String userName;
  const MainMenu(
      {Key? key,
      required this.groupId,
      required this.groupName,
      required this.userName})
      : super(key: key);

  @override
  State<MainMenu> createState() => _MainMenuState(userName, groupName, groupId);
}

class _MainMenuState extends State<MainMenu> {
  String userName;
  String groupName;
  String groupId;

  _MainMenuState(this.userName, this.groupName, this.groupId);
  final user_ = FirebaseAuth.instance.currentUser!;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      backgroundColor: whitecolor,
      body: Center(
        child: StreamBuilder<List<user.Classes>>(
          stream: readClassQuerywithUsername(userName),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error  qwe: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              return ListView(
                children: users.map(buildClass).toList(),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }

  Container customBtmNavBar() {
    return Container(
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(1),
              spreadRadius: 3,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
          color: Colors.white,
          border: Border(top: BorderSide(color: orangeColor, width: 3.0))),
      child: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 37, 39, 51),
        selectedItemColor: orangeColor,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,

        // ignore: prefer_const_literals_to_create_immutables
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}

//why not user username as uid?
List<Widget> tabs(String userName, String groupName, String groupId) {
  return [
    Center(
      child: StreamBuilder<List<user.Classes>>(
        stream: readClassQuerywithUsername(userName),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error  qwe: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final users = snapshot.data!;
            return ListView(
              children: users.map(buildClass).toList(),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    ),
    ChatTemp(groupId: groupId, groupName: groupName, userName: userName),
    BackgroundProfilePage()
  ];
}
