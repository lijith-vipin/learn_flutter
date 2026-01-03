import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learn_flutter/l10n/core/l10n.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main_detail.dart';

class HomePage extends StatelessWidget {
  static String routeName = 'home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(context.l10n.welcome)),
        body: Center(
          child: ElevatedButton(
            child: Text(context.l10n.gotoDetailPage),
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
