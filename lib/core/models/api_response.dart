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
