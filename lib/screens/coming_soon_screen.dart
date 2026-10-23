import 'package:flutter/material.dart';
import '../data/home_items.dart';
import '../widgets/coming_soon_body.dart';

class ComingSoonScreen extends StatelessWidget {
  final HomeItem item;
  const ComingSoonScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.title),
        backgroundColor: item.color,
        foregroundColor: item.textColor,
      ),
      body: ComingSoonBody(color: item.color),
    );
  }
}
