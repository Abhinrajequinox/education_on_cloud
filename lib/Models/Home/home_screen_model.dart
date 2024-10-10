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

  // Factory constructor to create an instance from JSON
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

  // Method to convert an instance back to JSON
  
}

