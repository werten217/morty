import 'package:dio/dio.dart';
import '../constants/api_constants.dart';

class DioClient {
  final Dio dio;

  DioClient()
      : dio = Dio(
    BaseOptions(
      baseUrl: ApiConstants.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  ) {
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}
