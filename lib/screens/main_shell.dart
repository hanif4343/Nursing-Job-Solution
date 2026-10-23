import 'package:flutter/material.dart';
import '../widgets/coming_soon_body.dart';
import 'home_screen.dart';

/// নিচের Bottom Navigation: Home / Menu / Help / Profile
class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    // ওয়েবে বড় স্ক্রিনে মোবাইলের মতো মাঝখানে দেখাবে
    return Scaffold(
      backgroundColor: const Color(0xFFEFEFEF),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Container(
            color: Colors.white,
            child: Column(
              children: [
                Expanded(
                  child: IndexedStack(
                    index: _index,
                    children: const [
                      HomeScreen(),
                      SafeArea(child: ComingSoonBody()),
                      SafeArea(child: ComingSoonBody()),
                      SafeArea(child: ComingSoonBody()),
                    ],
                  ),
                ),
                NavigationBar(
                  selectedIndex: _index,
                  onDestinationSelected: (i) => setState(() => _index = i),
                  destinations: const [
                    NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
                    NavigationDestination(icon: Icon(Icons.apps_outlined), selectedIcon: Icon(Icons.apps), label: 'Menu'),
                    NavigationDestination(icon: Icon(Icons.support_agent_outlined), selectedIcon: Icon(Icons.support_agent), label: 'Help'),
                    NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
