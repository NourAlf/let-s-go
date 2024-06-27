import 'dart:convert';

class AddStudentModel {
  final String id;
  final String student_code;
  final String school_id;
  final String name;
  final String level;
  final String branch;
  final String birthdate;
  final String nationality;
  final List<String> days;
  final String out_time;
  final String comming_time;
  final bool out_alarm;
  final bool comming_alarm;
  final String h_center;
  final String height;
  final String weight;
  final String illnes_type;
  final String symptoms;
  final String first_aid;

  AddStudentModel({
    required this.id,
    required this.student_code,
    required this.school_id,
    required this.name,
    required this.level,
    required this.branch,
    required this.birthdate,
    required this.nationality,
    required this.days,
    required this.out_time,
    required this.comming_time,
    required this.out_alarm,
    required this.comming_alarm,
    required this.h_center,
    required this.height,
    required this.weight,
    required this.illnes_type,
    required this.symptoms,
    required this.first_aid,
  });

  // دالة لمعالجة السلسلة النصية للأيام بغض النظر عن الصيغة
  static List<String> parseDays(String daysString) {
    try {
      // محاولة فك الترميز مباشرةً
      return List<String>.from(jsonDecode(daysString));
    } catch (e) {
      // إذا فشل فك الترميز، معالجة السلسلة النصية
      daysString = daysString.replaceAll('[', '["').replaceAll(']', '"]').replaceAll(', ', '","');
      return List<String>.from(jsonDecode(daysString));
    }
  }

  factory AddStudentModel.fromJson(Map<String, dynamic> json) {
    String daysString = json['days'];
    daysString = daysString.replaceAll('[', '["').replaceAll(']', '"]').replaceAll(', ', '","');

    return AddStudentModel(
      id: json['id'].toString(),
      student_code: json['student_code'].toString(),
      school_id: json['school_id'].toString(),
      name: json['name'].toString(),
      level: json['level'].toString(),
      branch: json['branch'].toString(),
      birthdate: json['birthdate'].toString(),
      nationality: json['nationality'].toString(),
      days: parseDays(json['days']),
      out_time: json['out_time'].toString(),
      comming_time: json['comming_time'].toString(),
      out_alarm: json['out_alarm'] == 1,
      comming_alarm: json['Comming_alarm'] == 1,
      h_center: json['h_center'].toString(),
      height: json['height'].toString(),
      weight: json['weight'].toString(),
      illnes_type: json['illnes_type'].toString(),
      symptoms: json['symptoms'].toString(),
      first_aid: json['first_aid'].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'student_code': student_code,
      'school_id': school_id,
      'name': name,
      'level': level,
      'branch': branch,
      'birthdate': birthdate,
      'nationality': nationality,
      'days': jsonEncode(days),
      'out_time': out_time,
      'comming_time': comming_time,
      'out_alarm': out_alarm ? "1" : "0",
      'comming_alarm': comming_alarm ? "1" : "0",
      'h_center': h_center,
      'height': height,
      'weight': weight,
      'illnes_type': illnes_type,
      'symptoms': symptoms,
      'first_aid': first_aid,
    };
  }
}
