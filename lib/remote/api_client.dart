import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../model/entity/common/common_response.dart';
import '../model/entity/newsentity/news_response.dart';

part 'api_client.g.dart';

@RestApi(baseUrl: "https://newsapi.org/v2")
abstract class ApiClient {
  factory ApiClient(Dio dio, {String baseUrl}) = _ApiClient;

  @GET("/everything")
  Future<NewsResponse> getNews(
      @Query("q") String query,
      @Query("from") String fromDate,
      @Query("sortBy") String sortBy,
      @Query("apiKey") String apiKey,
      @Query("language") String language,
      );
}