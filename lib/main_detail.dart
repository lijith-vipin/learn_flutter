import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/l10n/core/l10n.dart';

import 'cubit/news/news_cubit.dart';

class DetailPage extends StatelessWidget {
  static String routeName = 'detail';

  const DetailPage({super.key, productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.detailPage)),
      backgroundColor: Colors.green,
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (ctx, state) {
          if (state.status == NewsStatus.NewsStatusLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == NewsStatus.NewsStatusSuccess) {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: state.newsList?.articles.length ?? 0,
              itemBuilder: (context, index) {
                final article = state.newsList!.articles[index];
                return ListTile(
                  title: Text(article.title),
                  subtitle: Text(article.description ?? ''),
                );
              },
            );
          } else if (state.status == NewsStatus.NewsStatusFailure) {
            return const Center(child: Text('Failed to load news'));
          } else {
            return Center(
              child: ElevatedButton(
                onPressed: () {
                  context.read<NewsCubit>().fetchNews();
                },
                child: Text(context.l10n.backToHome),
              ),
            );
          }
        }

     ),
    );
  }
}