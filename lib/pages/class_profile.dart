// ignore_for_file: prefer_const_constructors, no_logic_in_create_state
import 'package:flutter_application_1/components/constants/importstaff.dart';
import '../backend_components/user.dart' as user;

String userID = "";

class ClassBackDetail extends StatefulWidget {
  final String coursename;
  const ClassBackDetail({super.key, required this.coursename});

  @override
  State<ClassBackDetail> createState() => _ClassBackDetailState(coursename);
}

class _ClassBackDetailState extends State<ClassBackDetail> {
  final NavigationService _navigationService = locator<NavigationService>();
  int _selectedindex = 1;
  bool _classshow = true;
  String coursename;

  _ClassBackDetailState(this.coursename);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final images = [
      'lib/images/Bg1.JPG',
      'lib/images/Bg2.JPG',
      'lib/images/iiumlogo.png'
    ];

    return Scaffold(
        appBar: CustomAppBar(),
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(images[2]), fit: BoxFit.cover),
            ),
            child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: SafeArea(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                      TextButton(
                          onPressed: (() => _navigationService.goBack()),
                          child: Text('text')),
                      Spacer(),
                      Row(children: [
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _classshow = true;
                                      _selectedindex = 2;
                                    });
                                  },
                                  child: CircleAvatar(
                                    backgroundImage: AssetImage(images[2]),
                                    radius: size.width / 15,
                                  ),
                                ),
                                //!scroll widget
                                SizedBox(
                                    height: size.height / 2.5,
                                    width: size.width / 5,
                                    //
                                    child: streamBuilderUserScroll(
                                        buildclassMembertest)),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                            flex: 4,
                            child: GlassMorph(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20.0, horizontal: 25),
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: size.height / 2,
                                            child: _classshow
                                                ? streamBuilderClassDetails()
                                                : streamBuilderClassDetails(),
                                          )
                                        ]))))
                      ])
                    ])))));
  }

  Widget buildclassMembertest(user.Classes user) {
    return Expanded(
      child: ListView.builder(
          itemCount: user.members.length,
          itemBuilder: ((context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Center(
                child: CircleAvatar(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        userID = user.members[index];
                        print(userID);
                        _classshow = false;
                      });
                    },
                    child: Text(
                      user.members[index],
                    ),
                  ),
                ),
              ),
            );
          })),
    );
  }

  StreamBuilder<List<user.Classes>> streamBuilderUserScroll(
      Widget Function(user.Classes user) buildclassMembertest) {
    return StreamBuilder<List<user.Classes>>(
      stream: readClassDetails(coursename),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error : ${snapshot.error}');
        } else if (snapshot.hasData) {
          final users = snapshot.data!;

          return Column(children: users.map(buildclassMembertest).toList());
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  StreamBuilder<List<user.Classes>> streamBuilderClassDetails() {
    return StreamBuilder<List<user.Classes>>(
      //stream: readUser(uname[_selectedindex]),
      stream: readClassDetails(coursename),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error : ${snapshot.error}');
        } else if (snapshot.hasData) {
          final users = snapshot.data!;

          return Column(
            children: users.map(buildClass).toList(),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

StreamBuilder<List<user.User>> streaBuilderUserDetails() {
  return StreamBuilder<List<user.User>>(
    //stream: readUser(uname[_selectedindex]),

    stream: readUser(userID),
    builder: (context, snapshot) {
      if (snapshot.hasError) {
        return Text('Error : ${snapshot.error}');
      } else if (snapshot.hasData) {
        final users = snapshot.data!;
        return Column(
          children: users.map(buildText).toList(),
        );
      } else {
        return const Center(child: CircularProgressIndicator());
      }
    },
  );
}
