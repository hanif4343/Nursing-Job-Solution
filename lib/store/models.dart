import 'package:flutter/material.dart';

/// সংখ্যাকে বাংলা অঙ্কে রূপান্তর (123 → ১২৩)
String bn(Object value) {
  const en = '0123456789';
  const bd = '০১২৩৪৫৬৭৮৯';
  var s = value.toString();
  for (var i = 0; i < en.length; i++) {
    s = s.replaceAll(en[i], bd[i]);
  }
  return s;
}

String taka(int amount) => '৳${bn(amount)}';

class Book {
  final String id;
  final String title;
  final String author;
  final String category;
  final String description;
  final int price; // বিক্রয় মূল্য
  final int mrp; // মুদ্রিত মূল্য
  final int pages;
  final double rating;
  final Color color; // কভারের রঙ (আসল ছবি আসলে imageUrl যোগ হবে)

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.description,
    required this.price,
    required this.mrp,
    required this.pages,
    required this.rating,
    required this.color,
  });

  int get discountPercent =>
      mrp > price ? ((mrp - price) * 100 / mrp).round() : 0;
}

class CartItem {
  final Book book;
  int qty;
  CartItem(this.book, this.qty);

  int get total => book.price * qty;
}

enum DeliveryArea {
  dhaka('ঢাকার ভিতরে', 60),
  outside('ঢাকার বাইরে', 120);

  final String label;
  final int fee;
  const DeliveryArea(this.label, this.fee);
}

enum PaymentMethod {
  bkash('বিকাশ', true, Icons.phone_android),
  nagad('নগদ', true, Icons.account_balance_wallet),
  cod('ক্যাশ অন ডেলিভারি', false, Icons.local_shipping);

  final String label;
  final bool needsTrx; // মোবাইল ব্যাংকিং হলে নম্বর ও TrxID লাগবে
  final IconData icon;
  const PaymentMethod(this.label, this.needsTrx, this.icon);
}

enum OrderStatus {
  pending('অপেক্ষমান', Colors.orange),
  confirmed('কনফার্মড', Colors.blue),
  shipped('শিপ হয়েছে', Colors.purple),
  delivered('ডেলিভারড', Colors.green);

  final String label;
  final Color color;
  const OrderStatus(this.label, this.color);
}

class OrderModel {
  final String id;
  final List<CartItem> items;
  final int subtotal;
  final int deliveryFee;
  final int total;
  final String name;
  final String phone;
  final String address;
  final DeliveryArea area;
  final PaymentMethod method;
  final String paymentRef;
  final DateTime createdAt;
  final OrderStatus status;

  const OrderModel({
    required this.id,
    required this.items,
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.name,
    required this.phone,
    required this.address,
    required this.area,
    required this.method,
    required this.paymentRef,
    required this.createdAt,
    required this.status,
  });

  int get itemCount => items.fold(0, (s, e) => s + e.qty);
}
