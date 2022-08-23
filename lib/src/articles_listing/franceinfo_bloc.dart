import 'dart:async';
import 'dart:collection';

import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;

class FranceinfoBloc {
  Stream<UnmodifiableListView<RssItem>> get articles => _articlesController.stream;
  final _articlesController = StreamController<UnmodifiableListView<RssItem>>.broadcast();

  static const _url = 'https://www.francetvinfo.fr/titres.rss';

  Future<void> loadArticles() async {
    final uri = Uri.parse(_url);
    final res = await http.get(uri);

    if (res.statusCode == 200) {
      _articlesController.add(UnmodifiableListView(_parseArticles(res.body)));
    }
  }

  static List<RssItem> _parseArticles(String xmlString) {
    final feed = RssFeed.parse(xmlString);
    return feed.items!;
  }
}