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
      title: 'هاند ميد مصر',
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
      home: const LoginScreen(),
    );
  }
}

// 1. شاشة تسجيل الدخول وتحديد الموقع (معدلة لتجنب أخطاء العرض واللون الرمادي)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  bool _fetchingLocation = false;

  void _getDeviceLocation() {
    setState(() {
      _fetchingLocation = true;
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (!mounted) return;
      setState(() {
        _fetchingLocation = false;
        _addressController.text = 'القاهرة، شارع المعز، بالقرب من باب الفتوح';
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('تم تحديد موقعك الجغرافي بنجاح عبر الـ GPS 📍')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(24.0),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.minHeight),
                child: IntrinsicHeight(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),
                      const Icon(Icons.handyman, color: Color(0xFFB87733), size: 60),
                      const SizedBox(height: 16),
                      const Text(
                        'أهلاً بك في هاند ميد مصر',
                        style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 20, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'سجل بياناتك وموقعك لنتمكن من توصيل القطع التراثية لباب بيتك',
                        style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 12),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _nameController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'الاسم بالكامل',
                          labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                          filled: true,
                          fillColor: const Color(0xFF1E2630),
                          prefixIcon: const Icon(Icons.person_outline, color: Color(0xFFB87733)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'رقم الهاتف المحمول (للتواصل والشحن)',
                          labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                          filled: true,
                          fillColor: const Color(0xFF1E2630),
                          prefixIcon: const Icon(Icons.phone_outlined, color: Color(0xFFB87733)),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: _addressController,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          labelText: 'عنوان التوصيل (المدينة، الشارع، التفاصيل)',
                          labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                          filled: true,
                          fillColor: const Color(0xFF1E2630),
                          prefixIcon: const Icon(Icons.location_on_outlined, color: Color(0xFFB87733)),
                          suffixIcon: IconButton(
                            icon: _fetchingLocation 
                                ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Color(0xFFB87733)))
                                : const Icon(Icons.my_location, color: Color(0xFFB87733)),
                            onPressed: _getDeviceLocation,
                            tooltip: 'تحديد الموقع تلقائياً عبر GPS',
                          ),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
                        ),
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
                          if (_nameController.text.isEmpty || _phoneController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('من فضلك أدخل الاسم ورقم الهاتف على الأقل')),
                            );
                            return;
                          }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const ConsumerHomeScreen()),
                          );
                        },
                        child: const Text('دخول المتجر وبدء التسوق', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// 2. الشاشة الرئيسية للعميل
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

// 3. الواجهة الرئيسية للمتجر
class StorefrontTab extends StatelessWidget {
  const StorefrontTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2630),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFA97835).withOpacity(0.3)),
          ),
          child: const Row(
            children: [
              CircleAvatar(
                backgroundColor: Color(0xFFB87733),
                child: Icon(Icons.verified_user, color: Colors.white),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('أموالك محمية بضمان هاند ميد مصر 🛡️', style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 12)),
                    Text('لا تُحول الأموال للصانع إلا بعد استلام وتأكيد جودة القطعة', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          style: const TextStyle(color: Colors.white, fontSize: 13),
          decoration: InputDecoration(
            hintText: 'ابحث عن ملابس، كروشيه، حفر ليزر، نحاسيات...',
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
                title: '👗 قسم الملابس التراثية والعبايات',
                subtitle: 'تصاميم أصلية ومطرزة يدوياً بأيدي مهرة',
                badgeText: 'أبرز المنتجات',
                color: const Color(0xFFB87733),
              ),
              _buildAdBanner(
                title: '🧶 الكروشيه والزخارف اليدوية',
                subtitle: 'أعمال فنية فريدة تناسب منزلك وهداياك',
                badgeText: 'جديد المنصة',
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
              _CategoryItem(icon: Icons.checkroom_outlined, title: 'الملابس والعبايات'),
              _CategoryItem(icon: Icons.strikethrough_s_outlined, title: 'كروشيه وزخارف'),
              _CategoryItem(icon: Icons.cut_outlined, title: 'حفر ليزر'),
              _CategoryItem(icon: Icons.print_outlined, title: 'طباعة وتجهيز'),
              _CategoryItem(icon: Icons.coffee_outlined, title: 'نحاسيات'),
              _CategoryItem(icon: Icons.chair_outlined, title: 'أخشاب وأرابيسك'),
              _CategoryItem(icon: Icons.rice_bowl_outlined, title: 'تحف وفخار'),
              _CategoryItem(icon: Icons.grid_on_outlined, title: 'سجاد يدوي'),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'أحدث القطع المعروضة مع شهادة الضمان',
          style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 0.68,
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('عباية مطرزة يدوياً شغل سيوي', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 11, fontWeight: FontWeight.bold), maxLines: 1),
                const SizedBox(height: 2),
                const Text('مدة التجهيز: 3 أيام | المتاح: قطعتان', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 9)),
                const SizedBox(height: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB87733).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('🛡️ ضمان هاند ميد مصر: سنة كاملة', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 8, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 6),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('1,450 ج.م', style: TextStyle(color: Color(0xFFB87733), fontWeight: FontWeight.bold, fontSize: 11)),
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
        const Text('أدخل مواصفات المقاسات أو التصميم المطلوب. تنبيه: ممنوع تماماً التواصل المباشر مع التجار؛ كافة الطلبات والمفاوضات تتم حصرياً عبر إدارة هاند ميد مصر لضمان حقوقك وحفظ أموالك.', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11, height: 1.4)),
        const SizedBox(height: 20),
        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'تفاصيل الطلب الخاص (المقاسات / نوع القماش أو الخشب / الملاحظات)',
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
            backgroundColor: const Color(0xFFB87733),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم إرسال الطلب للإدارة، وسيتم مراجعته وتسعيره وإبلاغك بالرد!')),
            );
          },
          icon: const Icon(Icons.send_outlined),
          label: const Text('إرسال الطلب للإدارة فقط', style: TextStyle(fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}

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
                  Text('الأموال محفوظة لدى المنصة 🔒', style: TextStyle(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              const Text('عباية مطرزة يدوياً شغل سيوي + شهادة الضمان', style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 12)),
              const Text('الإجمالي: 1,450 ج.م', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11)),
              const SizedBox(height: 12),
              const LinearProgressIndicator(value: 0.75, color: Color(0xFFB87733), backgroundColor: Color(0xFF12181F)),
              const SizedBox(height: 6),
              const Text('الحالة: جاري التوصيل لعناوينك المسجلة، ولن تُحول الأموال للورشة إلا بعد تأكيد استلامك.', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF12181F),
                  foregroundColor: const Color(0xFFB87733),
                  side: const BorderSide(color: Color(0xFFB87733)),
                  minimumSize: const Size(double.infinity, 36),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderReviewScreen()),
                  );
                },
                icon: const Icon(Icons.camera_alt_outlined, size: 16),
                label: const Text('تقييم القطعة ورفع الصور بعد الاستلام'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

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
          title: const Text('الدعم الفني والدردشة المباشرة', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13)),
          subtitle: const Text('تحدث مباشرة مع فريق إدارة هاند ميد مصر', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SupportChatScreen()),
            );
          },
        ),
        const Divider(color: Color(0xFF1E2630)),
        ListTile(
          leading: const Icon(Icons.privacy_tip_outlined, color: Color(0xFFB87733)),
          title: const Text('سياسة الخصوصية وحماية الأموال', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13)),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PrivacyPolicyScreen()),
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.description_outlined, color: Color(0xFFB87733)),
          title: const Text('الشروط والأحكام وشهادة الضمان', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13)),
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

