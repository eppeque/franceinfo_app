import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:webfeed/webfeed.dart';

class ArticleItem extends StatelessWidget {
  final RssItem article;

  const ArticleItem({super.key, required this.article});

  String formatDateTime(DateTime? dateTime) {
    if (dateTime == null) return '[Pas de date/heure de publication]';

    final day = dateTime.day;
    final month = dateTime.month;
    final year = dateTime.year;

    final hour = dateTime.hour;
    final hourString = formatDateTimeItem(hour);

    final minute = dateTime.minute;
    final minuteString = formatDateTimeItem(minute);

    final now = DateTime.now();

    if (now.day == day && now.month == month && now.year == year) {
      return '$hourString:$minuteString';
    }

    final dayString = formatDateTimeItem(day);
    final monthString = formatDateTimeItem(month);
    final yearString = formatDateTimeItem(year);

    return '$dayString/$monthString/$yearString $hourString:$minuteString';
  }

  String formatDateTimeItem(int item) {
    if (item >= 10) return item.toString();

    return '0$item';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async => await launchUrlString(article.link!),
      child: Card(
        margin: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network(article.enclosure!.url!),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    article.title ?? '[Pas de titre]',
                    style: GoogleFonts.merriweather(
                      textStyle: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    HtmlUnescape().convert(article.description!),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 3,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        formatDateTime(article.pubDate),
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.left,
                      ),
                      ElevatedButton.icon(
                        icon: const Icon(Icons.share_outlined),
                        label: const Text('Partager'),
                        onPressed: () async => await Share.share(article.link!),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}