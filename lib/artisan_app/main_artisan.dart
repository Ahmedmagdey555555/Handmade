import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HandmadeEgyptArtisanApp());
}

class HandmadeEgyptArtisanApp extends StatelessWidget {
  const HandmadeEgyptArtisanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'هاند ميد مصر - بوابة التاجر والورش',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF12181F),
        primaryColor: const Color(0xFFB87733),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFFB87733),
          secondary: Color(0xFFA97835),
          surface: Color(0xFF1E2630),
        ),
        fontFamily: 'Cairo',
      ),
      locale: const Locale('ar', 'EG'),
      supportedLocales: const [
        Locale('ar', 'EG'),
        Locale('en', 'US'),
      ],
      home: const ArtisanRegisterScreen(),
    );
  }
}

// 1. شاشة تسجيل التاجر والالتقاط الحي للسيلفي والبطاقة
class ArtisanRegisterScreen extends StatefulWidget {
  const ArtisanRegisterScreen({super.key});

  @override
  State<ArtisanRegisterScreen> createState() => _ArtisanRegisterScreenState();
}

class _ArtisanRegisterScreenState extends State<ArtisanRegisterScreen> {
  final _workshopNameController = TextEditingController();
  final _ownerNameController = TextEditingController();
  final _phoneController = TextEditingController();
  String _selectedCategory = 'حفر ليزر وطباعة';
  bool _selfieCaptured = false;
  bool _idCaptured = false;

  final List<String> _categories = [
    'الملابس والعبايات',
    'كروشيه وزخارف',
    'حفر ليزر وطباعة',
    'نحاسيات وخشب',
    'تحف وفخار وسجاد',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text('تسجيل ورشة / صانع جديد', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 16)),
        backgroundColor: const Color(0xFF12181F),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('انضم لمنصة هاند ميد مصر 🛠️', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('يرجى ملء البيانات وإرفاق الصور المطلوبة لتوثيق الورشة من قِبل الإدارة.', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11)),
            const SizedBox(height: 20),
            TextField(
              controller: _workshopNameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'اسم الورشة / العلامة التجارية',
                labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                filled: true,
                fillColor: const Color(0xFF1E2630),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _ownerNameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'اسم صاحب الورشة بالكامل',
                labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                filled: true,
                fillColor: const Color(0xFF1E2630),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'رقم الهاتف المحمول (المرتبط بمحفظة كاش)',
                labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                filled: true,
                fillColor: const Color(0xFF1E2630),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              dropdownColor: const Color(0xFF1E2630),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'تخصص الورشة الرئيسي',
                labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                filled: true,
                fillColor: const Color(0xFF1E2630),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
              ),
              items: _categories.map((c) => DropdownMenuItem(value: c, child: Text(c))).toList(),
              onChanged: (val) => setState(() => _selectedCategory = val!),
            ),
            const SizedBox(height: 20),
            const Text('التحقق من الهوية (إلزامي للتوثيق):', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selfieCaptured ? Colors.green.shade900 : const Color(0xFF1E2630),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      setState(() => _selfieCaptured = true);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم التقاط الصورة الشخصية السيلفي 📸')));
                    },
                    icon: Icon(_selfieCaptured ? Icons.check_circle : Icons.camera_front),
                    label: Text(_selfieCaptured ? 'تم السيلفي' : 'صورة سيلفي حية', style: const TextStyle(fontSize: 11)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _idCaptured ? Colors.green.shade900 : const Color(0xFF1E2630),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onPressed: () {
                      setState(() => _idCaptured = true);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم رفع صورة بطاقة الرقم القومي 🪪')));
                    },
                    icon: Icon(_idCaptured ? Icons.check_circle : Icons.badge_outlined),
                    label: Text(_idCaptured ? 'تمت البطاقة' : 'صورة البطاقة', style: const TextStyle(fontSize: 11)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB87733),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              onPressed: () {
                if (!_selfieCaptured || !_idCaptured) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('يرجى التقاط السيلفي وصورة البطاقة لإتمام طلب التسجيل')),
                  );
                  return;
                }
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const PendingApprovalScreen()),
                );
              },
              child: const Text('إرسال طلب الانضمام للإدارة', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}

// 2. شاشة الانتظار وتعليق الحساب حتى موافقة الأدمن
class PendingApprovalScreen extends StatelessWidget {
  const PendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.hourglass_top_rounded, color: Colors.amber, size: 70),
            const SizedBox(height: 20),
            const Text(
              'حسابك قيد المراجعة والتوثيق ⏳',
              style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'تم استلام بياناتك والصور بنجاح. يتم حالياً مراجعة طلبك من قِبل إدارة "هاند ميد مصر" وسيتم تفعيل حسابك خلال ساعات.',
              style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 12, height: 1.5),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            OutlinedButton(
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFFB87733)),
                foregroundColor: const Color(0xFFB87733),
              ),
              onPressed: () {
                // وضع تجريبي للانتقال للوحة التحكم
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ArtisanDashboardScreen()),
                );
              },
              child: const Text('الدخول للوحة التحكم (معاينة تجريبية)'),
            ),
          ],
        ),
      ),
    );
  }
}

// 3. لوحة تحكم التاجر الرئيسية
class ArtisanDashboardScreen extends StatefulWidget {
  const ArtisanDashboardScreen({super.key});

  @override
  State<ArtisanDashboardScreen> createState() => _ArtisanDashboardScreenState();
}

