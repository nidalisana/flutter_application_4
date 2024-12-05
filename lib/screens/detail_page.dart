import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../services/api_service.dart';
import '../models/news_model.dart';

class DetailPage extends StatelessWidget {
  final String category;
  final int id;

  DetailPage({required this.category, required this.id});

  Future<void> _launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detail')),
      body: FutureBuilder<News>(
        future: ApiService.fetchDetail(category, id), // Mengambil data detail berita
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final data = snapshot.data!;  // Ambil data News yang sudah diparse
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  data.imageUrl.isNotEmpty
                      ? Image.network(
                          data.imageUrl,
                          width: double.infinity,
                          height: 200,
                          fit: BoxFit.cover,
                        )
                      : Icon(Icons.image, size: 200),
                  SizedBox(height: 10),
                  Text(
                    data.title,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(data.summary, style: TextStyle(fontSize: 16)),
                  SizedBox(height: 10),
                  Text(
                    'Published on: ${data.date}', // Menambahkan tanggal
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  Spacer(),
                  FloatingActionButton(
                    onPressed: () => _launchURL(data.url),
                    child: Icon(Icons.web),
                    tooltip: 'Open Web',
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
