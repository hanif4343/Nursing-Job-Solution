import 'package:flutter/material.dart';
import 'models.dart';

// ============================================================
//  এখানে সব ফেক। পরে আসল করতে হলে শুধু নিচের abstract class গুলোর
//  আসল implementation (API/Firebase) লিখে StoreServices এ বসাবে।
//  UI কোড বদলাতে হবে না। বিস্তারিত: docs/STORE_REAL_BACKEND.md
// ============================================================

// ---------- বই ----------
abstract class BookRepository {
  Future<List<Book>> getBooks();
}

class FakeBookRepository implements BookRepository {
  @override
  Future<List<Book>> getBooks() async {
    await Future.delayed(const Duration(milliseconds: 700)); // নেটওয়ার্কের ভান
    return _books;
  }
}

const List<Book> _books = [
  Book(
    id: 'b1', title: 'এইচএসসি বাংলা গাইড', author: 'মো. রফিকুল ইসলাম',
    category: 'একাডেমিক', price: 320, mrp: 400, pages: 280, rating: 4.5,
    color: Color(0xFF9C1F7A),
    description: 'এইচএসসি পরীক্ষার্থীদের জন্য সম্পূর্ণ বাংলা প্রস্তুতি। সৃজনশীল ও বহুনির্বাচনি প্রশ্নসহ সমাধান।',
  ),
  Book(
    id: 'b2', title: 'এসএসসি গণিত সমাধান', author: 'শাহিনা আক্তার',
    category: 'একাডেমিক', price: 280, mrp: 350, pages: 240, rating: 4.3,
    color: Color(0xFFFFA11F),
    description: 'অধ্যায়ভিত্তিক গাণিতিক সমস্যার ধাপে ধাপে সমাধান ও অনুশীলনী।',
  ),
  Book(
    id: 'b3', title: 'এইচএসসি পদার্থবিজ্ঞান', author: 'ড. আব্দুল করিম',
    category: 'একাডেমিক', price: 450, mrp: 550, pages: 360, rating: 4.6,
    color: Color(0xFF2B3F6B),
    description: 'ধারণাভিত্তিক ব্যাখ্যা, সূত্র ও নমুনা প্রশ্নসহ পূর্ণাঙ্গ পদার্থবিজ্ঞান বই।',
  ),
  Book(
    id: 'b4', title: 'বিশ্ববিদ্যালয় ভর্তি গাইড', author: 'তানভীর হাসান',
    category: 'এডমিশন', price: 520, mrp: 650, pages: 420, rating: 4.7,
    color: Color(0xFF0B6B4F),
    description: 'পাবলিক বিশ্ববিদ্যালয় ভর্তি পরীক্ষার পূর্ণাঙ্গ প্রস্তুতি, আগের বছরের প্রশ্নসহ।',
  ),
  Book(
    id: 'b5', title: 'মেডিকেল ভর্তি প্রস্তুতি', author: 'ডা. নাজমুল হক',
    category: 'এডমিশন', price: 580, mrp: 700, pages: 460, rating: 4.4,
    color: Color(0xFFD32F2F),
    description: 'মেডিকেল ভর্তি পরীক্ষার জন্য বিষয়ভিত্তিক MCQ ও মডেল টেস্ট।',
  ),
  Book(
    id: 'b6', title: 'বিসিএস প্রিলিমিনারি সহায়িকা', author: 'মাহমুদুল হাসান',
    category: 'বিসিএস ও জব', price: 480, mrp: 600, pages: 400, rating: 4.8,
    color: Color(0xFF5A3426),
    description: 'বিসিএস প্রিলির সব বিষয়ের সংক্ষিপ্ত তথ্য ও অনুশীলন প্রশ্ন।',
  ),
  Book(
    id: 'b7', title: 'ব্যাংক জব সলিউশন', author: 'সাদিয়া রহমান',
    category: 'বিসিএস ও জব', price: 390, mrp: 480, pages: 320, rating: 4.2,
    color: Color(0xFF37474F),
    description: 'ব্যাংক নিয়োগ পরীক্ষার গণিত, ইংরেজি ও সাধারণ জ্ঞানের প্রশ্নব্যাংক।',
  ),
  Book(
    id: 'b8', title: 'প্রাইমারি শিক্ষক নিয়োগ গাইড', author: 'আবুল কালাম',
    category: 'বিসিএস ও জব', price: 350, mrp: 420, pages: 300, rating: 4.1,
    color: Color(0xFF9C27B0),
    description: 'প্রাথমিক শিক্ষক নিয়োগ পরীক্ষার সম্পূর্ণ প্রস্তুতি ও মডেল টেস্ট।',
  ),
  Book(
    id: 'b9', title: 'বাংলাদেশ বিষয়াবলি', author: 'ইমরান হোসেন',
    category: 'সাধারণ জ্ঞান', price: 300, mrp: 380, pages: 260, rating: 4.5,
    color: Color(0xFF2E7D32),
    description: 'বাংলাদেশের ইতিহাস, ভূগোল, অর্থনীতি ও সংস্কৃতি সংক্রান্ত তথ্যভান্ডার।',
  ),
  Book(
    id: 'b10', title: 'আন্তর্জাতিক বিষয়াবলি', author: 'ফারজানা ইয়াসমিন',
    category: 'সাধারণ জ্ঞান', price: 310, mrp: 390, pages: 270, rating: 4.3,
    color: Color(0xFF0B6B4F),
    description: 'বিশ্বের গুরুত্বপূর্ণ সংগঠন, ঘটনা ও চলতি বিষয়ের সহজ উপস্থাপন।',
  ),
  Book(
    id: 'b11', title: 'ইংরেজি গ্রামার মাস্টার', author: 'রেজাউল করিম',
    category: 'ভাষা শিক্ষা', price: 270, mrp: 330, pages: 230, rating: 4.4,
    color: Color(0xFFFFB0A0),
    description: 'সহজ উদাহরণে ইংরেজি গ্রামারের সব নিয়ম, অনুশীলনসহ।',
  ),
  Book(
    id: 'b12', title: 'স্পোকেন ইংলিশ গাইড', author: 'নুসরাত জাহান',
    category: 'ভাষা শিক্ষা', price: 220, mrp: 280, pages: 180, rating: 4.0,
    color: Color(0xFF8A8A8A),
    description: 'দৈনন্দিন কথোপকথনে ইংরেজি বলার কার্যকর কৌশল ও বাক্যমালা।',
  ),
];

