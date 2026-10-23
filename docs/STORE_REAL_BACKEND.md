# বই কিনুন: ফেক থেকে রিয়েল করার গাইড

সব ফেক লজিক আছে `lib/store/fake_backend.dart` এ। UI (screens) শুধু নিচের ৩টি interface এর সাথে কথা বলে,
তাই আসল backend বসালে UI বদলাতে হবে না।

| ফেক ক্লাস | বদলে যা বসবে | কাজ |
|---|---|---|
| `FakeBookRepository` | `ApiBookRepository` / Firestore | বইয়ের তালিকা, ছবি (Book এ `imageUrl` যোগ করবে, `BookCover` এ Image.network) |
| `FakePaymentService` | bKash/Nagad/SSLCommerz API | আসল পেমেন্ট ভেরিফাই (সার্ভার সাইডে TrxID যাচাই করা জরুরি) |
| `FakeOrderRepository` | API/Firestore | অর্ডার সেভ, স্ট্যাটাস আপডেট, user অনুযায়ী ইতিহাস |

## বদলানোর জায়গা (একটাই)
`StoreServices` ক্লাসে:
```dart
static BookRepository books = ApiBookRepository();
static PaymentService payment = SslCommerzPaymentService();
static OrderRepository orders = ApiOrderRepository();
```

## রিয়েল করার আগে যা লাগবে
- Login (ধাপ: Firebase Auth) যাতে অর্ডার user এর সাথে বাঁধা থাকে
- পেমেন্ট গেটওয়ের merchant অ্যাকাউন্ট ও সার্ভার (Cloud Functions ইত্যাদি); secret key অ্যাপে রাখা যাবে না
- কার্ট লোকাল স্টোরেজে সেভ (shared_preferences)
- অ্যাডমিন প্যানেল: বই যোগ, অর্ডার স্ট্যাটাস বদল
