import 'dart:convert';
import 'package:education_on_cloud/Models/Home/Academic_Course/chapters_model.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
import 'package:http/http.dart' as http;
import 'package:education_on_cloud/Apis/Academic_Course/chapters_api.dart';

class AcademicChaptersServices {
  Future<List<ChapterSubTopicModel>> fetchCourseChapters({
    required String chapId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(academicChaptersSubtopicApi),
        body: {
          'chap_id': chapId,
        },
      );

      if (response.statusCode == 200) {
        // Parse the JSON response
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Assuming the relevant data is under a key like "data" or "chapters"
        if (jsonResponse.containsKey('data')) {
          List<dynamic> chapterData = jsonResponse['data'];

          // Convert the JSON list to a List<ChapterSubTopicModel>
          return chapterData
              .map((section) => ChapterSubTopicModel.fromJson(section))
              .toList();
        } else {
          // Handle unexpected structure
          throw Exception('No chapters data found in the response');
        }
      } else {
        throw Exception('Failed to load course chapters');
      }
    } catch (e) {
      print("Error fetching courses chapters: $e");
      return []; // Return an empty list on error
    }
  }
}
