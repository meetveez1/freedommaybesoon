import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../models/news_item.dart';

class NewsDetailScreen extends StatelessWidget {
  const NewsDetailScreen({super.key, required this.news});

  final NewsItem news;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Детали новости')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(news.imageUrl, height: 190, fit: BoxFit.cover),
          ),
          const SizedBox(height: 16),
          Text(news.title, style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 6),
          Text(DateFormat('dd.MM.yyyy').format(news.date)),
          const SizedBox(height: 12),
          Text(news.description, style: Theme.of(context).textTheme.bodyLarge),
        ],
      ),
    );
  }
}
