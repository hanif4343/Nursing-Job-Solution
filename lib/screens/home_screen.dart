import 'package:flutter/material.dart';
import '../data/home_items.dart';
import '../widgets/home_tile.dart';
import 'coming_soon_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // উপরের ব্যানার/স্লাইডার এর জায়গা (পরে স্লাইডার বসবে)
          Container(
            height: 130,
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              gradient: const LinearGradient(
                colors: [Color(0xFF2B3F6B), Color(0xFF0B6B4F)],
              ),
            ),
            alignment: Alignment.center,
            child: const Text(
              'স্বাগতম',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 14,
                mainAxisSpacing: 14,
                childAspectRatio: 1.05,
              ),
              itemCount: homeItems.length,
              itemBuilder: (context, i) {
                final item = homeItems[i];
                return HomeTile(
                  item: item,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ComingSoonScreen(item: item),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
