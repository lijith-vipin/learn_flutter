import 'package:learn_flutter/model/bussiness_model/news/news_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/repository/news_repository.dart';

import '../../model/mapper/news/news_item_mapper.dart';

enum NewsStatus {
  NewsStatusInitial,
  NewsStatusLoading,
  NewsStatusSuccess,
  NewsStatusFailure,
}

class NewsCubit extends Cubit<NewsState> {
  NewsCubit() : super(NewsState(newsList: null));

  Future<void> fetchNews() async {
    emit(state.copyWith(null, NewsStatus.NewsStatusLoading));
    try {
      final fetchedNews = await NewsRepository().fetchNewsData();
      final newsModel = NewsItemMapper().toNewsItemModel(fetchedNews);

      emit(state.copyWith(newsModel, NewsStatus.NewsStatusSuccess));
    } catch (e) {
      emit(state.copyWith(null, NewsStatus.NewsStatusFailure));
    }
  }
}

class NewsState {
  late NewsStatus status;
  late NewsItemModel? newsList;

  NewsState({
    this.newsList,
    this.status = NewsStatus.NewsStatusInitial,
  });

  NewsState copyWith(NewsItemModel? newsList, NewsStatus? status) {
    return NewsState(
      newsList: newsList ?? this.newsList,
      status: status ?? this.status,
    );
  }
}
