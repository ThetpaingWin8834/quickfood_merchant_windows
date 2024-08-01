import 'dart:io';

import '../../models/api_response.dart';

abstract class ApiClient {
  Future<ApiResponse<T>> get<T>(
    String url, {
    T Function(Map<String, dynamic> json)? fromJson,
  });
  Future<ApiResponse<T>> post<T>(String url, {required Object? body});

  Future<ApiResponse<T>> put<T>(String url,
      {required Map<String, dynamic> body});

  Future<ApiResponse<T>> uploadFile<T>(String url,
      {required File file,
      String fileKey = 'file',
      required Map<String, dynamic> body});

  void setToken(String token);
  void addHeaders(Map<String, dynamic> headers);
  void removeToken();
}
