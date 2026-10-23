import 'package:flutter/material.dart';
import '../data/home_items.dart';
import '../widgets/home_tile.dart';
import 'coming_soon_screen.dart';
import 'quiz_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  /// যেগুলো তৈরি হয়ে গেছে সেগুলো এখানে যোগ হবে; বাকি সব "কামিং সুন"
  Widget _screenFor(HomeItem item) {
    switch (item.id) {
      case 'free_exam':
        return QuizScreen(title: item.title, color: item.color);
      default:
        return ComingSoonScreen(item: item);
    }
  }

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
                    MaterialPageRoute(builder: (_) => _screenFor(item)),
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
