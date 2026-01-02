import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_flutter/cubit/news/news_cubit.dart';

import 'main_detail.dart';

class HomePage extends StatelessWidget {
  static String routeName = 'home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Home')),
        body: Center(
          child: ElevatedButton(
            child: const Text('Go to Page 2'),
            onPressed: () {
              // final location = Uri(
              //     path: DetailPage.routeName,
              //     queryParameters: {"isInvalidUser": "true"}).toString();

              context.pushNamed(
                DetailPage.routeName,
                queryParameters: {"isInvalidUser": "true"},
              );
            },
          ),
        ),
    );
  }
}
