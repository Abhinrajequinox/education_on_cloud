class AcademicChaptersTopicsModel {
  final String id;
  final String courseId;
  final String chapterName;
  final String enotes;
  final String prevVid;
  final String chapterIcon;
  final int type;
  final String level;
  final int count;

  AcademicChaptersTopicsModel({
    required this.id,
    required this.courseId,
    required this.chapterName,
    required this.enotes,
    required this.prevVid,
    required this.chapterIcon,
    required this.type,
    required this.level,
    required this.count,
  });

  // Factory constructor to create an instance from JSON
  factory AcademicChaptersTopicsModel.fromJson(Map<String, dynamic> json) {
    return AcademicChaptersTopicsModel(
      id: json['id'] as String,
      courseId: json['course_id'] as String,
      chapterName: json['chapter_name'] as String,
      enotes: json['enotes'] as String,
      prevVid: json['prev_vid'] as String,
      chapterIcon: json['chapter_icon'] as String,
      type: json['type'] as int,
      level: json['level'] as String,
      count: json['count'] as int,
    );
  }
}
