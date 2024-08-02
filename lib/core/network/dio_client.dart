import 'dart:io';

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:quick_merchant_windows/core/debug.dart';
import 'package:quick_merchant_windows/core/extensions/global_exts.dart';
import '../exceptions/unknown_exception.dart';
import '../models/api_response.dart';
import 'apiclient.dart';

class DioClient implements ApiClient {
  DioClient._internal();
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  late final Dio _client = Dio(
    BaseOptions(
      validateStatus: (status) => true,
      sendTimeout: const Duration(seconds: 20),
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
    ),
  )
    ..options.headers['Accept'] = '*/*'
    ..interceptors.add(InterceptorsWrapper(onError: (error, handler) {
      if (error.response?.statusCode == 401 ||
          error.response?.statusCode == 403) {
        handleNotAuthroizeError();
      } else {
        return handler.next(error);
      }
    }))
    ..interceptors.add(PrettyDioLogger());

  void closeConnection() {
    _client.close();
  }

  void handleNotAuthroizeError() {}

  @override
  void removeToken() {
    _client.options.headers.remove('Authorization');
  }

  @override
  void setToken(String token) {
    _client.options.headers['Authorization'] = 'Bearer $token';
  }

  @override
  void addHeaders(Map<String, dynamic> headers) {
    _client.options.headers.addAll(headers);
  }

  @override
  Future<ApiResponse<T>> post<T>(String url,
      {required Object? body,
      T Function(Map<String, dynamic> json)? fromJson}) async {
    try {
      final response = await _client.post(url, data: body);
      return _handleResponse(response, fromJson: fromJson);
    } catch (e) {
      return ApiResponse<T>(error: e, data: null);
    }
  }

  ApiResponse<T> _handleResponse<T>(Response<dynamic> response,
      {T Function(Map<String, dynamic> json)? fromJson}) {
    final isSuccess = response.data['success'] as bool?;
    detailsLog(isSuccess);
    if (isSuccess == true) {
      return ApiResponse(error: null, data: response.data);
    } else {
      final msg = response.data.handleNull((map) {
        return map['error']['message'];
      });
      return ApiResponse(error: CustomException(message: msg));
    }
  }

  @override
  Future<ApiResponse<T>> get<T>(String url,
      {T Function(Map<String, dynamic> json)? fromJson}) async {
    try {
      final response = await _client.get(url);
      return _handleResponse<T>(response, fromJson: fromJson);
    } catch (e, s) {
      print('get error $e \n stack trace: $s');
      return ApiResponse<T>(error: e);
    }
  }

  @override
  Future<ApiResponse<T>> send<T>(String url, String method,
      {dynamic body}) async {
    try {
      final response = await _client.request(url,
          data: body, options: Options(method: method));
      return ApiResponse(data: response.data);
    } catch (e, s) {
      print('put error $e \n stack trace: $s');

      return ApiResponse<T>(error: e);
    }
  }

  @override
  Future<ApiResponse<T>> put<T>(String url,
      {dynamic body, T Function(Map<String, dynamic> json)? fromJson}) async {
    try {
      final response = await _client.put(url, data: body);
      return _handleResponse<T>(response, fromJson: fromJson);
    } catch (e, s) {
      print('put error $e \n stack trace: $s');

      return ApiResponse<T>(error: e);
    }
  }

  @override
  Future<ApiResponse<T>> uploadFile<T>(String url,
      {required File file, String fileKey = 'file', dynamic body}) async {
    body[fileKey] = await MultipartFile.fromFile(file.path);
    final formData = FormData.fromMap(body);

    try {
      final response = await _client.post(url, data: formData);
      return _handleResponse(response);
    } catch (e, s) {
      print('uploadFile error $e \n stacktrace: $s');
      return ApiResponse<T>(error: e);
    }
  }
}
