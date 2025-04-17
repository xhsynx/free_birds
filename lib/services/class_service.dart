import 'dart:convert';
import 'api_service.dart';

class ClassService {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getClasses() async {
    final response = await _apiService.get('/Classes/list');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load classes');
  }

  Future<Map<String, dynamic>> getClassById(String id) async {
    final response = await _apiService.get('/Classes/$id');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load class');
  }

  Future<Map<String, dynamic>> updateClass(
      String id, Map<String, dynamic> data) async {
    final response = await _apiService.put('/Classes/$id', data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to update class');
  }

  Future<void> deleteClass(String id) async {
    final response = await _apiService.delete('/Classes/$id');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete class');
    }
  }

  Future<Map<String, dynamic>> createClass(Map<String, dynamic> data) async {
    final response = await _apiService.post('/Classes/create', data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to create class');
  }
}
