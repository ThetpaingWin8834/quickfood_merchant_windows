import 'dart:io';

import 'package:dio/dio.dart';
import 'package:quick_food_rider_v2/core/constants/my_locale.dart';
import 'package:quick_food_rider_v2/core/exceptions/custom_exception.dart';
import 'package:quick_food_rider_v2/core/extensions/context_exts.dart';
import 'package:quick_food_rider_v2/core/utils/debug.dart';
import 'package:quick_food_rider_v2/core/widgets/dialog/base_dialog.dart';

import '../../../main_config_manager.dart';
import '../../models/api_response.dart';
import 'apiclient.dart';

class DioClient implements ApiClient {
  DioClient._internal();
  static final DioClient _instance = DioClient._internal();
  factory DioClient() => _instance;
  late final Dio _client = Dio(
    BaseOptions(
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
    ..interceptors.add(LogInterceptor());

  void closeConnection() {
    _client.close();
  }

  void handleNotAuthroizeError() {
    MainConfigManager.mainNavigator.currentContext?.showTpwSDialog(
        type: DialogType.error,
        message: MyLocale.sessionTimeOut,
        buttonText: MyLocale.ok,
        onButtonClick: () {
          MainConfigManager.instance.logOut();
        });
  }

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
    mlog('Dio client posting - $url');
    try {
      final response = await _client.post(url, data: body);
      return _handleResponse(response, fromJson: fromJson);
    } catch (e, s) {
      mlog('post error $e \n stack trace: $s');
      return ErrorResponse<T>(e);
    }
  }

  ApiResponse<T> _handleResponse<T>(Response<dynamic> response,
      {T Function(Map<String, dynamic> json)? fromJson}) {
    final isSuccess = response.data['success'] as bool?;
    mlog(response.data);
    if (isSuccess == true) {
      return SuccessResponse(
          fromJson?.call(response.data['data']) ?? response.data);
    } else {
      final msg = response.data.handleNull((map) {
        return map['error']['message'];
      });
      return ErrorResponse(CustomException(msg));
    }
  }

  @override
  Future<ApiResponse<T>> get<T>(String url,
      {T Function(Map<String, dynamic> json)? fromJson}) async {
    mlog('Dio client gettting - $url');

    try {
      final response = await _client.get(url);
      return _handleResponse<T>(response, fromJson: fromJson);
    } catch (e, s) {
      mlog('get error $e \n stack trace: $s');
      return ErrorResponse<T>(e, stackTrace: s);
    }
  }

  @override
  Future<ApiResponse<T>> put<T>(String url,
      {required Map<String, dynamic> body,
      T Function(Map<String, dynamic> json)? fromJson}) async {
    try {
      final response = await _client.put(url, data: body);
      return _handleResponse<T>(response, fromJson: fromJson);
    } catch (e, s) {
      mlog('put error $e \n stack trace: $s');

      return ErrorResponse<T>(e);
    }
  }

  @override
  Future<ApiResponse<T>> uploadFile<T>(String url,
      {required File file,
      String fileKey = 'file',
      required Map<String, dynamic> body}) async {
    body[fileKey] = await MultipartFile.fromFile(file.path);
    final formData = FormData.fromMap(body);

    try {
      final response = await _client.post(url, data: formData);
      return _handleResponse(response);
    } catch (e, s) {
      mlog('uploadFile error $e \n stacktrace: $s');
      return ErrorResponse<T>(e);
    }
  }
}
