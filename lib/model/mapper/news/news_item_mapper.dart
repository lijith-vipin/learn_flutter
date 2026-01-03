import 'package:learn_flutter/model/bussiness_model/news/news_item.dart';
import 'package:learn_flutter/model/entity/newsentity/news_response.dart';

class NewsItemMapper {
  NewsItemModel toNewsItemModel(NewsResponse newsItemModel) {
    return NewsItemModel(
      status: newsItemModel.status,
      totalResults: newsItemModel.totalResults,
      articles: newsItemModel.articles
          .map((article) =>
          Article(
            source: Source(
              id: article.source.id,
              name: article.source.name ?? "Unknown",
            ),
            title: article.title ?? "No Title",
            url: article.url ?? "",
            publishedAt: article.publishedAt ?? "",
            urlToImage: article.urlToImage,
          ),
      ).toList(),
    );
  }
}