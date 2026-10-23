import 'package:flutter/material.dart';
import '../fake_backend.dart';
import '../models.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  String _date(DateTime d) => bn('${d.day}/${d.month}/${d.year}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('আমার অর্ডার'),
        backgroundColor: const Color(0xFF2B3F6B),
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: FutureBuilder<List<OrderModel>>(
            future: StoreServices.orders.getOrders(),
            builder: (context, snap) {
              if (snap.connectionState != ConnectionState.done) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snap.hasError) {
                return const Center(child: Text('অর্ডার লোড করা যায়নি'));
              }
              final orders = snap.data ?? [];
              if (orders.isEmpty) {
                return const Center(
                  child: Text('এখনও কোনো অর্ডার নেই', style: TextStyle(fontSize: 16)),
                );
              }
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: orders.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final o = orders[i];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('#${bn(o.id)}',
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                              decoration: BoxDecoration(
                                color: o.status.color,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(o.status.label,
                                  style: const TextStyle(color: Colors.white, fontSize: 12)),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Text(_date(o.createdAt),
                            style: const TextStyle(color: Colors.black54, fontSize: 13)),
                        const Divider(),
                        for (final it in o.items)
                          Text('• ${it.book.title} × ${bn(it.qty)}'),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(o.method.label),
                            Text(taka(o.total),
                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
