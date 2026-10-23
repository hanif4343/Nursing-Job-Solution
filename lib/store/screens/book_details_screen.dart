import 'package:flutter/material.dart';
import '../cart_controller.dart';
import '../models.dart';
import '../widgets/book_cover.dart';
import 'cart_screen.dart';

class BookDetailsScreen extends StatelessWidget {
  final Book book;
  const BookDetailsScreen({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;
    return Scaffold(
      appBar: AppBar(
        title: const Text('বইয়ের বিবরণ'),
        backgroundColor: const Color(0xFF2B3F6B),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    SizedBox(
                      height: 220,
                      child: BookCover(book: book, iconSize: 64, titleSize: 20),
                    ),
                    const SizedBox(height: 16),
                    Text(book.title,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    Text('লেখক: ${book.author}',
                        style: const TextStyle(fontSize: 15, color: Colors.black54)),
                    const SizedBox(height: 10),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        Chip(label: Text(book.category)),
                        Chip(
                          avatar: const Icon(Icons.star, size: 18, color: Colors.amber),
                          label: Text(bn(book.rating)),
                        ),
                        Chip(label: Text('${bn(book.pages)} পৃষ্ঠা')),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Text(taka(book.price),
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
                        const SizedBox(width: 10),
                        if (book.mrp > book.price)
                          Text(
                            taka(book.mrp),
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                        const SizedBox(width: 10),
                        if (book.discountPercent > 0)
                          Text('${bn(book.discountPercent)}% ছাড়',
                              style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    const Text('বই সম্পর্কে',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 6),
                    Text(book.description, style: const TextStyle(fontSize: 15, height: 1.5)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(top: BorderSide(color: Colors.grey.shade300)),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 14)),
                        onPressed: () {
                          cart.add(book);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('কার্টে যোগ হয়েছে'),
                                duration: Duration(seconds: 1)),
                          );
                        },
                        child: const Text('কার্টে যোগ করুন'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          backgroundColor: const Color(0xFF2B3F6B),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        onPressed: () {
                          cart.add(book);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CartScreen()),
                          );
                        },
                        child: const Text('এখনই কিনুন'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
