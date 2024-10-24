

class AcademicQuickTipsModelClass {
  final String id;
  final String chapterName;

  AcademicQuickTipsModelClass({required this.id, required this.chapterName});

  // Factory constructor to create an instance from JSON
  factory AcademicQuickTipsModelClass.fromJson(Map<String, dynamic> json) {
    return AcademicQuickTipsModelClass(
      id: json['id'] as String,
      chapterName: json['chapter_name'] as String,
    );
  }
}


class AcademicQuickTipsVideoClassModel {
  final String id;
  final String chapterId;
  final String part;
  final String scheduledDate;
  final String startTime;
  final String endTime;
  final String facultyId;
  final String language;
  final String password;
  final String status;
  final String vidUrl;
  final String chatUrl;
  final String sPv1;
  final String spt1;
  final String sPv2;
  final String spt2;
  final String sPv3;
  final String spt3;
  final String sPv4;
  final String spt4;
  final String sPv5;
  final String spt5;
  final String sPv6;
  final String spt6;
  final String sPv7;
  final String spt7;
  final String sPv8;
  final String spt8;
  final String sPv9;
  final String spt9;
  final String sPv10;
  final String spt10;

  AcademicQuickTipsVideoClassModel({
    required this.id,
    required this.chapterId,
    required this.part,
    required this.scheduledDate,
    required this.startTime,
    required this.endTime,
    required this.facultyId,
    required this.language,
    required this.password,
    required this.status,
    required this.vidUrl,
    required this.chatUrl,
    required this.sPv1,
    required this.spt1,
    required this.sPv2,
    required this.spt2,
    required this.sPv3,
    required this.spt3,
    required this.sPv4,
    required this.spt4,
    required this.sPv5,
    required this.spt5,
    required this.sPv6,
    required this.spt6,
    required this.sPv7,
    required this.spt7,
    required this.sPv8,
    required this.spt8,
    required this.sPv9,
    required this.spt9,
    required this.sPv10,
    required this.spt10,
  });

  factory AcademicQuickTipsVideoClassModel.fromJson(Map<String, dynamic> json) {
    return AcademicQuickTipsVideoClassModel(
      id: json['id'],
      chapterId: json['chapter_id'],
      part: json['part'],
      scheduledDate: json['scheduled_date'],
      startTime: json['start_time'],
      endTime: json['end_time'],
      facultyId: json['faculty_id'],
      language: json['language'],
      password: json['password'],
      status: json['status'],
      vidUrl: json['vid_url'],
      chatUrl: json['chat_url'],
      sPv1: json['s_pv1'],
      spt1: json['spt1'],
      sPv2: json['s_pv2'],
      spt2: json['spt2'],
      sPv3: json['s_pv3'],
      spt3: json['spt3'],
      sPv4: json['s_pv4'],
      spt4: json['spt4'],
      sPv5: json['s_pv5'],
      spt5: json['spt5'],
      sPv6: json['s_pv6'],
      spt6: json['spt6'],
      sPv7: json['s_pv7'],
      spt7: json['spt7'],
      sPv8: json['s_pv8'],
      spt8: json['spt8'],
      sPv9: json['s_pv9'],
      spt9: json['spt9'],
      sPv10: json['s_pv10'],
      spt10: json['spt10'],
    );
  }
}

