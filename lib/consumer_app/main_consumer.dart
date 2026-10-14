import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HandmadeEgyptConsumerApp());
}

class HandmadeEgyptConsumerApp extends StatelessWidget {
  const HandmadeEgyptConsumerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handmade Egypt - Consumer',
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
      home: const ConsumerHomeScreen(),
    );
  }
}

class ConsumerHomeScreen extends StatefulWidget {
  const ConsumerHomeScreen({super.key});

  @override
  State<ConsumerHomeScreen> createState() => _ConsumerHomeScreenState();
}

class _ConsumerHomeScreenState extends State<ConsumerHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const StorefrontTab(),
    const CustomOrderTab(),
    const OrdersHistoryTab(),
    const ConsumerProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text(
          'هاند ميد مصر',
          style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 18),
        ),
        backgroundColor: const Color(0xFF12181F),
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart_outlined, color: Color(0xFFB87733)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1E2630),
        selectedItemColor: const Color(0xFFB87733),
        unselectedItemColor: const Color(0xFF9E9E9E),
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.storefront_outlined),
            label: 'المتجر',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.design_services_outlined),
            label: 'طلب خاص',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long_outlined),
            label: 'طلباتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'حسابي',
          ),
        ],
      ),
    );
  }
}

// 1. الواجهة الرئيسية للمتجر
class StorefrontTab extends StatelessWidget {
  const StorefrontTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // قسم الترحيب
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2630),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFA97835).withOpacity(0.3)),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFB87733),
                child: Icon(Icons.person, color: Colors.white),
              ),
              SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('مرحباً بك يا عشاق التراث 🖐️', style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 13)),
                  Text('اكتشف أصالة الصنعة المصرية من ورش هاند ميد مصر', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),

        // شريط البحث الفوري
        TextField(
          style: const TextStyle(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: 'ابحث عن حفر ليزر، طباعة، عبايات مطرزة، نحاسيات...',
            hintStyle: const TextStyle(color: Color(0xFF666666), fontSize: 11),
            prefixIcon: const Icon(Icons.search, color: Color(0xFFB87733)),
            filled: true,
            fillColor: const Color(0xFF1E2630),
            contentPadding: const EdgeInsets.symmetric(vertical: 0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 16),

        // بنر الإعلانات الترويجي
        SizedBox(
          height: 120,
          child: PageView(
            children: [
              _buildAdBanner(
                title: '✨ قسم حفر الليزر والطباعة الحرارية',
                subtitle: 'هدايا مخصصة وتصاميم بالاسم حسب الطلب',
                badgeText: 'جديد المنصة',
                color: const Color(0xFFB87733),
              ),
              _buildAdBanner(
                title: '🧕 تشكيلة العبايات والتطريز اليدوي',
                subtitle: 'أحدث صيحات الأزياء التراثية والشغل السيوي',
                badgeText: 'عرض خاص',
                color: const Color(0xFFA97835),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // الأقسام التراثية واليدوية
        const Text(
          'الأقسام التراثية واليدوية',
          style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 95,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _CategoryItem(icon: Icons.cut_outlined, title: 'حفر ليزر'),
              _CategoryItem(icon: Icons.print_outlined, title: 'طباعة وتجهيز'),
              _CategoryItem(icon: Icons.dry_cleaning_outlined, title: 'ملابس وتطريز'),
              _CategoryItem(icon: Icons.coffee_outlined, title: 'نحاسيات'),
              _CategoryItem(icon: Icons.chair_outlined, title: 'أخشاب وأرابيسك'),
              _CategoryItem(icon: Icons.rice_bowl_outlined, title: 'تحف وفخار'),
              _CategoryItem(icon: Icons.grid_on_outlined, title: 'سجاد يدوي'),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // قائمة القطع المعروضة
        const Text(
          'أحدث القطع المعروضة',
          style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.75,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
          ),
          itemCount: 4,
          itemBuilder: (context, index) {
            return const ProductCard();
          },
        ),
      ],
    );
  }

  static Widget _buildAdBanner({
    required String title,
    required String subtitle,
    required String badgeText,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(right: 6),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2630),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
            child: Text(badgeText, style: const TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(height: 6),
          Text(title, style: const TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 2),
          Text(subtitle, style: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
        ],
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  const _CategoryItem({required this.icon, required this.title});
  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      margin: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2630),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFA97835).withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: const Color(0xFFB87733), size: 24),
          const SizedBox(height: 6),
          Text(
            title,
            style: const TextStyle(color: Color(0xFFFEC7C2), fontSize: 10),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1E2630),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFA97835).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF12181F),
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
              ),
              child: const Center(
                child: Icon(Icons.image_outlined, color: Color(0xFFB87733), size: 40),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('تابلوه خشبي حفر ليزر بالاسم', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 11, fontWeight: FontWeight.bold), maxLines: 1),
                const SizedBox(height: 2),
                const Text('ورشة أرت ليزر', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 9)),
                const SizedBox(height: 6),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('450 ج.م', style: TextStyle(color: Color(0xFFB87733), fontWeight: FontWeight.bold, fontSize: 12)),
                    Icon(Icons.add_shopping_cart, color: Color(0xFFB87733), size: 16),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// 2. تبويب طلب تفصيل خاص
