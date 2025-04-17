import 'dart:convert';
import 'api_service.dart';

class UserService {
  final ApiService _apiService = ApiService();

  Future<List<dynamic>> getUsers() async {
    final response = await _apiService.get('/User/list');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load users');
  }

  Future<Map<String, dynamic>> getUserById(String id) async {
    final response = await _apiService.get('/User/$id');
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to load user');
  }

  Future<Map<String, dynamic>> registerUser({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    final response = await _apiService.post('/User/register', {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to register user');
  }

  Future<Map<String, dynamic>> createAdmin({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
  }) async {
    final response = await _apiService.post('/User/create-admin', {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    });

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    throw Exception('Failed to create admin');
  }
}
