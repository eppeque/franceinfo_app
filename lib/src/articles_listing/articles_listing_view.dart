import 'dart:collection';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:franceinfo_app/src/articles_listing/article_item.dart';
import 'package:franceinfo_app/src/articles_listing/franceinfo_bloc.dart';
import 'package:franceinfo_app/src/settings/settings_view.dart';
import 'package:webfeed/domain/rss_item.dart';

class ArticlesListingView extends StatelessWidget {
  final FranceinfoBloc bloc;

  const ArticlesListingView({super.key, required this.bloc});

  static const route = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/logo.png',
          width: 150,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Ouvrir les paramètres',
            onPressed: () => Navigator.pushNamed(context, SettingsView.route),
          ),
        ],
      ),
      body: StreamBuilder<ConnectivityResult>(
        stream: Connectivity().onConnectivityChanged,
        builder: (context, snapshot) {
          final connectivityResult = snapshot.data;

          if (connectivityResult == null ||
              connectivityResult == ConnectivityResult.none) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off,
                    color: Theme.of(context).errorColor,
                    size: 50.0,
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Il semble que vous ne soyez pas connecté à Internet 😢',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          bloc.loadArticles();

          return RefreshIndicator(
            onRefresh: () async => await bloc.loadArticles(),
            child: StreamBuilder<UnmodifiableListView<RssItem>>(
              stream: bloc.articles,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Center(
                    child: Text(
                      'Une erreur est survenue, veuillez réessayer dans quelques instants...',
                    ),
                  );
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                return ListView(
                  children: snapshot.data!.map(
                    (article) {
                      return ArticleItem(article: article);
                    },
                  ).toList(),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
