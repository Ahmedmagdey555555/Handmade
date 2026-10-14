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

class StorefrontTab extends StatelessWidget {
  const StorefrontTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
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
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
          maxLines: 4,
        ),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
