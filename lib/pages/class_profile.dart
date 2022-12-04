// ignore_for_file: prefer_const_constructors

import 'package:flutter_application_1/components/constants/importstaff.dart';

import '../backend_components/user.dart' as user;

class ClassBackDetail extends StatefulWidget {
  const ClassBackDetail({super.key});

  @override
  State<ClassBackDetail> createState() => _ClassBackDetailState();
}

class _ClassBackDetailState extends State<ClassBackDetail> {
  final NavigationService _navigationService = locator<NavigationService>();
  int _selectedindex = 2;
  bool _classshow = true;
  String name = "";
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final images = [
      'lib/images/Bg1.JPG',
      'lib/images/Bg2.JPG',
      'lib/images/iiumlogo.png'
    ];
    final uname = ['1912345', '1911112'];

    return Scaffold(
      appBar: CustomAppBar(),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(images[_selectedindex]), fit: BoxFit.cover),
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
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: CupertinoSearchTextField(
                //     borderRadius: BorderRadius.circular(25),
                //     backgroundColor: whitecolor,
                //     onChanged: ((value) {
                //       setState(() {
                //         name = value;
                //       });
                //     }),
                //   ),
                // ),
                // SearchBar(
                //   onChanged: (String z) {
                //     name = z;
                //   },
                // ),
                Spacer(),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: Column(
                          children: [
                            Text(
                              '',
                              style: TextStyle(color: whitecolor),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _classshow = true;

                                  _selectedindex = 2;
                                  print(_selectedindex);
                                });
                              },
                              child: CircleAvatar(
                                backgroundImage: AssetImage(images[2]),
                                radius: size.width / 15,
                              ),
                            ),
                            SizedBox(
                              height: size.height / 2.5,
                              width: size.width / 5,
                              child: ListView.builder(
                                //    shrinkWrap: true,
                                itemCount: 3,
                                itemBuilder: ((context, index) {
                                  return GestureDetector(
                                    onTap: (() {
                                      setState(() {
                                        _selectedindex = index;
                                        _classshow = false;
                                      });
                                    }),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 5.0),
                                      child: Center(
                                        child: CircleAvatar(
                                          backgroundImage: AssetImage(
                                            images[index],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                              ),
                            ),
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: size.height / 2,
                                  child: _classshow
                                      ? StreamBuilder<List<user.Classes>>(
                                          //stream: readUser(uname[_selectedindex]),
                                          stream: readClassDetails('CSCI 1301'),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return Text(
                                                  'Error : ${snapshot.error}');
                                            } else if (snapshot.hasData) {
                                              final users = snapshot.data!;
                                              return Column(
                                                children: users
                                                    .map(buildClass)
                                                    .toList(),
                                              );
                                            } else {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          },
                                        )
                                      : StreamBuilder<List<user.User>>(
                                          //stream: readUser(uname[_selectedindex]),
                                          stream:
                                              readUser(uname[_selectedindex]),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasError) {
                                              return Text(
                                                  'Error : ${snapshot.error}');
                                            } else if (snapshot.hasData) {
                                              final users = snapshot.data!;
                                              return Column(
                                                children: users
                                                    .map(buildText)
                                                    .toList(),
                                              );
                                            } else {
                                              return const Center(
                                                  child:
                                                      CircularProgressIndicator());
                                            }
                                          },
                                        )),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
