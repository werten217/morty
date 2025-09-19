class AppException implements Exception {
  final String message;
  AppException([this.message = 'Unexpected error']);

  @override
  String toString() => message;
}

class ServerException extends AppException {
  ServerException([String message = 'Server error']) : super(message);
}

class NetworkException extends AppException {
  NetworkException([String message = 'Network error']) : super(message);
}
