import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart'as http;
import 'package:education_on_cloud/Apis/Academic_Course/revesion_classes_Api.dart';
import 'package:education_on_cloud/Models/Home/Academic_Course/Revision_classes_model.dart';

class RevisionClassesServices {

  Future<List<AcademicTheoryChapterModelClass>> fetchAcademicTheoryClass(
     {required String chaptId,required String language}) async {
    try {
      final response = await http.post(
        Uri.parse(revisionClassApi),
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
            .map((section) => AcademicTheoryChapterModelClass.fromJson(section))
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

