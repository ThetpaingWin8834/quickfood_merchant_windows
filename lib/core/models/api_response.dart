// ignore_for_file: public_member_api_docs, sort_constructors_first
class ApiResponse<T> {
  final Object? error;
  final T? data;
  final int? statusCode;
  final String? statusMessage;
  ApiResponse({
    this.error,
    this.data,
    this.statusCode,
    this.statusMessage,
  });
}
