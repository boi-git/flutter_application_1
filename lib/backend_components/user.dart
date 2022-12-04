class User {
  final String name;
  final String role;

  User({
    required this.name,
    required this.role,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'role': role,
      };
  static User fromJson(Map<String, dynamic> json) => User(
        name: json['username'],
        role: json['role'],
      );
}

class Classes {
  final String coursecode;
  final String coursename;
  final String lectureid;

  Classes({
    required this.coursecode,
    required this.coursename,
    required this.lectureid,
  });

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
        // member: json[['member']]
      );
}
