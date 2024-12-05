class News {
  final int id;
  final String title;
  final String summary;
  final String imageUrl;
  final String url;
  final String date;  // Menambahkan properti date

  News({
    required this.id,
    required this.title,
    required this.summary,
    required this.imageUrl,
    required this.url,
    required this.date,  // Menambahkan parameter date
  });

  // Factory constructor untuk membuat instance News dari JSON
  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'],
      title: json['title'] ?? 'No Title',
      summary: json['summary'] ?? 'No Summary',
      imageUrl: json['image_url'] ?? '',
      url: json['url'] ?? '',
      date: json['published_at'] ?? 'No Date',  // Ambil data tanggal dari API
    );
  }
}
