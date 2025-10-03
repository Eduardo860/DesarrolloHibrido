class ApiResponse<T> {
  final bool ok;
  final T? data;
  final String? message;
  final int? statusCode;

  const ApiResponse({
    required this.ok,
    this.data,
    this.message,
    this.statusCode,
  });

  factory ApiResponse.success(T data, {int? statusCode}) =>
      ApiResponse(ok: true, data: data, statusCode: statusCode);

  factory ApiResponse.failure(String message, {int? statusCode}) =>
      ApiResponse(ok: false, message: message, statusCode: statusCode);
}
