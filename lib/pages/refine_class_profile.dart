// ignore_for_file: prefer_const_constructors, no_logic_in_create_state

import 'dart:io';
import 'package:flutter_application_1/components/constants/importstaff.dart';
import '../backend_components/user.dart' as user;

class ClassBackDetailRefined extends StatefulWidget {
  final String coursename;
  const ClassBackDetailRefined({super.key, required this.coursename});

  @override
  State<ClassBackDetailRefined> createState() =>
      _ClassBackDetailRefinedState(coursename);
}

class _ClassBackDetailRefinedState extends State<ClassBackDetailRefined> {
  TextEditingController aboutController = TextEditingController();
  final NavigationService _navigationService = locator<NavigationService>();
  String userID = "";
  //Size size = Size(1, 1);
  bool _showedit = false;
  bool _showsubmenu = true;
  String _selecteduser = '1000124';
  String uname = '';
  String about = '';
  String role = '';
  late String coursename;
  File? _imageDpFile;
  File? _imageBgFile;
  String url = '';
  bool typeofImage = true;

  final futureClassDetails = getDataClass('CSCI 1303');
  //final futureUserDetails =
  _ClassBackDetailRefinedState(this.coursename);

  // #region //TodoCreate Seperate Folder
  Future upImage(File image, String folder) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child(folder)
        .child(coursename + ' ' + folder + '.jpg');
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(),
      body: FutureBuilder(
        future: futureClassDetails,
        builder: ((context, snapshot) {
          Size size = MediaQuery.of(context).size;
          if (snapshot.hasError) {
            return Text('Error : ${snapshot.error}');
          } else if (snapshot.hasData) {
            final classfield = snapshot.data!;

            return FutureBuilder(
              future: getData(_selecteduser),
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Error : ${snapshot.error}');
                } else if (snapshot.hasData) {
                  final userfield = snapshot.data!;

                  return Container(
                    decoration: BoxDecoration(
                        // image: DecorationImage(image: )
                        color: darkColor),
                    child: Scaffold(
                      resizeToAvoidBottomInset: false,
                      backgroundColor: Colors.transparent,
                      body: SafeArea(
                        child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //!Left Side
                                    Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        height: size.height / 1.1115,
                                        child: Column(
                                          children: [
                                            Expanded(
                                              flex: 1,
                                              child: Container(),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: SizedBox(
                                                height: size.height / 2,
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(top: 20),
                                                        child: SizedBox(
                                                            // height: size.height / 5,
                                                            width:
                                                                size.width / 5,
                                                            child: CircleAvatar(
                                                              radius: 35,
                                                              backgroundColor:
                                                                  orangeColor,
                                                              child: Text(
                                                                classfield
                                                                    .coursecode,
                                                              ),
                                                            )),
                                                      ),
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        child: Container(
                                                          height: size.height /
                                                              3.25,
                                                          //  color: whitecolor,
                                                          child:
                                                              ListView.builder(
                                                            itemCount:
                                                                classfield
                                                                    .members
                                                                    .length,
                                                            itemBuilder:
                                                                ((context,
                                                                    index) {
                                                              return Padding(
                                                                padding: const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        3.0),
                                                                child:
                                                                    GestureDetector(
                                                                  onTap: () {
                                                                    print(classfield
                                                                            .members[
                                                                        index]);
                                                                    setState(
                                                                        () {
                                                                      _selecteduser = classfield
                                                                          .members[
                                                                              index]
                                                                          .toString();
                                                                    });
                                                                  },
                                                                  child: CircleAvatar(
                                                                      radius:
                                                                          25,
                                                                      child: Text(classfield
                                                                          .members[
                                                                              index]
                                                                          .toString())),
                                                                ),
                                                              );
                                                            }),
                                                          ),
                                                        )),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Container(
                                        height: size.height / 1.1115,
                                        child: Stack(
                                          children: [
                                            Container(
                                              height: size.height / 1.1115,
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  height: size.height / 2.51,
                                                ),
                                                GlassMorph(
                                                  child: Column(
                                                    children: [
                                                      SizedBox(
                                                        width: double.infinity,
                                                        height: size.height / 2,
                                                        child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .symmetric(
                                                                    vertical:
                                                                        20,
                                                                    horizontal:
                                                                        25),
                                                            child: buildText(
                                                                userfield)),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            )),
                      ),
                    ),
                  );
                } else {
                  return Center(
                      child: CircularProgressIndicator(
                    color: orangeColor,
                  ));
                }
              }),
            ); //Users Stream
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: darkColor,
            ));
          }
        }),
      ), //Class Stream
    );
  }
}
