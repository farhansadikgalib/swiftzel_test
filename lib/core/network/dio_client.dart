import 'package:dio/dio.dart';
import 'package:swiftzel_test/core/constants/api_end_points.dart';
import 'package:swiftzel_test/core/utils/logger.dart';
import '../constants/constants.dart';
import '../errors/exceptions.dart';

class DioClient {
  final Dio dio;

  DioClient(this.dio) {
    dio
      ..options.baseUrl = AppConstants.baseUrl
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30)
      ..options.responseType = ResponseType.json
      ..interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: true,
          requestBody: true,
          responseHeader: true,
          responseBody: true,
        ),
      );
  }

  Future<Response> get(String url, {Map<String, dynamic>? params}) async {
    try {
      printLog('Making GET request to $url');

      final response = await dio.get(
        url,
        options: Options(
          headers: {'User-Agent': 'Mozilla/5.0', 'Accept': 'application/json'},
        ),
      );
      printLog('Response: $response');

      return response;
    } on DioException catch (err) {
      printLog('Error in GET request to ${err.message}');
      throw ServerException(err.message ?? 'Something went wrong');
    }
  }
}
