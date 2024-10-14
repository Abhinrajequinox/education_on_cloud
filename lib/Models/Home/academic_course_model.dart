
  // Model for the course category


class CourseCategoryModel {
  final String id;
  final String categoryName;
  final String img;
  final String description;
  final String section;
  final String price;
  final String discPrice;
  final String promoVid;
  final String noOfCourses;

  CourseCategoryModel({
    required this.id,
    required this.categoryName,
    required this.img,
    required this.description,
    required this.section,
    required this.price,
    required this.discPrice,
    required this.promoVid,
    required this.noOfCourses,
  });

  factory CourseCategoryModel.fromJson(Map<String, dynamic> json) {
    return CourseCategoryModel(
      id: json['id'],
      categoryName: json['category_name'],
      img: json['img'],
      description: json['description'],
      section: json['section'],
      price: json['price'],
      discPrice: json['disc_price'],
      promoVid: json['promo_vid'] ?? '',
      noOfCourses: json['no_of_courses'] ?? '',
    );
  }
}

  // Model for the course session 



class CourseSectionModel {
  final String sectionId;
  final String sectionName;
  final String img;

  CourseSectionModel({required this.sectionId, required this.sectionName, required this.img});

  factory CourseSectionModel.fromJson(Map<String, dynamic> json) {
    return CourseSectionModel(
      sectionId: json['section_id'] as String,
      sectionName: json['section_name'] as String,
      img: json['img'] as String,
    );
  }
}


  // Model for the faculities on the last of Homescreeen


class FacultyModel {
  String? id;
  String? facultyName;
  String? language;
  String? bio;
  String? photo;
  String? username;
  String? password;
  String? otherLanguages;
  String? qualification;
  String? skills;
  String? age;
  String? channelId;
  String? apiKey;
  String? clientId;
  String? courses;
  String? batchName;

  FacultyModel({
    this.id,
    this.facultyName,
    this.language,
    this.bio,
    this.photo,
    this.username,
    this.password,
    this.otherLanguages,
    this.qualification,
    this.skills,
    this.age,
    this.channelId,
    this.apiKey,
    this.clientId,
    this.courses,
    this.batchName,
  });


  factory FacultyModel.fromJson(Map<String, dynamic> json) {
    return FacultyModel(
      id: json['id'],
      facultyName: json['faculty_name'],
      language: json['language'],
      bio: json['bio'],
      photo: json['photo'],
      username: json['username'],
      password: json['password'],
      otherLanguages: json['other_languages'],
      qualification: json['qualification'],
      skills: json['skills'],
      age: json['age'],
      channelId: json['channel_id'],
      apiKey: json['api_key'],
      clientId: json['client_id'],
      courses: json['courses'],
      batchName: json['batch_name'],
    );
  }
}

// model class of course screen 


class CourseModel {
  String id;
  String courseName;
  String createdDate;
  String tag;
  String description;
  String img;
  String courseDuration;
  String skills;
  String requirement;
  String courseFor;
  String categoryId;
  String examId;
  String qBank;
  String cost;
  String frCost;
  String skill;
  String noChapter;
  String costPerChapter;
  String noHrs;
  String promoVid;
  String preview;
  String hrsOfExerciseSolution;
  String hrsOfPracticalClasses;
  String noOfEnotes;
  String hrsOfRevisionClasses;
  String noOfQuickTips;
  String noOfMockExam;
  String noOfPrevYearQnPaper;
  String noOfFaq;
  String type;
  String color;

  CourseModel({
    required this.id,
    required this.courseName,
    required this.createdDate,
    required this.tag,
    required this.description,
    required this.img,
    required this.courseDuration,
    required this.skills,
    required this.requirement,
    required this.courseFor,
    required this.categoryId,
    required this.examId,
    required this.qBank,
    required this.cost,
    required this.frCost,
    required this.skill,
    required this.noChapter,
    required this.costPerChapter,
    required this.noHrs,
    required this.promoVid,
    required this.preview,
    required this.hrsOfExerciseSolution,
    required this.hrsOfPracticalClasses,
    required this.noOfEnotes,
    required this.hrsOfRevisionClasses,
    required this.noOfQuickTips,
    required this.noOfMockExam,
    required this.noOfPrevYearQnPaper,
    required this.noOfFaq,
    required this.type,
    required this.color,
  });

  // fromJson method to parse JSON data
  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] ?? '',
      courseName: json['course_name'] ?? '',
      createdDate: json['created_date'] ?? '',
      tag: json['tag'] ?? '',
      description: json['description'] ?? '',
      img: json['img'] ?? '',
      courseDuration: json['course_duration'] ?? '',
      skills: json['skills'] ?? '',
      requirement: json['requirment'] ?? '',
      courseFor: json['course_for'] ?? '',
      categoryId: json['category_id'] ?? '',
      examId: json['exam_id'] ?? '',
      qBank: json['q_bank'] ?? '',
      cost: json['cost'] ?? '',
      frCost: json['fr_cost'] ?? '',
      skill: json['skill'] ?? '',
      noChapter: json['no_chapter'] ?? '',
      costPerChapter: json['costperchapter'] ?? '',
      noHrs: json['nohrs'] ?? '',
      promoVid: json['promovid'] ?? '',
      preview: json['preview'] ?? '',
      hrsOfExerciseSolution: json['hrs_of_excercise_solution'] ?? '',
      hrsOfPracticalClasses: json['hrs_of_practical_classes'] ?? '',
      noOfEnotes: json['no_of_enotes'] ?? '',
      hrsOfRevisionClasses: json['hrs_of_revision_classes'] ?? '',
      noOfQuickTips: json['no_of_quick_tips'] ?? '',
      noOfMockExam: json['no_of_mock_exam'] ?? '',
      noOfPrevYearQnPaper: json['no_of_prev_year_qn_paper'] ?? '',
      noOfFaq: json['no_of_faq'] ?? '',
      type: json['type'] ?? '',
      color: json['color'] ?? '',
    );
  }
}
class ChapterModel {
  final String id;
  final String courseId;
  final String chapterName;
  final String enotes;
  final String prevVid;
  final String chapterIcon;
  final int type;
  final String level;
  final int count;

  ChapterModel({
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

  factory ChapterModel.fromJson(Map<String, dynamic> json) {
    return ChapterModel(
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
