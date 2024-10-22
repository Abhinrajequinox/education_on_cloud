class AcademicFaqEnoteModel {
  final List<String> sections;

  AcademicFaqEnoteModel({required this.sections});

  factory AcademicFaqEnoteModel.fromJson(Map<String, dynamic> json) {
    return AcademicFaqEnoteModel(
      sections: List<String>.from(json['sections']),
    );
  }

}