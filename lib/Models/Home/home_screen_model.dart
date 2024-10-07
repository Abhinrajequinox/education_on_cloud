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


// class CourseCategory {
//   final String id;
//   final String categoryName;
//   final String img;
//   final String description;
//   final String section;
//   final String price;
//   final String discPrice;
//   final String promoVid;
//   final String noOfCourses;

//   CourseCategory({
//     required this.id,
//     required this.categoryName,
//     required this.img,
//     required this.description,
//     required this.section,
//     required this.price,
//     required this.discPrice,
//     required this.promoVid,
//     required this.noOfCourses,
//   });

//   // Factory method to create an instance of the class from JSON
//   factory CourseCategory.fromJson(Map<String, dynamic> json) {
//     return CourseCategory(
//       id: json['id'],
//       categoryName: json['category_name'],
//       img: json['img'],
//       description: json['description'],
//       section: json['section'],
//       price: json['price'],
//       discPrice: json['disc_price'],
//       promoVid: json['promo_vid'] ?? '', // Optional, default to empty string
//       noOfCourses: json['no_of_courses'] ?? '', // Optional, default to empty string
//     );
//   }
// }