class _ArtisanDashboardScreenState extends State<ArtisanDashboardScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const ArtisanHomeTab(),
    const AddProductTab(),
    const ArtisanOrdersTab(),
    const SubscriptionsAndAdsTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text('ورشة أرت ليزر - هاند ميد مصر', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 16)),
        backgroundColor: const Color(0xFF12181F),
        elevation: 0,
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1E2630),
        selectedItemColor: const Color(0xFFB87733),
        unselectedItemColor: const Color(0xFF9E9E9E),
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard_outlined), label: 'الرئيسية'),
          BottomNavigationBarItem(icon: Icon(Icons.add_box_outlined), label: 'إضافة منتج'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt_outlined), label: 'الطلبات'),
          BottomNavigationBarItem(icon: Icon(Icons.star_border_outlined), label: 'الباقات والترويج'),
        ],
      ),
    );
  }
}

// تبويب الإحصائيات والأرباح
class ArtisanHomeTab extends StatelessWidget {
  const ArtisanHomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2630),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFA97835).withOpacity(0.3)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('المحفظة والأرباح (نظام الضمان 🔒)', style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 13)),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('رصيد متاح للسحب:', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
                      Text('3,820 ج.م', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('أرباح معلقة (تحت التوصيل):', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
                      Text('1,450 ج.م', style: TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 16)),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text('تنبيهات الشحن والتغليف الرسمي 📦', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2630),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Text(
            '⚠️ تعليمات هامة: ملزم برفق كارت ضمان "Handmade Egypt" مطبوع مع رقم باركود الطلب داخل الشحنة، والتغليف الخارجي بأكياس المنصة الرسمية.',
            style: TextStyle(color: Colors.white, fontSize: 11, height: 1.4),
          ),
        ),
      ],
    );
  }
}

// تبويب إضافة منتج جديد مع شهادة الضمان والمدة
class AddProductTab extends StatelessWidget {
  const AddProductTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('إضافة قطعة يدوية جديدة 🎨', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF1E2630),
            foregroundColor: const Color(0xFFB87733),
            padding: const EdgeInsets.symmetric(vertical: 20),
          ),
          onPressed: () {},
          icon: const Icon(Icons.add_a_photo_outlined),
          label: const Text('رفع صور القطعة اليدوية (3 صور على الأقل)'),
        ),
        const SizedBox(height: 12),
        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'اسم القطعة اليدوية',
            labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
            filled: true,
            fillColor: const Color(0xFF1E2630),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'السعر للعميل (ج.م)',
            labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
            filled: true,
            fillColor: const Color(0xFF1E2630),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
          keyboardType: TextInputType.number,
        ),
        const SizedBox(height: 12),
        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'مدة التجهيز والتفصيل (مثال: 3 أيام) أو المتاح بالمخزن',
            labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
            filled: true,
            fillColor: const Color(0xFF1E2630),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 12),
        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'مدة الضمان الإلزامية (مثال: سنة ضد عيوب الصناعة)',
            labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
            filled: true,
            fillColor: const Color(0xFF1E2630),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB87733),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم رفع المنتج وبانتظار الموافقة السريعة من الأدمن!')));
          },
          child: const Text('نشر المنتج بالمتجر', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

// تبويب الطلبات والتحويل لنقطة التجميع وإخطار الأدمن بالانتهاء
class ArtisanOrdersTab extends StatelessWidget {
  const ArtisanOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('إدارة الطلبات الواردة 🛒', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2630),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFA97835).withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('طلب #ORD-9901', style: TextStyle(color: Color(0xFFB87733), fontWeight: FontWeight.bold)),
                  Text('جاري التجهيز ⏳', style: TextStyle(color: Colors.amber, fontSize: 11)),
                ],
              ),
              const SizedBox(height: 6),
              const Text('القطعة: عباية مطرزة يدوياً - شغل سيوي', style: TextStyle(color: Colors.white, fontSize: 12)),
              const Text('السعر: 1,450 ج.م (عمولة المنصة 10%: 145 ج.م)', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
              const SizedBox(height: 12),
              const Text('طريقة الشحن والتسليم:', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 11, fontWeight: FontWeight.bold)),
              const Text('📍 نقطة تجميع هاند ميد مصر: الجيزة - الفلكي (سيتم إرسال اللوكيشن)', style: TextStyle(color: Colors.white, fontSize: 10)),
              const SizedBox(height: 14),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green.shade800,
                  foregroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 40),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم إرسال إشعار للإدارة بانتهاء تجهيز الطلب وإرفاق كارت الضمان! 🔔')),
                  );
                },
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: const Text('تم انتهاء التجهيز (إشعارات الأدمن)'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// تبويب الباقات والاشتراكات الشهرية والإعلانات
class SubscriptionsAndAdsTab extends StatelessWidget {
  const SubscriptionsAndAdsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('باقات الاشتراكات والإعلانات ⭐', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2630),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFB87733)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('الباقة الاحترافية VIP 🚀', style: TextStyle(color: Color(0xFFB87733), fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 6),
              const Text('• رفع منتجات غير محدودة\n• نسبة عمولة تخفيضية 8% بدلاً من 15%\n• أولوية الظهور في نتائج البحث', style: TextStyle(color: Colors.white, fontSize: 11, height: 1.5)),
              const SizedBox(height: 10),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB87733)),
                onPressed: () {},
                child: const Text('الاشتراك بـ 250 ج.م / شهرياً'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2630),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('طلب إعلان في بنر العملاء الرئيسي 📢', style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 13)),
              const SizedBox(height: 4),
              const Text('اعرض منتجك أو ورشتك لأكثر من 50,000 زائر في أعلى شاشة العميل.', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
              const SizedBox(height: 10),
              OutlinedButton(
                style: OutlinedButton.styleFrom(side: const BorderSide(color: Color(0xFFB87733)), foregroundColor: const Color(0xFFB87733)),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال طلب الإعلان للإدارة للمراجعة وتحديد التكلفة.')));
                },
                child: const Text('طلب حجز بنر إعلاني'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
