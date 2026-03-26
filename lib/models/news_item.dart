class NewsItem {
  const NewsItem({
    required this.id,
    required this.title,
    required this.description,
    required this.date,
    required this.category,
    required this.imageUrl,
  });

  final String id;
  final String title;
  final String description;
  final DateTime date;
  final String category;
  final String imageUrl;
}
