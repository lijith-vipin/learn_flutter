import '../remote/api_client.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class Repository {
  late ApiClient apiClient;
  late String baseUrl;
  late Dio dio;

  Repository({
    String? baseUrl,
    Interceptor? redirectInterceptor,
    bool enableCache = true,
  }) {
    this.baseUrl = baseUrl ?? "https://newsapi.org/v2";
    dio = Dio(BaseOptions(baseUrl: this.baseUrl));
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: false,
        responseBody: true,
        error: true,
        compact: true,
        maxWidth: 90,
      ),
    );
    if (redirectInterceptor != null) {
      dio.interceptors.add(redirectInterceptor);
    }
    apiClient = ApiClient(dio, baseUrl: this.baseUrl);
  }
}