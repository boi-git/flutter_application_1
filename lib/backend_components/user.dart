class User {
  final String name;
  final String role;
  final String about;
  final String displayimage;
  final String backgroundimage;

  User(
      {required this.name,
      required this.role,
      required this.about,
      required this.backgroundimage,
      required this.displayimage});

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
        'about': about,
      };
  static User fromJson(Map<String, dynamic> json) => User(
        name: json['username'],
        role: json['role'],
        about: json['about'],
        backgroundimage: json['BackgroundImage'],
        displayimage: json['DisplayImage'],
      );
}

class Classes {
  final String coursecode;
  final String coursename;
  final String lectureid;
  final List<dynamic> members;

  Classes(
      {required this.coursecode,
      required this.coursename,
      required this.lectureid,
      required this.members});

  Map<String, dynamic> toJsonClasses() => {
        'coursecode': coursecode,
        'coursename': coursename,
        'lectureid': lectureid,
        // 'member': member,
      };

  static Classes fromJson(Map<String, dynamic> json) => Classes(
        coursecode: json['coursecode'],
        coursename: json['coursename'],
        lectureid: json['lectureid'],
        members: json['member'],
        // member: json[['member']]
      );
}