class SupportChatScreen extends StatefulWidget {
  const SupportChatScreen({super.key});

  @override
  State<SupportChatScreen> createState() => _SupportChatScreenState();
}

class _SupportChatScreenState extends State<SupportChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, String>> _messages = [
    {
      'sender': 'agent',
      'text': 'أهلاً بك في خدمة عملاء "هاند ميد مصر" 🖐️.\nنحن هنا لمساعدتك بكافة استفساراتك ومتابعة طلباتك. تفضل بكتابة مشكلتك أو استفسارك وسيقوم أحد ممثلي الإدارة بالرد عليك فوراً.'
    }
  ];

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;
    setState(() {
      _messages.add({
        'sender': 'user',
        'text': _messageController.text.trim(),
      });
      _messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text('خدمة العملاء المباشرة (الإدارة)', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15)),
        backgroundColor: const Color(0xFF12181F),
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFF1E2630),
            child: const Row(
              children: [
                Icon(Icons.circle, color: Colors.green, size: 10),
                SizedBox(width: 8),
                Text('فريق الإدارة متواجد الآن للرد على استفساراتك', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                final isUser = msg['sender'] == 'user';
                return Align(
                  alignment: isUser ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isUser ? const Color(0xFFB87733) : const Color(0xFF1E2630),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: const Color(0xFFA97835).withOpacity(0.3)),
                    ),
                    constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
                    child: Text(
                      msg['text']!,
                      style: TextStyle(color: isUser ? Colors.white : const Color(0xFFFEC7C2), fontSize: 12, height: 1.4),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: const Color(0xFF1E2630),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: const TextStyle(color: Colors.white, fontSize: 13),
                    decoration: const InputDecoration(
                      hintText: 'اكتب مشكلتك أو استفسارك هنا...',
                      hintStyle: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send, color: Color(0xFFB87733)),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  String _selectedPaymentMethod = 'mobile_wallet';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text('سلة المشتريات والمدفوعات الآمنة', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15)),
        backgroundColor: const Color(0xFF12181F),
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20.0),
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF1E2630),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              '🔒 تنبيه أمني: أموالك محفوظة في حساب الضمان التابع للمنصة ولا تُصرف للتاجر إلا بعد استلامك للطلب ومراجعته.',
              style: TextStyle(color: Colors.amber, fontSize: 11, height: 1.4),
            ),
          ),
          const SizedBox(height: 20),
          const Text('اختر طريقة الدفع (محافظ إلكترونية فقط):', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          RadioListTile<String>(
            value: 'mobile_wallet',
            groupValue: _selectedPaymentMethod,
            activeColor: const Color(0xFFB87733),
            title: const Text('المحافظ الإلكترونية (فودافون / أورنج / اتصالات / WE)', style: TextStyle(color: Colors.white, fontSize: 12)),
            subtitle: const Text('تحويل آمن لحساب المنصة (نظام الضمان)', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
            onChanged: (val) {
              setState(() {
                _selectedPaymentMethod = val!;
              });
            },
          ),
          RadioListTile<String>(
            value: 'instapay',
            groupValue: _selectedPaymentMethod,
            title: Row(
              children: [
                const Text('إنستا باي (InstaPay)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
                  child: const Text('قريباً', style: TextStyle(color: Colors.amber, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            subtitle: const Text('ستتفاعل تلقائياً فور تفعيلها من لوحة تحكم الأدمن', style: TextStyle(color: Colors.grey, fontSize: 10)),
            onChanged: null,
          ),
          RadioListTile<String>(
            value: 'card',
            groupValue: _selectedPaymentMethod,
            title: Row(
              children: [
                const Text('البطاقات البنكية (فيزا / ماستر كارد)', style: TextStyle(color: Colors.grey, fontSize: 12)),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(color: Colors.grey.shade800, borderRadius: BorderRadius.circular(4)),
                  child: const Text('قريباً', style: TextStyle(color: Colors.amber, fontSize: 9, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            subtitle: const Text('البوابة الإلكترونية المباشرة قيد التفعيل', style: TextStyle(color: Colors.grey, fontSize: 10)),
            onChanged: null,
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
                const SnackBar(content: Text('تم تأكيد الطلب! يرجى تحويل المبلغ لرقم محفظة المنصة لتأمين الطلب.')),
              );
            },
            child: const Text('تأكيد الطلب والدفع عبر المحفظة', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

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
          const Text('بمجرد رفع الصورة وتأكيد الاستلام، سيتم تحويل المستحقات المالية للتاجر بشكل آمن.', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11)),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E2630),
              foregroundColor: const Color(0xFFB87733),
              side: const BorderSide(color: Color(0xFFB87733)),
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم رفع الصورة واعتماد الاستلام بنجاح!')),
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
        title: const Text('سياسة الخصوصية وحماية الأموال', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15)),
        backgroundColor: const Color(0xFF12181F),
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          'تلتزم منصة "هاند ميد مصر" بحماية بيانات المستخدمين طبقاً لمعايير متجر جوجل. بند حماية الأموال: كافة المدفوعات والتحويلات المالية محفوظة حصرياً في حساب الضمان الخاص بالمنصة، ولا يتم صرفها للتاجر أو الصانع إلا بعد استلام العميل للطلب وتأكيد جودته ومطابقته لشهادة الضمان.\n\nالبيانات التي تُجمع (الاسم، الهاتف، العنوان) تُستخدم فقط لغرض الشحن وتنفيذ الطلبات ولا تُشارك مع أي جهة خارجية.',
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
        title: const Text('الشروط والأحكام وشهادة الضمان', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15)),
        backgroundColor: const Color(0xFF12181F),
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Text(
          '1. شهادة الضمان: إرفاق مدة الضمان وتفاصيل الصنعة تحت كل منتج هو التزام إلزامي على التاجر وضامن لجودة التراث المصري.\n2. حظر التواصل الخارجي: منع التواصل المباشر بين العميل والصانع؛ وإدارة المنصة هي الوسيط الوحيد في الطلبات الخاصة والنزاعات.\n3. المنتجات اليدوية فريدة بطبيعتها وتخضع لفحص الجودة الشامل قبل التسليم.',
          style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 13, height: 1.6),
        ),
      ),
    );
  }
}
