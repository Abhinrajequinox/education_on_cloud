import 'dart:convert';
import 'dart:developer';
import 'package:education_on_cloud/Apis/Academic_Course/quick_tips_api.dart';
import 'package:education_on_cloud/Models/Home/Academic_Course/quick_tips_model.dart';
import 'package:http/http.dart'as http;

class AcademicQuickTipsServices {

  Future<List<AcademicQuickTipsModelClass>> fetchCourseChapters({
    required String courseId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(academicQuickTipsChapterApi),
        body: {
          'crs_id': courseId,
        },
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert the JSON response to a List<ChapterModel>
        return jsonResponse
            .map((section) => AcademicQuickTipsModelClass.fromJson(section))
            .toList();
      } else {
        throw Exception('Failed to load course chapters');
      }
    } catch (e) {
      print("Error fetching courses chapters: $e");
      return []; // Return an empty list on error
    }
  }
  

  Future<List<AcademicQuickTipsVideoClassModel>> fetchAcademicTheoryClass(
     {required String chaptId,required String language}) async {
    try {
      final response = await http.post(
        Uri.parse(acdemicQuickTipsVideoClassApi),
        body: {
          'chap_id': chaptId,
          'lang':"English"
        },
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert the JSON response to a List<CourseSection>
        return jsonResponse
            .map((section) => AcademicQuickTipsVideoClassModel.fromJson(section))
            .toList();
      } else {
        throw Exception('Failed to load revision classes');
      }
    } catch (e) {
      log("Error fetching revision classes: $e");
      return []; // Return an empty list on error
    }
  }

  
}