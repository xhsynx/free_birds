import 'dart:convert';
import 'api_service.dart';

class ExamService {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getExams() async {
    final response = await _apiService.get('/Exam');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load exams');
  }

  Future<Map<String, dynamic>> createExam(Map<String, dynamic> data) async {
    final response = await _apiService.post('/Exam', data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to create exam');
  }

  Future<Map<String, dynamic>> getExamById(String id) async {
    final response = await _apiService.get('/Exam/$id');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load exam');
  }

  Future<Map<String, dynamic>> updateExam(
      String id, Map<String, dynamic> data) async {
    final response = await _apiService.put('/Exam/$id', data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to update exam');
  }

  Future<void> deleteExam(String id) async {
    final response = await _apiService.delete('/Exam/$id');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete exam');
    }
  }

  Future<List<dynamic>> getExamsByClass(String classId) async {
    final response = await _apiService.get('/Exam/class/$classId');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load exams for class');
  }

  Future<List<dynamic>> getExamsByTeacher(String teacherId) async {
    final response = await _apiService.get('/Exam/teacher/$teacherId');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load exams for teacher');
  }

  Future<void> toggleExamStatus(String id) async {
    final response = await _apiService.patch('/Exam/$id/toggle-status', {});
    if (response.statusCode != 200) {
      throw Exception('Failed to toggle exam status');
    }
  }
}
