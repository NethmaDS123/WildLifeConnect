import 'package:flutter/material.dart';
import 'package:wildlifeconnect/pages/Posts/API/post_model.dart';

class PostTemplate extends StatelessWidget {
  final Post post;
  const PostTemplate({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 7,
      margin: const EdgeInsets.all(15),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              post.title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Image.network(post.imageUrl),
            const SizedBox(height: 20),
            Text(
              post.caption,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle like button press
                  },
                  icon: const Icon(Icons.thumb_up),
                  label: const Text('Like'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle comment button press
                  },
                  icon: const Icon(Icons.comment),
                  label: const Text('Comment'),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle share button press
                  },
                  icon: const Icon(Icons.share),
                  label: const Text('Share'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