// ---------- পেমেন্ট ----------
class PaymentResult {
  final bool success;
  final String reference; // TrxID / COD
  final String message;
  const PaymentResult(this.success, this.reference, this.message);
}

abstract class PaymentService {
  Future<PaymentResult> pay({
    required PaymentMethod method,
    required int amount,
    String? senderNumber,
    String? trxId,
  });
}

/// ফেক পেমেন্ট: TrxID তে "FAIL" লিখলে ব্যর্থ হবে (টেস্টের জন্য), বাকি সব সফল।
class FakePaymentService implements PaymentService {
  @override
  Future<PaymentResult> pay({
    required PaymentMethod method,
    required int amount,
    String? senderNumber,
    String? trxId,
  }) async {
    await Future.delayed(const Duration(seconds: 2)); // পেমেন্ট প্রসেসিংয়ের ভান
    if (!method.needsTrx) {
      return const PaymentResult(true, 'COD', 'ক্যাশ অন ডেলিভারি নির্বাচিত');
    }
    if ((trxId ?? '').toUpperCase() == 'FAIL') {
      return const PaymentResult(false, '', 'পেমেন্ট ব্যর্থ হয়েছে (টেস্ট মোড)। আবার চেষ্টা করুন।');
    }
    return PaymentResult(true, trxId ?? '', '${method.label} পেমেন্ট সফল (ডেমো)');
  }
}

// ---------- অর্ডার ----------
abstract class OrderRepository {
  Future<OrderModel> placeOrder({
    required List<CartItem> items,
    required int deliveryFee,
    required String name,
    required String phone,
    required String address,
    required DeliveryArea area,
    required PaymentMethod method,
    required String paymentRef,
  });
  Future<List<OrderModel>> getOrders();
}

/// ফেক অর্ডার: শুধু মেমোরিতে থাকে (অ্যাপ বন্ধ করলে মুছে যায়)
class FakeOrderRepository implements OrderRepository {
  final List<OrderModel> _orders = [];
  int _counter = 1000;

  @override
  Future<OrderModel> placeOrder({
    required List<CartItem> items,
    required int deliveryFee,
    required String name,
    required String phone,
    required String address,
    required DeliveryArea area,
    required PaymentMethod method,
    required String paymentRef,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final copied = items.map((e) => CartItem(e.book, e.qty)).toList();
    final subtotal = copied.fold<int>(0, (s, e) => s + e.total);
    final order = OrderModel(
      id: 'BK${++_counter}',
      items: copied,
      subtotal: subtotal,
      deliveryFee: deliveryFee,
      total: subtotal + deliveryFee,
      name: name,
      phone: phone,
      address: address,
      area: area,
      method: method,
      paymentRef: paymentRef,
      createdAt: DateTime.now(),
      status: OrderStatus.pending,
    );
    _orders.insert(0, order);
    return order;
  }

  @override
  Future<List<OrderModel>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.unmodifiable(_orders);
  }
}

// ---------- এক জায়গায় সব সার্ভিস ----------
class StoreServices {
  // পরে আসল করতে এখানে বদলাবে, যেমন: = ApiBookRepository();
  static BookRepository books = FakeBookRepository();
  static PaymentService payment = FakePaymentService();
  static OrderRepository orders = FakeOrderRepository();
}
