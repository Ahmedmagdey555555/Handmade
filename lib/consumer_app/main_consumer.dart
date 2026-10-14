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
    const ConsumerExploreTab(),
    const ConsumerCustomOrderTab(),
    const ConsumerOrdersTab(),
    const ConsumerProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text(
          'هاند ميد مصر - سوق التراث',
          style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: const Color(0xFF12181F),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
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
            icon: Icon(Icons.shopping_bag_outlined),
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

class ConsumerExploreTab extends StatelessWidget {
  const ConsumerExploreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2630),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: const Color(0xFFA97835).withOpacity(0.4)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'اقتنِ أصالة الصنعة المصرية 🏺',
                style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                'منتجات يدوية خالصة بضمان الجودة، مباشرة من ورش الحرفيين إليك.',
                style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'أبرز المنتجات المعروضة',
          style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ProductCard(
          title: 'صينية نحاس أصلي مطقوق يدوياً',
          artisan: 'ورشة المعلم إبراهيم - خان الخليلي',
          price: '1,250 ج.م',
          rating: '4.9',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const ProductDetailsScreen()),
            );
          },
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.title,
    required this.artisan,
    required this.price,
    required this.rating,
    required this.onTap,
  });

  final String title;
  final String artisan;
  final String price;
  final String rating;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF1E2630),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFA97835).withOpacity(0.2)),
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: const Color(0xFF12181F),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFB87733).withOpacity(0.5)),
              ),
              child: const Icon(Icons.image_outlined, color: Color(0xFFB87733), size: 30),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 3),
                  Text(artisan, style: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
                  const SizedBox(height: 6),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(price, style: const TextStyle(color: Color(0xFFB87733), fontWeight: FontWeight.bold, fontSize: 12)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 14),
                          const SizedBox(width: 4),
                          Text(rating, style: const TextStyle(color: Color(0xFFFEC7C2), fontSize: 11)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text('تفاصيل القطعة التراثية', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15)),
        backgroundColor: const Color(0xFF12181F),
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1E2630),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: const Color(0xFFA97835).withOpacity(0.4)),
              ),
              child: const Center(
                child: Icon(Icons.image_outlined, color: Color(0xFFB87733), size: 60),
              ),
            ),
            const SizedBox(height: 16),
            const Text('صينية نحاس أصلي مطقوق يدوياً', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 6),
            const Text('الصانع: ورشة المعلم إبراهيم - خان الخليلي', style: TextStyle(color: Color(0xFFB87733), fontSize: 12)),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB87733),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تمت إضافة المنتج إلى سلة المشتريات بنجاح!')),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined, size: 18),
                label: const Text('إضافة للسلة', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text('سلة المشتريات', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15)),
        backgroundColor: const Color(0xFF12181F),
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
      ),
      body: const Center(
        child: Text('سلة المشتريات فارغة حالياً', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 13)),
      ),
    );
  }
}

class ConsumerCustomOrderTab extends StatelessWidget {
  const ConsumerCustomOrderTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView(
        children: [
          const Text('اطلب قطعة فنية خاصة حسب مقاساتك', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          TextField(
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              labelText: 'صف تفصيل القطعة المطلوبة',
              labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
              filled: true,
              fillColor: const Color(0xFF1E2630),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: Border.none),
            ),
            maxLines: 4,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFB87733),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {},
            child: const Text('إرسال طلب التصميم الخاص', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class ConsumerOrdersTab extends StatelessWidget {
  const ConsumerOrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('لا توجد طلبات نشطة حالياً', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 12)),
    );
  }
}

// ----------------------------------------------------
// شاشة حساب العميل (متضمنة سياسة الخصوصية والشروط لج جوجل)
// ----------------------------------------------------
class ConsumerProfileTab extends StatelessWidget {
  const ConsumerProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        const Text('حساب العميل', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 16, fontWeight: FontWeight.bold)),
        const SizedBox(height: 16),
        const ListTile(
          leading: Icon(Icons.location_on_outlined, color: Color(0xFFB87733)),
          title: Text('عناوين الشحن', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13)),
        ),
        const Divider(color: Color(0xFF1E2630)),
        // سياسة الخصوصية
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined, color: Color(0xFFB87733)),
          title: const Text('سياسة الخصوصية', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13)),
          subtitle: const Text('معلومات حول حماية بياناتك الشخصية', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
            );
          },
        ),
        // الشروط والأحكام
        ListTile(
          leading: const Icon(Icons.description_outlined, color: Color(0xFFB87733)),
          title: const Text('الشروط والأحكام', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13)),
          subtitle: const Text('شروط الاستخدام وسياسة الطلبات', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
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

// صفحة سياسة الخصوصية
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
        child: SingleChildScrollView(
          child: Text(
            'نحن في تطبيق "هاند ميد مصر" نلتزم بحماية خصوصيتك وبياناتك الشخصية. يتم استخدام بياناتك (مثل الاسم ورقم الهاتف وعنوان الشحن) فقط لغرض إتمام وتوصيل طلبات المنتجات التراثية ومتابعة الشحن. لا نقوم بمشاركة بياناتك مع أي طرف ثالث إلا الجهات المسؤولة عن الشحن والتوصيل لضمان وصول طلبك بكفاءة وأمان.',
            style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13, height: 1.6),
          ),
        ),
      ),
    );
  }
}

// صفحة الشروط والأحكام
class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContextENT context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text('الشروط والأحكام', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15)),
        backgroundColor: const Color(0xFF12181F),
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Text(
            'باستخدامك لتطبيق "هاند ميد مصر"، فإنك توافق على الالتزام بشروط الاستخدام الخاصة بنا. جميع المنتجات المعروضة هي منتجات يدوية تراثية أصيلة وقد تختلف قليلاً في التفاصيل الدقيقة نظراً لطبيعتها اليدوية الخالصة. يحق للإدارة مراجعة الطلبات وتعديلها بما يضمن حقوق الحرفي والعميل.',
            style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13, height: 1.6),
          ),
        ),
      ),
    );
  }
}
