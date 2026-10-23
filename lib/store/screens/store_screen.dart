import 'package:flutter/material.dart';
import '../cart_controller.dart';
import '../fake_backend.dart';
import '../models.dart';
import '../widgets/book_cover.dart';
import 'book_details_screen.dart';
import 'cart_screen.dart';
import 'orders_screen.dart';

class BookStoreScreen extends StatefulWidget {
  const BookStoreScreen({super.key});

  @override
  State<BookStoreScreen> createState() => _BookStoreScreenState();
}

class _BookStoreScreenState extends State<BookStoreScreen> {
  static const _primary = Color(0xFF2B3F6B);
  final _cart = CartController.instance;

  List<Book> _books = [];
  bool _loading = true;
  String? _error;
  String _category = 'সব';
  String _query = '';

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final list = await StoreServices.books.getBooks();
      if (!mounted) return;
      setState(() {
        _books = list;
        _loading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _error = 'বই লোড করা যায়নি';
        _loading = false;
      });
    }
  }

  List<String> get _categories => ['সব', ..._books.map((b) => b.category).toSet()];

  List<Book> get _filtered {
    final q = _query.trim().toLowerCase();
    return _books.where((b) {
      final okCat = _category == 'সব' || b.category == _category;
      final okQ = q.isEmpty ||
          b.title.toLowerCase().contains(q) ||
          b.author.toLowerCase().contains(q);
      return okCat && okQ;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('বই কিনুন'),
        backgroundColor: _primary,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            tooltip: 'আমার অর্ডার',
            icon: const Icon(Icons.receipt_long),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrdersScreen()),
            ),
          ),
          ListenableBuilder(
            listenable: _cart,
            builder: (context, _) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Badge(
                label: Text(bn(_cart.count)),
                isLabelVisible: _cart.count > 0,
                child: IconButton(
                  tooltip: 'কার্ট',
                  icon: const Icon(Icons.shopping_cart),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CartScreen()),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: _buildBody(),
        ),
      ),
    );
  }

  Widget _buildBody() {
    if (_loading) return const Center(child: CircularProgressIndicator());
    if (_error != null) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(_error!),
            const SizedBox(height: 12),
            FilledButton(onPressed: _load, child: const Text('আবার চেষ্টা করুন')),
          ],
        ),
      );
    }
    final list = _filtered;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
          child: TextField(
            onChanged: (v) => setState(() => _query = v),
            decoration: InputDecoration(
              hintText: 'বই বা লেখকের নাম খুঁজুন',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
            ),
          ),
        ),
        SizedBox(
          height: 44,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, i) {
              final c = _categories[i];
              return ChoiceChip(
                label: Text(c),
                selected: _category == c,
                onSelected: (_) => setState(() => _category = c),
              );
            },
          ),
        ),
        Expanded(
          child: list.isEmpty
              ? const Center(child: Text('কোনো বই পাওয়া যায়নি'))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 0.62,
                  ),
                  itemCount: list.length,
                  itemBuilder: (context, i) => _BookCard(book: list[i]),
                ),
        ),
      ],
    );
  }
}

class _BookCard extends StatelessWidget {
  final Book book;
  const _BookCard({required this.book});

  @override
  Widget build(BuildContext context) {
    final cart = CartController.instance;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => BookDetailsScreen(book: book)),
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned.fill(child: BookCover(book: book)),
                  if (book.discountPercent > 0)
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${bn(book.discountPercent)}% ছাড়',
                          style: const TextStyle(color: Colors.white, fontSize: 11),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Text(
              book.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
            Text(
              book.author,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, color: Colors.black54),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(taka(book.price),
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(width: 6),
                if (book.mrp > book.price)
                  Text(
                    taka(book.mrp),
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              height: 34,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF2B3F6B),
                  padding: EdgeInsets.zero,
                ),
                onPressed: () {
                  cart.add(book);
                  ScaffoldMessenger.of(context)
                    ..hideCurrentSnackBar()
                    ..showSnackBar(
                      const SnackBar(
                        content: Text('কার্টে যোগ হয়েছে'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                },
                child: const Text('কার্টে যোগ করুন', style: TextStyle(fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
