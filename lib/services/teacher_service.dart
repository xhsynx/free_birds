import 'dart:convert';
import 'api_service.dart';

class TeacherService {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getTeachers() async {
    final response = await _apiService.get('/Teachers/list');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load teachers');
  }

  Future<Map<String, dynamic>> getTeacherById(String id) async {
    final response = await _apiService.get('/Teachers/$id');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load teacher');
  }

  Future<Map<String, dynamic>> updateTeacher(
      String id, Map<String, dynamic> data) async {
    final response = await _apiService.put('/Teachers/$id', data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to update teacher');
  }

  Future<void> deleteTeacher(String id) async {
    final response = await _apiService.delete('/Teachers/$id');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete teacher');
    }
  }

  Future<Map<String, dynamic>> createTeacher(Map<String, dynamic> data) async {
    final response = await _apiService.post('/Teachers/create', data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to create teacher');
  }
}
