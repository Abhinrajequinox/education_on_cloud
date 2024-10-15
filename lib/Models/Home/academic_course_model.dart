
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


class AcademicMenuStructureModel {
  final int theoryClasses;
  final int computerClasses;
  final int onlineClasses;
  final int enotes;
  final int exerciseSolution;
  final int practicals;
  final int quickTips;
  final int examPapers;
  final int revisionClasses;
  final int exams;
  final int chapterTest;
  final int onlineTest;
  final int chats;

  // Constructor
  AcademicMenuStructureModel({
    required this.theoryClasses,
    required this.computerClasses,
    required this.onlineClasses,
    required this.enotes,
    required this.exerciseSolution,
    required this.practicals,
    required this.quickTips,
    required this.examPapers,
    required this.revisionClasses,
    required this.exams,
    required this.chapterTest,
    required this.onlineTest,
    required this.chats,
  });

  // fromJson method to convert JSON into an AcademicMenuStructure object
  factory AcademicMenuStructureModel.fromJson(Map<String, dynamic> json) {
    return AcademicMenuStructureModel(
      theoryClasses: json['theory_classes'] ?? 0,
      computerClasses: json['computer_classes'] ?? 0,
      onlineClasses: json['online_classes'] ?? 0,
      enotes: json['Enotes'] ?? 0,
      exerciseSolution: json['excercise_solution'] ?? 0,
      practicals: json['practicals'] ?? 0,
      quickTips: json['quick_tips'] ?? 0,
      examPapers: json['exam_papers'] ?? 0,
      revisionClasses: json['revision_classes'] ?? 0,
      exams: json['exams'] ?? 0,
      chapterTest: json['chapter_test'] ?? 0,
      onlineTest: json['online_test'] ?? 0,
      chats: json['chats'] ?? 0,
    );
  }
}

class AcademicTheoryClassModel {
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

  AcademicTheoryClassModel({
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

  factory AcademicTheoryClassModel.fromJson(Map<String, dynamic> json) {
    return AcademicTheoryClassModel(
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


