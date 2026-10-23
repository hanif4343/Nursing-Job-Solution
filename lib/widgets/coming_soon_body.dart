import 'package:flutter/material.dart';

class ComingSoonBody extends StatelessWidget {
  final Color color;
  const ComingSoonBody({super.key, this.color = const Color(0xFF2B3F6B)});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.construction, size: 80, color: color),
          const SizedBox(height: 16),
          Text(
            'কামিং সুন',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: color),
          ),
          const SizedBox(height: 8),
          const Text(
            'এই সেকশনটি খুব শীঘ্রই আসছে',
            style: TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }
}
