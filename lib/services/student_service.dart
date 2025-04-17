import 'dart:convert';
import 'api_service.dart';

class StudentService {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getStudents() async {
    final response = await _apiService.get('/Students/list');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load students');
  }

  Future<Map<String, dynamic>> getStudentById(String id) async {
    final response = await _apiService.get('/Students/$id');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load student');
  }

  Future<Map<String, dynamic>> updateStudent(
      String id, Map<String, dynamic> data) async {
    final response = await _apiService.put('/Students/$id', data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to update student');
  }

  Future<void> deleteStudent(String id) async {
    final response = await _apiService.delete('/Students/$id');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete student');
    }
  }

  Future<Map<String, dynamic>> createStudent(Map<String, dynamic> data) async {
    final response = await _apiService.post('/Students/create', data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to create student');
  }
}
