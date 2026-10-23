import 'package:flutter/material.dart';
import '../cart_controller.dart';
import '../fake_backend.dart';
import '../models.dart';
import 'order_success_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const _primary = Color(0xFF2B3F6B);
  final _cart = CartController.instance;
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _phone = TextEditingController();
  final _address = TextEditingController();
  final _sender = TextEditingController();
  final _trx = TextEditingController();

  DeliveryArea _area = DeliveryArea.dhaka;
  PaymentMethod _method = PaymentMethod.bkash;
  bool _loading = false;

  int get _total => _cart.subtotal + _area.fee;

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _address.dispose();
    _sender.dispose();
    _trx.dispose();
    super.dispose();
  }

  String? _required(String? v, String msg) =>
      (v == null || v.trim().isEmpty) ? msg : null;

  String? _validPhone(String? v) {
    final s = (v ?? '').trim();
    if (!RegExp(r'^01[0-9]{9}$').hasMatch(s)) {
      return '১১ digit এর সঠিক মোবাইল নম্বর দিন (01XXXXXXXXX)';
    }
    return null;
  }

  Future<void> _placeOrder() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _loading = true);

    final result = await StoreServices.payment.pay(
      method: _method,
      amount: _total,
      senderNumber: _sender.text.trim(),
      trxId: _trx.text.trim(),
    );
    if (!mounted) return;
    if (!result.success) {
      setState(() => _loading = false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result.message)));
      return;
    }

    final order = await StoreServices.orders.placeOrder(
      items: _cart.items,
      deliveryFee: _area.fee,
      name: _name.text.trim(),
      phone: _phone.text.trim(),
      address: _address.text.trim(),
      area: _area,
      method: _method,
      paymentRef: result.reference,
    );
    _cart.clear();
    if (!mounted) return;
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => OrderSuccessScreen(order: order)),
      (route) => route.isFirst,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('চেকআউট'),
        backgroundColor: _primary,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _section('ডেলিভারি তথ্য'),
                TextFormField(
                  controller: _name,
                  decoration: _dec('আপনার নাম', Icons.person),
                  validator: (v) => _required(v, 'নাম লিখুন'),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _phone,
                  keyboardType: TextInputType.phone,
                  decoration: _dec('মোবাইল নম্বর', Icons.phone),
                  validator: _validPhone,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  controller: _address,
                  maxLines: 2,
                  decoration: _dec('সম্পূর্ণ ঠিকানা', Icons.location_on),
                  validator: (v) => _required(v, 'ঠিকানা লিখুন'),
                ),
                const SizedBox(height: 12),
                for (final a in DeliveryArea.values) ...[
                  _OptionTile(
                    selected: _area == a,
                    icon: Icons.local_shipping_outlined,
                    title: a.label,
                    subtitle: 'ডেলিভারি চার্জ ${taka(a.fee)}',
                    onTap: () => setState(() => _area = a),
                  ),
                  const SizedBox(height: 8),
                ],
                const SizedBox(height: 8),
                _section('পেমেন্ট পদ্ধতি'),
                for (final m in PaymentMethod.values) ...[
                  _OptionTile(
                    selected: _method == m,
                    icon: m.icon,
                    title: m.label,
                    onTap: () => setState(() => _method = m),
                  ),
                  const SizedBox(height: 8),
                ],
                if (_method.needsTrx) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade50,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber.shade300),
                    ),
                    child: Text(
                      '(ডেমো) ${_method.label} নম্বর 01XXXXXXXXX এ ${taka(_total)} Send Money করুন, '
                      'তারপর নিচে আপনার নম্বর ও TrxID দিন।\n'
                      'টেস্ট: TrxID তে FAIL লিখলে পেমেন্ট ব্যর্থ হবে।',
                      style: const TextStyle(fontSize: 13),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _sender,
                    keyboardType: TextInputType.phone,
                    decoration: _dec('যে নম্বর থেকে পাঠিয়েছেন', Icons.phone_android),
                    validator: _validPhone,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _trx,
                    decoration: _dec('Transaction ID (TrxID)', Icons.confirmation_number),
                    validator: (v) => (v == null || v.trim().length < 4)
                        ? 'সঠিক TrxID দিন'
                        : null,
                  ),
                  const SizedBox(height: 12),
                ],
                _section('অর্ডার সারাংশ'),
                ListenableBuilder(
                  listenable: _cart,
                  builder: (context, _) => Column(
                    children: [
                      for (final it in _cart.items)
                        _line('${it.book.title} × ${bn(it.qty)}', taka(it.total)),
                      const Divider(),
                      _line('সাবটোটাল', taka(_cart.subtotal)),
                      _line('ডেলিভারি চার্জ', taka(_area.fee)),
                      const Divider(),
                      _line('সর্বমোট', taka(_total), bold: true),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: _primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _loading ? null : _placeOrder,
                  child: _loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : Text(
                          _method.needsTrx ? 'পেমেন্ট কনফার্ম করুন' : 'অর্ডার কনফার্ম করুন',
                          style: const TextStyle(fontSize: 16),
                        ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  InputDecoration _dec(String label, IconData icon) => InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      );

  Widget _section(String t) => Padding(
        padding: const EdgeInsets.only(bottom: 10, top: 4),
        child: Text(t, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
      );

  Widget _line(String l, String r, {bool bold = false}) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 3),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(l,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: bold ? FontWeight.bold : null)),
            ),
            const SizedBox(width: 8),
            Text(r,
                style: TextStyle(
                    fontWeight: bold ? FontWeight.bold : null,
                    fontSize: bold ? 18 : null)),
          ],
        ),
      );
}

class _OptionTile extends StatelessWidget {
  final bool selected;
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _OptionTile({
    required this.selected,
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF2B3F6B);
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFFE8ECF5) : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? primary : Colors.grey.shade300,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? primary : Colors.black54),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
                  if (subtitle != null)
                    Text(subtitle!,
                        style: const TextStyle(fontSize: 12, color: Colors.black54)),
                ],
              ),
            ),
            Icon(
              selected ? Icons.check_circle : Icons.circle_outlined,
              color: selected ? primary : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
