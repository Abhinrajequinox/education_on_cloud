import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:education_on_cloud/Apis/apis.dart';
import 'package:education_on_cloud/Models/Home/academic_course_model.dart';
class HomeScreenServices {
  Future<List<FacultyModel>> fetchFaculities() async {
    try {
      final response = await http.post(
        Uri.parse(faculity_Api),
        body: {},
      );

      if (response.statusCode == 200) {
        // If the server returns a 200 OK response, parse the JSON.
        List<dynamic> jsonResponse = jsonDecode(response.body);

        // Convert the JSON response to a List<CourseSection>
        return jsonResponse
            .map((section) => FacultyModel.fromJson(section))
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
