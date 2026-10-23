class QuizQuestion {
  final String question;
  final List<String> options;
  final int answer; // সঠিক অপশনের index (0 থেকে শুরু)

  const QuizQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });
}

/// ফ্রী পরিক্ষা: নমুনা প্রশ্ন (পরে সার্ভার/Firebase থেকে আসবে)
const List<QuizQuestion> freeExamQuestions = [
  QuizQuestion(
    question: 'বাংলাদেশের রাজধানীর নাম কী?',
    options: ['চট্টগ্রাম', 'ঢাকা', 'রাজশাহী', 'খুলনা'],
    answer: 1,
  ),
  QuizQuestion(
    question: 'বাংলাদেশের জাতীয় ফুল কোনটি?',
    options: ['গোলাপ', 'বেলি', 'শাপলা', 'কৃষ্ণচূড়া'],
    answer: 2,
  ),
  QuizQuestion(
    question: 'বাংলাদেশ কত সালে স্বাধীনতা অর্জন করে?',
    options: ['১৯৪৭', '১৯৫২', '১৯৭১', '১৯৭৫'],
    answer: 2,
  ),
  QuizQuestion(
    question: 'বাংলাদেশের জাতীয় কবি কে?',
    options: [
      'রবীন্দ্রনাথ ঠাকুর',
      'কাজী নজরুল ইসলাম',
      'জসীমউদ্দীন',
      'জীবনানন্দ দাশ',
    ],
    answer: 1,
  ),
  QuizQuestion(
    question: 'বাংলাদেশের জাতীয় পশু কোনটি?',
    options: ['হাতি', 'বাঘ (রয়েল বেঙ্গল টাইগার)', 'হরিণ', 'ভালুক'],
    answer: 1,
  ),
  QuizQuestion(
    question: 'বিজয় দিবস কত তারিখে পালিত হয়?',
    options: ['২৬ মার্চ', '২১ ফেব্রুয়ারি', '১৬ ডিসেম্বর', '১৫ আগস্ট'],
    answer: 2,
  ),
  QuizQuestion(
    question: 'আন্তর্জাতিক মাতৃভাষা দিবস কবে?',
    options: ['২১ ফেব্রুয়ারি', '১৭ মার্চ', '১ বৈশাখ', '১৪ এপ্রিল'],
    answer: 0,
  ),
  QuizQuestion(
    question: 'বাংলাদেশের মুদ্রার নাম কী?',
    options: ['রুপি', 'টাকা', 'রিয়াল', 'ডলার'],
    answer: 1,
  ),
  QuizQuestion(
    question: 'বাংলাদেশের জাতীয় ফল কোনটি?',
    options: ['আম', 'কলা', 'লিচু', 'কাঁঠাল'],
    answer: 3,
  ),
  QuizQuestion(
    question: 'বাংলাদেশের বিখ্যাত সমুদ্র সৈকত কোনটি?',
    options: ['কক্সবাজার', 'সিলেট', 'বগুড়া', 'ময়মনসিংহ'],
    answer: 0,
  ),
];
