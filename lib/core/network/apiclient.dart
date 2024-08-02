import 'dart:io';

import '../models/api_response.dart';

abstract class ApiClient {
  Future<ApiResponse<T>> get<T>(
    String url, {
    T Function(dynamic json)? fromJson,
  });
  Future<ApiResponse<T>> post<T>(String url, {required Object? body});

  Future<ApiResponse<T>> put<T>(String url, {required dynamic body});
  Future<ApiResponse<T>> send<T>(String url, String method,
      {required dynamic body});

  Future<ApiResponse<T>> uploadFile<T>(String url,
      {required File file, String fileKey = 'file', required dynamic body});

  void setToken(String token);
  void addHeaders(Map<String, dynamic> headers);
  void removeToken();
}
