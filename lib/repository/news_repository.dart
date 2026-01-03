import 'dart:ui';

import 'package:learn_flutter/model/entity/newsentity/news_response.dart';
import 'package:learn_flutter/repository/repository.dart';

class NewsRepository extends Repository {
  NewsRepository();

  Future <NewsResponse> fetchNewsData() {
    return apiClient.getNews(
      "tesla",
      "2025-12-02",
      "publishedAt",
      "9ee6b3dfab1b4e76a4962600e53ae7e9",
      PlatformDispatcher.instance.locale.languageCode == 'en' ? 'en' : 'ml'
    );
  }
}