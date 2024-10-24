import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:education_on_cloud/Apis/Academic_Course/topic_test_api.dart';
import 'package:education_on_cloud/Models/Home/Academic_Course/topic_test_model.dart';
import 'package:http/http.dart' as http;

class AcdemicTopicTestServices {
  Future<List<AcademicTopiTestChapterModel>> fetchCourseChapters({
    required String courseId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(acdemicTopicTestChapterApi),
        body: {
          'crs_id': courseId,
        },
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert the JSON response to a List<ChapterModel>
        return jsonResponse
            .map((section) => AcademicTopiTestChapterModel.fromJson(section))
            .toList();
      } else {
        throw Exception('Failed to load course chapters');
      }
    } catch (e) {
      print("Error fetching courses chapters: $e");
      return []; // Return an empty list on error
    }
  }

  Future<List<AcademicTopicTestSubTopicModel>> fetchSubTopics({
    required String chapterId,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(academicTopicTestSubtopicApi),
        body: {
          'chap_id': chapterId,
        },
      );

      if (response.statusCode == 200) {
        // Decode the response body
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);

        // Now, access the 'data' key which contains the list of subtopics
        if (jsonResponse.containsKey('data')) {
          List<dynamic> subtopicsList = jsonResponse['data'];

          // Convert the list to List<AcademicTopicTestSubTopicModel>
          return subtopicsList
              .map(
                  (section) => AcademicTopicTestSubTopicModel.fromJson(section))
              .toList();
        } else {
          throw Exception('Subtopics not found in response');
        }
      } else {
        throw Exception('Failed to load course chapters');
      }
    } catch (e) {
      print("Error fetching course subtopics: $e");
      return []; // Return an empty list on error
    }
  }

  Future<AcdemicTopicTestFetchScoreCardModel?> fetchScoreCard({
    required String courseId,
    required String mobileNumber,
    required String topicId,
  }) async {
    log('the course id is ${courseId}');
    log('the topic id is ${topicId}');
    try {
      final response = await http.post(
        Uri.parse(acdemicTopicTestFetchScoreCardApi),
        body: {
          'mob': mobileNumber,
          'crs_id': courseId,
          'topic_id': topicId,
        },
      ).timeout(Duration(seconds: 30)); // Adding timeout
      log('this is the reponce of scorecard${response.body.toString()}');
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        if (jsonResponse == 0) {
          return null;
        }

        return AcdemicTopicTestFetchScoreCardModel.fromJson(jsonResponse);
      } else {
        throw Exception('Failed to load score card');
      }
    } on SocketException catch (e) {
      log("Network issue: $e");
      // Handle network error
      return null;
    } on TimeoutException catch (e) {
      log("Timeout: $e");
      // Handle timeout
      return null;
    } on Exception catch (e) {
      log("General error: $e");
      // Handle other errors
      return null;
    }
  }
}
