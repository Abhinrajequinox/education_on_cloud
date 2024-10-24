class AcademicTopiTestChapterModel {
  final String id;
  final String courseId;
  final String chapterName;
  final String enotes;
  final String prevVid;
  final String chapterIcon;
  final int type;
  final String level;
  final String randomDate;
  final int count;

  AcademicTopiTestChapterModel({
    required this.id,
    required this.courseId,
    required this.chapterName,
    required this.enotes,
    required this.prevVid,
    required this.chapterIcon,
    required this.type,
    required this.level,
    required this.randomDate,
    required this.count,
  });

  // Factory method to create a new instance from JSON
  factory AcademicTopiTestChapterModel.fromJson(Map<String, dynamic> json) {
    return AcademicTopiTestChapterModel(
      id: json['id'] as String,
      courseId: json['course_id'] as String,
      chapterName: json['chapter_name'] as String,
      enotes: json['enotes'] as String? ?? '',
      prevVid: json['prev_vid'] as String? ?? '',
      chapterIcon: json['chapter_icon'] as String,
      type: json['type'] as int,
      level: json['level'] as String? ?? '',
      randomDate: json['random_date'] as String,
      count: json['count'] as int,
    );
  }
}


class AcademicTopicTestSubTopicModel {
  final String id;
  final String subTopics;

  AcademicTopicTestSubTopicModel({
    required this.id,
    required this.subTopics,
  });

  // Factory method to create a new instance from JSON
  factory AcademicTopicTestSubTopicModel.fromJson(Map<String, dynamic> json) {
    return AcademicTopicTestSubTopicModel(
      id: json['id'] as String,
      subTopics: json['sub_topics'] as String,
    );
  }
}

class AcdemicTopicTestFetchScoreCardModel {
  String id;
  String chapId;
  String chapName;
  String mob;
  String date;
  String time;
  String topicId;
  String score;

  AcdemicTopicTestFetchScoreCardModel({
    required this.id,
    required this.chapId,
    required this.chapName,
    required this.mob,
    required this.date,
    required this.time,
    required this.topicId,
    required this.score,
  });

  // Factory method to create an instance from JSON
  factory AcdemicTopicTestFetchScoreCardModel.fromJson(Map<String, dynamic> json) {
    return AcdemicTopicTestFetchScoreCardModel(
      id: json['id'] as String,
      chapId: json['chap_id'] as String,
      chapName: json['chap_name'] as String,
      mob: json['mob'] as String,
      date: json['date'] as String,
      time: json['time'] as String,
      topicId: json['topic_id'] as String,
      score: json['score'] as String,
    );
  }
}
