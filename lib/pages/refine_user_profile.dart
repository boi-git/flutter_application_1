// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'dart:io';
import 'package:flutter_application_1/components/constants/importstaff.dart';
import '../backend_components/user.dart' as user;

class UserBackDetail extends StatefulWidget {
  final String username;
  const UserBackDetail({super.key, required this.username});

  @override
  State<UserBackDetail> createState() => _UserBackDetailState(username);
}

class _UserBackDetailState extends State<UserBackDetail> {
  TextEditingController aboutController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  String userID = "";
  Size size = Size(1, 1);
  bool _showedit = false;
  bool _showsubmenu = true;
  String username;
  File? _imageDpFile;
  File? _imageBgFile;
  String url = '';
  bool typeofImage = true;

  // #region //TodoCreate Seperate Folder
  Future upImage(File image, String folder) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child(folder)
        .child(username + ' ' + folder + '.jpg');
    await ref.putFile(image);
    url = await ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection('users')
        //!TODO .doc(user.id after log in) or create new query
        .doc('wsW1Un8mCzniLW4Yyn6Y')
        .set({folder: url}, SetOptions(merge: true)).then((value) {});
    print(url);
  }

  Future _pickImage(ImageSource source, bool types) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;
      File? img = File(image.path);
      img = await _cropImage(imageFile: img);
      setState(() {
        if (types == true) {
          _imageDpFile = img;
          upImage(_imageDpFile!, 'DisplayImage');
        } else {
          _imageBgFile = img;
          upImage(_imageBgFile!, 'BackgroundImage');
        }
      });
    } on PlatformException catch (e) {
      print(e);
      Navigator.of(context).pop();
    }
  }

  Future _cropImage({required File imageFile}) async {
    CroppedFile? croppedFile =
        await ImageCropper().cropImage(sourcePath: imageFile.path);
    if (croppedFile == null) return;
    return File(croppedFile.path);
  }
  // #endregion

  _UserBackDetailState(this.username);
  @override
  Widget build(BuildContext context) {
    setState(() {
      size = MediaQuery.of(context).size;
    });

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar(),
        body: StreamBuilder(
          stream: readUser(username),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Error :${snapshot.error}');
            } else if (snapshot.hasData) {
              final users = snapshot.data!;
              print(snapshot.data!.first.about);

              return Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: snapshot.data!.first.backgroundimage != null
                              ? NetworkImage(snapshot
                                  .data!.first.backgroundimage
                                  .toString())
                              : AssetImage('lib/images/iiumlogo.png')
                                  as ImageProvider),
                    ),
                    child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.transparent,
                      body: SafeArea(
                        child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        height: size.height / 2,
                                        child: Column(
                                          children: [
                                            Stack(
                                              clipBehavior: Clip.none,
                                              children: [
                                                Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 20),
                                                    child: SizedBox(
                                                      // height: size.height / 5,
                                                      width: size.width / 5,
                                                      child: Column(
                                                        children: users
                                                            .map(
                                                                buildDisplayImage)
                                                            .toList(),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Visibility(
                                                  visible: _showedit,
                                                  child: Positioned(
                                                    bottom: -10,
                                                    right: 0,
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          color: darkColor,
                                                          shape:
                                                              BoxShape.circle,
                                                          border: Border.all(
                                                              width: 2,
                                                              color:
                                                                  orangeColor)),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: GestureDetector(
                                                          onTap: (() {
                                                            _pickImage(
                                                                ImageSource
                                                                    .gallery,
                                                                true);
                                                          }),
                                                          child: Icon(
                                                            Icons.edit,
                                                            size: 20,
                                                            color: orangeColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Spacer(),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      _showedit = !_showedit;
                                                    });
                                                  },
                                                  icon: Icon(Icons.settings)),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Stack(
                                        children: [
                                          Visibility(
                                            visible: _showsubmenu,
                                            maintainState: true,
                                            maintainAnimation: true,
                                            maintainSize: true,
                                            child: Stack(
                                              children: [
                                                GlassMorph(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        height: size.height / 2,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 20,
                                                                  horizontal:
                                                                      25),
                                                          child: Column(
                                                              children: _showedit
                                                                  ? users
                                                                      .map(
                                                                          editText)
                                                                      .toList()
                                                                  : users
                                                                      .map(
                                                                          buildText)
                                                                      .toList()),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Positioned(
                                                  right: 20,
                                                  top: 20,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: GestureDetector(
                                                      onTap: (() {
                                                        setState(() {
                                                          _showsubmenu = false;
                                                        });
                                                      }),
                                                      child: Icon(
                                                        Icons
                                                            .keyboard_double_arrow_down,
                                                        size: 30,
                                                        color: orangeColor,
                                                      ),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: !_showsubmenu,
                                            child: Positioned(
                                              right: 20,
                                              bottom: 15,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: GestureDetector(
                                                  onTap: (() {
                                                    setState(() {
                                                      _showsubmenu = true;
                                                    });
                                                  }),
                                                  child: Icon(
                                                    Icons
                                                        .keyboard_double_arrow_up,
                                                    size: 30,
                                                    color: orangeColor,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),
                  ),
                  Visibility(
                    visible: _showedit,
                    child: Positioned(
                      right: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              color: darkColor,
                              shape: BoxShape.circle,
                              border: Border.all(width: 2, color: orangeColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: GestureDetector(
                              onTap: (() {
                                _pickImage(ImageSource.gallery, false);
                              }),
                              child: Icon(
                                Icons.edit,
                                size: 20,
                                color: orangeColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ));
  }

  Future openDialogAbout(String input) {
    return showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: darkColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  shape: BoxShape.rectangle),
              width: size.width,
              height: size.height / 3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'About',
                        style: h1orange(),
                      ),
                      Spacer(),
                      TextField(
                        controller: aboutController,
                        style: TextStyle(color: whitecolor),
                        decoration: customInputDecoration(),
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                      ),
                      Spacer(),
                      Container(
                        // ignore: prefer_const_literals_to_create_immutables
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            offset: Offset(6, 9),
                            spreadRadius: 4,
                            blurRadius: 25,
                            color: Color.fromRGBO(25, 25, 25, 0.5),
                          )
                        ]),
                        child: RoundedButton(
                            size: size,
                            text: 'Sumbit',
                            color: darkColor,
                            textColor: orangeColor,
                            press: () {
                              //wsW1Un8mCzniLW4Yyn6Y

                              FirebaseFirestore.instance
                                  .collection('users')
                                  //!TODO .doc(user.id after log in) or create new query
                                  .doc('wsW1Un8mCzniLW4Yyn6Y')
                                  .set({'about': aboutController.text},
                                      SetOptions(merge: true)).then((value) {
                                sumbit();
                              });
                            }),
                      ),
                    ]),
              ),
            ),
          );
        }));
  }

  Future openDialogPassword(String input) {
    return showDialog(
        context: context,
        builder: ((context) {
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                  color: darkColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  shape: BoxShape.rectangle),
              width: size.width,
              height: size.height / 2,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Current Password',
                        style: h1orange(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 15),
                        child: TextField(
                          style: TextStyle(color: whitecolor),
                          decoration: customInputDecoration(),
                          obscureText: true,
                        ),
                      ),
                      Text(
                        'New Password',
                        style: h1orange(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0, bottom: 15),
                        child: TextField(
                          style: TextStyle(color: whitecolor),
                          decoration: customInputDecoration(),
                          obscureText: true,
                        ),
                      ),
                      Text(
                        'Confirm Password',
                        style: h1orange(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: TextField(
                          style: TextStyle(color: whitecolor),
                          decoration: customInputDecoration(),
                          obscureText: true,
                        ),
                      ),
                      Spacer(),
                      Container(
                        // ignore: prefer_const_literals_to_create_immutables
                        decoration: BoxDecoration(boxShadow: [
                          BoxShadow(
                            offset: Offset(6, 9),
                            spreadRadius: 4,
                            blurRadius: 25,
                            color: Color.fromRGBO(25, 25, 25, 0.5),
                          )
                        ]),
                        child: RoundedButton(
                            size: size,
                            text: 'Sumbit',
                            color: darkColor,
                            textColor: orangeColor,
                            press: () {}),
                      ),
                    ]),
              ),
            ),
          );
        }));
  }

  InputDecoration customInputDecoration() {
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: orangeColor)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: orangeColor),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        border: OutlineInputBorder(
            borderSide: BorderSide(width: 2, color: orangeColor),
            borderRadius: BorderRadius.all(Radius.circular(15))));
  }

  void sumbit() {
    Navigator.of(context).pop();
  }

  Widget buildText1(user.User user) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                  child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showedit = !_showedit;
                    });
                  },
                  child: CircleAvatar(
                    radius: 35,
                  ),
                ),
              )),
            ),
            Expanded(
              flex: 4,
              child: GlassMorph(
                child: Column(children: [
                  SizedBox(
                    height: size.height / 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20.0, horizontal: 25),
                      child: _showedit ? editText(user) : buildText(user),
                    ),
                  )
                ]),
              ),
            )
          ],
        )
      ],
    );
  }

  Widget editText(user.User user) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: header1(orangeColor),
                  ),
                  Text(
                    user.role,
                    style: TextStyle(fontWeight: FontWeight.w300, fontSize: 16),
                  ),
                ],
              ),
              Spacer(),
            ],
          ),
          Spacer(),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            leading: Icon(Icons.question_mark),
            title: Text(
              'About',
              style: h1orange(),
            ),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                openDialogAbout('About');
              },
            ),
          ),
          Divider(
            thickness: 1,
          ),
          ListTile(
            dense: true,
            contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
            leading: Icon(Icons.lock),
            title: Text(
              'Passowrd',
              style: h1orange(),
            ),
            trailing: IconButton(
              icon: Icon(Icons.arrow_forward_ios_rounded),
              onPressed: () {
                openDialogPassword('input');
              },
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
