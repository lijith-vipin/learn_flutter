import 'package:flutter_test/flutter_test.dart';
import 'package:learn_flutter/cubit/news/news_cubit.dart';

void main() {
  group('NewsCubit', () {
    late NewsCubit newsCubit;

    setUp(() {
      newsCubit = NewsCubit();
    });

    tearDown(() {
      newsCubit.close();
    });

    test('initial state is NewsStatusInitial', () {
      expect(newsCubit.state.status, NewsStatus.NewsStatusInitial);
      expect(newsCubit.state.newsList, null);
    });

    // You can add more tests for fetchNews using mock NewsRepository
  });
}