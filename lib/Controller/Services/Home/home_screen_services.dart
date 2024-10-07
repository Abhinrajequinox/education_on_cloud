import 'dart:convert';
import 'dart:developer';

import 'package:education_on_cloud/Apis/apis.dart';
import 'package:education_on_cloud/Models/Home/home_screen_model.dart';
import 'package:http/http.dart' as http;

class HomeScreenServices {
  Future<List<CourseCategoryModel>?> fetchCourseCategories() async {
    try {
      final response = await http.get(Uri.parse(course_category_Api));

      // Log the raw response for debugging
      log('Response body: ${response.body}');

      // Check if the response status code is OK
      if (response.statusCode == 200) {
        // Check if the response body is not empty
        if (response.body.isNotEmpty) {
          // Directly decode the JSON response
          var jsonResponse = json.decode(response.body);

          // If the response is expected to be a list, ensure it's treated as such
          if (jsonResponse is List) {
            // Return the list of CourseCategory objects
            log('Fetch successful: $jsonResponse');
            return jsonResponse
                .map<CourseCategoryModel>((json) => CourseCategoryModel.fromJson(json))
                .toList();
          } else {
            log('Unexpected response format: $jsonResponse');
            return null; // Or handle unexpected response formats differently
          }
        } else {
          log('Empty response body.');
          return []; // Return an empty list if no data is available
        }
      } else {
        // Log the error based on status code
        log('Error fetching categories: ${response.statusCode}');
        return null; // Return null to indicate failure
      }
    } catch (e) {
      log('Error: $e');
      return null; // Return null on exception
    }
  }

  Future<List<CourseSectionModel>> fetchCoursesSection(String country) async {
    try {
      final response = await http.post(
        Uri.parse(course_section_Api),
        body: {
          'country': country,
        },
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert the JSON response to a List<CourseSection>
        return jsonResponse
            .map((section) => CourseSectionModel.fromJson(section))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Error fetching courses: $e");
      return []; // Return an empty list on error
    }
  }

  Future<List<CourseCategoryModel>> fetchCoursesCategory(String sessionId) async {
    try {
      final response = await http.post(
        Uri.parse(course_category_Api),
        body: {
          'section_id': sessionId,
        },
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert the JSON response to a List<CourseSection>
        return jsonResponse
            .map((section) => CourseCategoryModel.fromJson(section))
            .toList();
      } else {
        throw Exception('Failed to load courses');
      }
    } catch (e) {
      print("Error fetching courses: $e");
      return []; // Return an empty list on error
    }
  }
}
