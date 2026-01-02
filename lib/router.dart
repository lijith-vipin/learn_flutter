import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:learn_flutter/main.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/news/news_cubit.dart';
import 'main_detail.dart';
import 'main_home.dart';

GoRouter appRoutes({required bool isLoading, required String location}) =>
    GoRouter(
      initialLocation: isLoading ? '/loading' : location,
      routes: [
        GoRoute(
          path: '/',
          name: 'loading',
          builder: (context, state) {
            return Scaffold(
              body: CupertinoActivityIndicator(radius: 15, color: Colors.blue),
            );
          },
        ),
        GoRoute(
          path: HomePage.routeName.appendToRootPath,
          name: HomePage.routeName,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: DetailPage.routeName.appendToRootPath,
          name: DetailPage.routeName,
          builder: (context, state) {
            final isInvalidUser =
                bool.tryParse(
                  state.uri.queryParameters['isInvalidUser'] ?? '',
                ) ??
                false;

            return MultiBlocProvider(
              providers: [BlocProvider<NewsCubit>(create: (_) => NewsCubit())],

              child: DetailPage(),
            );
          },
        ),
      ],
    );
