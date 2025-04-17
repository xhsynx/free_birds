import 'dart:convert';
import 'api_service.dart';

class ParentService {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getParents() async {
    final response = await _apiService.get('/Parents/list');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load parents');
  }

  Future<Map<String, dynamic>> getParentById(String id) async {
    final response = await _apiService.get('/Parents/$id');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load parent');
  }

  Future<Map<String, dynamic>> updateParent(
      String id, Map<String, dynamic> data) async {
    final response = await _apiService.put('/Parents/$id', data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to update parent');
  }

  Future<void> deleteParent(String id) async {
    final response = await _apiService.delete('/Parents/$id');
    if (response.statusCode != 200) {
      throw Exception('Failed to delete parent');
    }
  }

  Future<Map<String, dynamic>> createParent(Map<String, dynamic> data) async {
    final response = await _apiService.post('/Parents/create', data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to create parent');
  }
}
