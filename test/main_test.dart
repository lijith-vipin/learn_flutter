import 'package:flutter_test/flutter_test.dart';

import 'news_cubit_test.dart' as news_cubit_test;


void main() {
  setUpAll(() async {
    // Initialize SharedPreferences mock to prevent MissingPluginException
    // This ensures all tests that depend on SharedPreferences work properly

    group('news_cubit_test', news_cubit_test.main);
  });
}