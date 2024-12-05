import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/news_model.dart';
import 'detail_page.dart';

class DataPage extends StatelessWidget {
  final String category;

  DataPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category)),
      body: FutureBuilder(
        future: ApiService.fetchList(category), // Mengambil daftar berita
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final items = snapshot.data as List<News>;  // Mendapatkan list dari News model
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final newsItem = items[index];
                return Card(
                  child: ListTile(
                    leading: newsItem.imageUrl.isNotEmpty
                        ? Image.network(
                            newsItem.imageUrl,
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          )
                        : Icon(Icons.image, size: 50),
                    title: Text(newsItem.title),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(newsItem.summary),
                        SizedBox(height: 4),
                        Text(
                          'Published on: ${newsItem.date}', // Tampilkan tanggal
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ],
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailPage(
                            category: category,
                            id: newsItem.id,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
