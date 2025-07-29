class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException({required this.message, this.statusCode});

  @override
  String toString() =>
      statusCode != null ? 'ApiException: $message' : ': (code: $statusCode)';
}
