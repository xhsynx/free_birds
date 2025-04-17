import 'dart:convert';
import 'api_service.dart';

class LogService {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getLogs() async {
    final response = await _apiService.get('/Log/list');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load logs');
  }

  Future<Map<String, dynamic>> getLogById(String id) async {
    final response = await _apiService.get('/Log/$id');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load log');
  }

  Future<List<dynamic>> getLogsByLevel(String level) async {
    final response = await _apiService.get('/Log/level/$level');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load logs by level');
  }

  Future<List<dynamic>> getLogsByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final response = await _apiService.get(
        '/Log/date-range?startDate=${startDate.toIso8601String()}&endDate=${endDate.toIso8601String()}');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load logs by date range');
  }
}
