
import 'package:learn_flutter/model/bussiness_model/news/news_item.dart';
import 'package:learn_flutter/model/entity/newsentity/news_response.dart';
import 'package:learn_flutter/repository/repository.dart';
import 'package:learn_flutter/model/entity/common/common_response.dart';

class NewsRepository extends Repository {
  NewsRepository();
  //
  Future <NewsResponse> fetchNewsData() {
    return apiClient.getNews(
      "tesla",
      "2025-12-02",
      "publishedAt",
      "9ee6b3dfab1b4e76a4962600e53ae7e9",
    );
  }
}