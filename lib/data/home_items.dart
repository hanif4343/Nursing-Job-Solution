import 'package:flutter/material.dart';

class HomeItem {
  final String id;
  final String title;
  final IconData icon;
  final Color color;
  final Color textColor;

  const HomeItem({
    required this.id,
    required this.title,
    required this.icon,
    required this.color,
    this.textColor = Colors.white,
  });
}

/// হোম স্ক্রিনের ১৫টি টাইল (বাম থেকে ডানে, উপর থেকে নিচে)
const List<HomeItem> homeItems = [
  HomeItem(id: 'academic', title: 'একাডেমিক', icon: Icons.school, color: Color(0xFF2B3F6B)),
  HomeItem(id: 'admission', title: 'এডমিশন', icon: Icons.public, color: Color(0xFF0B6B4F)),
  HomeItem(id: 'special', title: 'স্পেশাল কোর্স', icon: Icons.card_giftcard, color: Color(0xFF5A3426)),
  HomeItem(id: 'hsc', title: 'এইচএসসি', icon: Icons.assignment, color: Color(0xFF9C1F7A)),
  HomeItem(id: 'ssc', title: 'এসএসসি', icon: Icons.description, color: Color(0xFFFFA11F)),
  HomeItem(id: 'read_book', title: 'বই পড়া', icon: Icons.menu_book, color: Color(0xFF37474F)),
  HomeItem(id: 'study', title: 'স্টাডি', icon: Icons.edit_note, color: Color(0xFF2E7D32)),
  HomeItem(id: 'online_class', title: 'অনলাইন ক্লাস', icon: Icons.groups, color: Color(0xFFFFB0A0)),
  HomeItem(id: 'live_class', title: 'লাইভ ক্লাস', icon: Icons.live_tv, color: Color(0xFF2B2B2B)),
  HomeItem(id: 'job', title: 'জব কোর্স', icon: Icons.work, color: Color(0xFF5A3426)),
  HomeItem(id: 'bcs', title: 'বিসিএস কোর্স', icon: Icons.account_balance, color: Color(0xFF8A8A8A)),
  HomeItem(id: 'primary', title: 'প্রাইমারি কোর্স', icon: Icons.child_care, color: Color(0xFF9C27B0)),
  HomeItem(id: 'free_exam', title: 'ফ্রী পরিক্ষা', icon: Icons.redeem, color: Color(0xFFD32F2F)),
  HomeItem(id: 'buy_book', title: 'বই কিনুন', icon: Icons.local_library, color: Color(0xFF2B3F6B)),
  HomeItem(id: 'gk', title: 'সাধারণ জ্ঞান', icon: Icons.lightbulb, color: Color(0xFF0B6B4F)),
];