class CustomOrderTab extends StatelessWidget {
  const CustomOrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        const Text('طلب تفصيل قطعة خاصة 🛠️', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 6),
        const Text('اكتب مواصفات القطعة التراثية أو طلب الطباعة والحفر بالليزر والملابس المطرزة، وستقوم الإدارة بتحويل الطلب للورش المختصة.', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11, height: 1.4)),
        const SizedBox(height: 20),
        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'وصف الطلب المقاسات / الاسم للحفر والطباعة / المقاسات للملابس',
            labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
            filled: true,
            fillColor: const Color(0xFF1E2630),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide(color: Colors.transparent)),
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFB87733),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم إرسال طلبك الخاص للإدارة، وسنوافيك بالرد فور مراجعته!')),
            );
          },
          icon: const Icon(Icons.send_outlined),
          label: const Text('إرسال الطلب للإدارة', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

// 3. تبويب سجل الطلبات وتتبع الشحن
class OrdersHistoryTab extends StatelessWidget {
  const OrdersHistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('طلباتي ومتابعة الشحن', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2630),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFA97835).withOpacity(0.2)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('#ORD-9901', style: TextStyle(color: Color(0xFFB87733), fontWeight: FontWeight.bold, fontSize: 12)),
                  Text('جاري الشحن 🚚', style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              const Text('عباية مطرزة يدوياً شغل سيوي', style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 12)),
              const Text('الإجمالي: 1,850 ج.م', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11)),
              const SizedBox(height: 12),
              const LinearProgressIndicator(value: 0.75, color: Color(0xFFB87733), backgroundColor: Color(0xFF12181F)),
              const SizedBox(height: 6),
              const Text('حالة الشحنة: تم المرور بنقطة التجميع وتغليف هاند ميد مصر وجاري التوصيل لك', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
            ],
          ),
        ),
      ],
    );
  }
}

// 4. تبويب الحساب والدعم والسياسات
class ConsumerProfileTab extends StatelessWidget {
  const ConsumerProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        const Text('الحساب والدعم والسياسات', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        ListTile(
          leading: const Icon(Icons.support_agent_outlined, color: Color(0xFFB87733)),
          title: const Text('الدعم الفني والخدمة', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13)),
          subtitle: const Text('تواصل مباشر مع فريق هاند ميد مصر', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
          onTap: () {},
        ),
        const Divider(color: Color(0xFF1E2630)),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined, color: Color(0xFFB87733)),
          title: const Text('سياسة الخصوصية', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.description_outlined, color: Color(0xFFB87733)),
          title: const Text('الشروط والأحكام', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const TermsScreen()),
            );
          },
        ),
      ],
    );
  }
}

