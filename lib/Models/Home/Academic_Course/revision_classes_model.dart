class AcademicTheoryChapterModelClass {
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
  final String thumbnail;

  AcademicTheoryChapterModelClass({
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
    this.sPv3 = '',
    this.spt3 = '',
    this.sPv4 = '',
    this.spt4 = '',
    this.sPv5 = '',
    this.spt5 = '',
    this.sPv6 = '',
    this.spt6 = '',
    this.sPv7 = '',
    this.spt7 = '',
    this.sPv8 = '',
    this.spt8 = '',
    this.sPv9 = '',
    this.spt9 = '',
    this.sPv10 = '',
    this.spt10 = '',
    required this.thumbnail,
  });

  factory AcademicTheoryChapterModelClass.fromJson(Map<String, dynamic> json) {
    return AcademicTheoryChapterModelClass(
      id: json['id'] ?? '',
      chapterId: json['chapter_id'] ?? '',
      part: json['part'] ?? '',
      scheduledDate: json['scheduled_date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      facultyId: json['faculty_id'] ?? '',
      language: json['language'] ?? '',
      password: json['password'] ?? '',
      status: json['status'] ?? '',
      vidUrl: json['vid_url'] ?? '',
      chatUrl: json['chat_url'] ?? '',
      sPv1: json['s_pv1'] ?? '',
      spt1: json['spt1'] ?? '',
      sPv2: json['s_pv2'] ?? '',
      spt2: json['spt2'] ?? '',
      sPv3: json['s_pv3'] ?? '',
      spt3: json['spt3'] ?? '',
      sPv4: json['s_pv4'] ?? '',
      spt4: json['spt4'] ?? '',
      sPv5: json['s_pv5'] ?? '',
      spt5: json['spt5'] ?? '',
      sPv6: json['s_pv6'] ?? '',
      spt6: json['spt6'] ?? '',
      sPv7: json['s_pv7'] ?? '',
      spt7: json['spt7'] ?? '',
      sPv8: json['s_pv8'] ?? '',
      spt8: json['spt8'] ?? '',
      sPv9: json['s_pv9'] ?? '',
      spt9: json['spt9'] ?? '',
      sPv10: json['s_pv10'] ?? '',
      spt10: json['spt10'] ?? '',
      thumbnail: json['thubmbnail'] ?? '',
    );
  }

}


class AcademicRevisionVideoClassModel {
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

  AcademicRevisionVideoClassModel({
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
    this.sPv1 = '',
    this.spt1 = '',
    this.sPv2 = '',
    this.spt2 = '',
    this.sPv3 = '',
    this.spt3 = '',
    this.sPv4 = '',
    this.spt4 = '',
    this.sPv5 = '',
    this.spt5 = '',
    this.sPv6 = '',
    this.spt6 = '',
    this.sPv7 = '',
    this.spt7 = '',
    this.sPv8 = '',
    this.spt8 = '',
    this.sPv9 = '',
    this.spt9 = '',
    this.sPv10 = '',
    this.spt10 = '',
  });

  factory AcademicRevisionVideoClassModel.fromJson(Map<String, dynamic> json) {
    return AcademicRevisionVideoClassModel(
      id: json['id'] ?? '',
      chapterId: json['chapter_id'] ?? '',
      part: json['part'] ?? '',
      scheduledDate: json['scheduled_date'] ?? '',
      startTime: json['start_time'] ?? '',
      endTime: json['end_time'] ?? '',
      facultyId: json['faculty_id'] ?? '',
      language: json['language'] ?? '',
      password: json['password'] ?? '',
      status: json['status'] ?? '',
      vidUrl: json['vid_url'] ?? '',
      chatUrl: json['chat_url'] ?? '',
      sPv1: json['s_pv1'] ?? '',
      spt1: json['spt1'] ?? '',
      sPv2: json['s_pv2'] ?? '',
      spt2: json['spt2'] ?? '',
      sPv3: json['s_pv3'] ?? '',
      spt3: json['spt3'] ?? '',
      sPv4: json['s_pv4'] ?? '',
      spt4: json['spt4'] ?? '',
      sPv5: json['s_pv5'] ?? '',
      spt5: json['spt5'] ?? '',
      sPv6: json['s_pv6'] ?? '',
      spt6: json['spt6'] ?? '',
      sPv7: json['s_pv7'] ?? '',
      spt7: json['spt7'] ?? '',
      sPv8: json['s_pv8'] ?? '',
      spt8: json['spt8'] ?? '',
      sPv9: json['s_pv9'] ?? '',
      spt9: json['spt9'] ?? '',
      sPv10: json['s_pv10'] ?? '',
      spt10: json['spt10'] ?? '',
    );
  }

}
