import 'package:flutter/material.dart';
import '../data/quiz_data.dart';

/// ফ্রী পরিক্ষা: একটা একটা করে প্রশ্ন → উত্তর দিলে সঠিক/ভুল দেখাবে → শেষে স্কোর
class QuizScreen extends StatefulWidget {
  final String title;
  final Color color;
  final List<QuizQuestion> questions;

  const QuizScreen({
    super.key,
    required this.title,
    required this.color,
    this.questions = freeExamQuestions,
  });

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _index = 0;
  int _score = 0;
  int? _selected;
  bool _finished = false;

  QuizQuestion get _q => widget.questions[_index];
  bool get _answered => _selected != null;

  void _select(int i) {
    if (_answered) return;
    setState(() {
      _selected = i;
      if (i == _q.answer) _score++;
    });
  }

  void _next() {
    setState(() {
      if (_index + 1 >= widget.questions.length) {
        _finished = true;
      } else {
        _index++;
        _selected = null;
      }
    });
  }

  void _restart() {
    setState(() {
      _index = 0;
      _score = 0;
      _selected = null;
      _finished = false;
    });
  }

  Color _optionColor(int i) {
    if (!_answered) return Colors.white;
    if (i == _q.answer) return Colors.green.shade100;
    if (i == _selected) return Colors.red.shade100;
    return Colors.white;
  }

  Color _optionBorder(int i) {
    if (!_answered) return Colors.grey.shade400;
    if (i == _q.answer) return Colors.green;
    if (i == _selected) return Colors.red;
    return Colors.grey.shade300;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
        foregroundColor: Colors.white,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: _finished ? _buildResult() : _buildQuestion(),
        ),
      ),
    );
  }

  Widget _buildQuestion() {
    final total = widget.questions.length;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'প্রশ্ন ${_index + 1} / $total',
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 6),
          LinearProgressIndicator(
            value: (_index + 1) / total,
            color: widget.color,
            minHeight: 6,
            borderRadius: BorderRadius.circular(6),
          ),
          const SizedBox(height: 24),
          Text(
            _q.question,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemCount: _q.options.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, i) {
                return InkWell(
                  borderRadius: BorderRadius.circular(14),
                  onTap: () => _select(i),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: _optionColor(i),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: _optionBorder(i), width: 1.5),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            _q.options[i],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        if (_answered && i == _q.answer)
                          const Icon(Icons.check_circle, color: Colors.green),
                        if (_answered && i == _selected && i != _q.answer)
                          const Icon(Icons.cancel, color: Colors.red),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: widget.color,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: _answered ? _next : null,
            child: Text(
              _index + 1 == total ? 'ফলাফল দেখুন' : 'পরের প্রশ্ন',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResult() {
    final total = widget.questions.length;
    final percent = (_score * 100 / total).round();
    final msg = percent >= 80
        ? 'চমৎকার! 🎉'
        : percent >= 50
            ? 'ভালো, আরও অনুশীলন করুন'
            : 'আবার চেষ্টা করুন 💪';
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.emoji_events, size: 90, color: widget.color),
          const SizedBox(height: 16),
          Text(
            '$_score / $total',
            style: TextStyle(
              fontSize: 48,
              fontWeight: FontWeight.bold,
              color: widget.color,
            ),
          ),
          const SizedBox(height: 4),
          Text('$percent%', style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 12),
          Text(msg, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 32),
          FilledButton.icon(
            style: FilledButton.styleFrom(backgroundColor: widget.color),
            onPressed: _restart,
            icon: const Icon(Icons.refresh),
            label: const Text('আবার দিন'),
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('হোমে ফিরুন'),
          ),
        ],
      ),
    );
  }
}
