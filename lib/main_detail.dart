import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learn_flutter/l10n/core/l10n.dart';
import 'package:learn_flutter/widgets/news_item.dart';

import 'cubit/news/news_cubit.dart';

class DetailPage extends StatelessWidget {
  static String routeName = 'detail';

  const DetailPage({super.key, productId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.detailPage)),
      backgroundColor: Colors.green[50],
      body: BlocBuilder<NewsCubit, NewsState>(
        builder: (ctx, state) {
          if (state.status == NewsStatus.NewsStatusLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state.status == NewsStatus.NewsStatusSuccess) {
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: state.newsList!.articles.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final article = state.newsList!.articles[index];
                return NewsItem(article: article);
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
                child: Text(context.l10n.readNews),
              ),
            );
          }
        }

     ),
    );
  }
}