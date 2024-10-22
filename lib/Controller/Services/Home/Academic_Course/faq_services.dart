import 'dart:convert';
import 'dart:developer';
import 'package:education_on_cloud/Apis/Academic_Course/faq_api.dart';
import 'package:education_on_cloud/Models/Home/Academic_Course/faq_model.dart';
import 'package:http/http.dart'as http;
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';

class AcademicFaqServices {

   Future<List<ChapterModel>> fetchCourseChapters({
    required String courseId,
    required String language,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(academicFaqChapterApi),
        body: {
          'crs_id': courseId,
          'lang': language,
        },
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert the JSON response to a List<ChapterModel>
        return jsonResponse
            .map((section) => ChapterModel.fromJson(section))
            .toList();
      } else {
        throw Exception('Failed to load course chapters');
      }
    } catch (e) {
      print("Error fetching courses chapters: $e");
      return []; // Return an empty list on error
    }
  }


  Future<List<ChapterSubTopicModel>> fetchChaptersSubtopics({
    required String chapId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(acdemicFaqSubtopicApi),
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


  Future<List<AcademicFaqEnoteModel>> fetchFaqs({
    required String id,
    required String noteType,
  }) async {
    try {
      log(noteType);
      final response = await http.post(
        Uri.parse(
            acdemicFaqNotes), // Replace with your actual API endpoint
        body: {
          'id': id,
          'type': noteType,
        },
      );

      if (response.statusCode == 200) {
        // Log the response body for debugging
        log('Response body: ${response.body}');

        // Parse the JSON response
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Check for the sections key
        if (jsonResponse.containsKey('sections')) {
          // Directly map the sections to the model
          return [
            AcademicFaqEnoteModel.fromJson(jsonResponse)
          ]; // Wrap it in a list since the model expects a List
        } else {
          throw Exception('No academic chapters data found in the response');
        }
      } else {
        throw Exception('Failed to load academic chapters');
      }
    } catch (e) {
      log("Error fetching academic chapters: $e");
      return []; // Return an empty list on error
    }
  }
  
}