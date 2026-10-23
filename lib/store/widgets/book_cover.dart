import 'package:flutter/material.dart';
import '../models.dart';

/// বইয়ের কভার (আসল ছবি আসলে এখানে Image.network বসবে)
class BookCover extends StatelessWidget {
  final Book book;
  final double iconSize;
  final double titleSize;
  const BookCover({super.key, required this.book, this.iconSize = 40, this.titleSize = 13});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: book.color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.menu_book, size: iconSize, color: Colors.white),
          const SizedBox(height: 8),
          Text(
            book.title,
            textAlign: TextAlign.center,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: titleSize,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