// شاشة سلة المشتريات وتحديد طريقة الدفع
class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _selectedPaymentMethod = 'cash_wallet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text('سلة المشتريات والدفع', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 16)),
        backgroundColor: const Color(0xFF12181F),
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text('اختر طريقة الدفع المناسبة', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          
          // 1. المحافظ الإلكترونية + الدفع عند الاستلام (متاحة)
          RadioListTile<String>(
            value: 'cash_wallet',
            groupValue: _selectedPaymentMethod,
            activeColor: const Color(0xFFB87733),
            title: const Text('محفظة كاش / الدفع عند المعاينة والاستلام', style: TextStyle(color: Colors.white, fontSize: 13)),
            subtitle: const Text('فودافون كاش / أورنج / إتصلات / WE / الاستلام يد بيد', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
            onChanged: (val) {
              setState(() {
                _selectedPaymentMethod = val!;
              });
            },
          ),
          
          // 2. إنستا باي InstaPay (مغلقة - قريباً)
          RadioListTile<String>(
            value: 'instapay',
            groupValue: _selectedPaymentMethod,
            title: Row(
              children: [
                const Text('إنستا باي (InstaPay)', style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
                  child: const Text('قريباً', style: TextStyle(color: Colors.amber, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            subtitle: const Text('سيتم تفعيل الدفع المباشر عبر تطبيق إنستا باي فور الربط', style: TextStyle(color: Colors.grey, fontSize: 10)),
            onChanged: null, // تعطيل الاختيار حالياً
          ),

          // 3. كارت الفيزا / الماستر كارد (مغلقة - قريباً)
          RadioListTile<String>(
            value: 'card',
            groupValue: _selectedPaymentMethod,
            title: Row(
              children: [
                const Text('البطاقات البنكية (فيزا / ماستر كارد)', style: TextStyle(color: Colors.grey, fontSize: 13)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
                  child: const Text('قريباً', style: TextStyle(color: Colors.amber, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            subtitle: const Text('الدفع المباشر عبر البوابة الإلكترونية', style: TextStyle(color: Colors.grey, fontSize: 10)),
            onChanged: null, // تعطيل الاختيار حالياً
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
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إرسال الطلب وسيتم التواصل معك لتعليمات الدفع والتسليم!')),
              );
            },
            child: const Text('تأكيد الطلب وإتمام الشراء', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}// أضف هذا التبويب أو الشاشة ضمن تفاصيل طلبات العميل للاستلام والتقييم
class OrderReviewScreen extends StatelessWidget {
  const OrderReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text('تقييم القطعة ورفع الصور', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15)),
        backgroundColor: const Color(0xFF12181F),
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          const Text('شاركنا صورتك للقطعة التراثية بعد الاستلام', style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 14)),
          const SizedBox(height: 10),
          const Text('ملاحظة: سيتم مراجعة الصورة من قِبل إدارة هاند ميد مصر ونشرها بالمتجر بعد الموافقة.', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2630),
              foregroundColor: const Color(0xFFB87733),
              side: const BorderSide(color: Color(0xFFB87733)),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم إرسال الصورة للإدارة للمراجعة والنشر!')),
              );
            },
            icon: const Icon(Icons.camera_alt_outlined),
            label: const Text('إرفاق صورة القطعة الحقيقية'),
          ),
        ],
      ),
    );
  }
}


class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text('سياسة الخصوصية', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15)),
        backgroundColor: const Color(0xFF12181F),
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'تلتزم منصة "هاند ميد مصر" بحماية بيانات جميع العملاء والمستخدمين. البيانات التي يتم جمعها (كالاسم ورقم الهاتف وعنوان التوصيل) تُستخدم فقط لإتمام وإدارة طلبك وشحنه بأمان.',
          style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13, height: 1.6),
        ),
      ),
    );
  }
}

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text('الشروط والأحكام', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15)),
        backgroundColor: const Color(0xFF12181F),
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'المنتجات المعروضة على منصة "هاند ميد مصر" هي منتجات يدوية وتراثية 100%. قد توجد بعض الاختلافات الدقيقة الطبيعية بين قطعة وأخرى نظراً لطبيعة الصنعة اليدوية الفريدة.',
          style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13, height: 1.6),
        ),
      ),
    );
  }
}
