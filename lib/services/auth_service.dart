import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String role,
  }) async {
    final response = await _apiService.post('/Auth/register', {
      'email': email,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
      'role': role,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveTokens(data['token'], data['refreshToken']);
      return data;
    }
    throw Exception('Failed to register');
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final response = await _apiService.post('/Auth/login', {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveTokens(data['token'], data['refreshToken']);
      return data;
    }
    throw Exception('Failed to login');
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(ApiService.tokenKey);
    await prefs.remove(ApiService.refreshTokenKey);
  }

  Future<Map<String, dynamic>> refreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString(ApiService.refreshTokenKey);

    if (refreshToken == null) {
      throw Exception('No refresh token available');
    }

    final response = await _apiService.post('/Auth/refresh-token', {
      'refreshToken': refreshToken,
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      await _saveTokens(data['token'], data['refreshToken']);
      return data;
    }
    throw Exception('Failed to refresh token');
  }

  Future<void> revokeToken() async {
    await _apiService.post('/Auth/revoke-token', {});
    await logout();
  }

  Future<bool> validateToken() async {
    try {
      final response = await _apiService.get('/Auth/validate');
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<void> forgotPassword(String email) async {
    final response = await _apiService.post('/Auth/forgot-password', {
      'email': email,
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to send password reset email');
    }
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    final response = await _apiService.post('/Auth/reset-password', {
      'token': token,
      'newPassword': newPassword,
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to reset password');
    }
  }

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final response = await _apiService.post('/Auth/update-password', {
      'currentPassword': currentPassword,
      'newPassword': newPassword,
    });

    if (response.statusCode != 200) {
      throw Exception('Failed to update password');
    }
  }

  Future<void> _saveTokens(String token, String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(ApiService.tokenKey, token);
    await prefs.setString(ApiService.refreshTokenKey, refreshToken);
  }
}
