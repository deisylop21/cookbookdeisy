import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewsPost {
  final String title;
  final String content;
  final String author;
  final DateTime date;
  final int likes;
  final int comments;

  NewsPost({
    required this.title,
    required this.content,
    required this.author,
    required this.date,
    required this.likes,
    required this.comments,
  });
}

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final List<NewsPost> _posts = List.generate(
    10,
        (index) => NewsPost(
      title: 'Flutter Update ${index + 1}',
      content: 'Exciting new features coming to Flutter! Stay tuned for more updates '
          'about widgets, performance improvements, and developer tools. '
          '#FlutterDev #MobileApp #Development',
      author: 'Flutter Team',
      date: DateTime.now().subtract(Duration(days: index)),
      likes: 100 - index * 5,
      comments: 20 - index * 2,
    ),
  );

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: const Color(0xFF8B4513),
                      child: Icon(
                        Icons.code,
                        color: const Color(0xFFF5F5DC),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            post.title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: const Color(0xFF8B4513),
                            ),
                          ),
                          Text(
                            '${post.date.year}-${post.date.month.toString().padLeft(2, '0')}-${post.date.day.toString().padLeft(2, '0')}',
                            style: GoogleFonts.poppins(
                              color: Colors.grey[600],
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  post.content,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.favorite_border),
                          color: const Color(0xFF8B4513),
                          onPressed: () {},
                        ),
                        Text(
                          post.likes.toString(),
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF8B4513),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.comment_outlined),
                          color: const Color(0xFF8B4513),
                          onPressed: () {},
                        ),
                        Text(
                          post.comments.toString(),
                          style: GoogleFonts.poppins(
                            color: const Color(0xFF8B4513),
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.share_outlined),
                      color: const Color(0xFF8B4513),
                      onPressed: () {},
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}