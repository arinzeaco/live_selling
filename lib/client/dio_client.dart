import 'package:dio/dio.dart';
import 'package:live_selling/ui/common/app_strings.dart';

class DioClient {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: BASE_URL,
      // connectTimeout: 15000,
      // receiveTimeout: 3000,
    ),
  );

  Dio get dio => _dio;
}