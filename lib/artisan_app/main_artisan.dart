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
      title: 'Handmade Egypt - Artisan',
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
      home: const ArtisanHomeScreen(),
    );
  }
}

class ArtisanHomeScreen extends StatefulWidget {
  const ArtisanHomeScreen({super.key});

  @override
  State<ArtisanHomeScreen> createState() => _ArtisanHomeScreenState();
}

class _ArtisanHomeScreenState extends State<ArtisanHomeScreen> {
  int _currentIndex = 0;
  
  // حالة موافقة الإدارة (تكون false افتراضياً للحسابات الجديدة)
  final bool _isApprovedByAdmin = true; 

  final List<Widget> _screens = [
    const ArtisanDashboardTab(),
    const ArtisanProductsTab(),
    const ArtisanPackagesTab(),
    const ArtisanWalletTab(),
    const ArtisanProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text(
          'هاند ميد مصر - بوابة الحرفي والتاجر',
          style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: const Color(0xFF12181F),
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Color(0xFFB87733)),
      ),
      body: _isApprovedByAdmin
          ? _screens[_currentIndex]
          : const AccountPendingApprovalScreen(),
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
            icon: Icon(Icons.dashboard_outlined),
            label: 'الورشة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory_2_outlined),
            label: 'منتجاتي',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_membership_outlined),
            label: 'الباقات والطلبات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'المحفظة',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'حسابي والتحقق',
          ),
        ],
      ),
    );
  }
}

// شاشة تنبيه الحساب قيد المراجعة والتحقق من الهوية
class AccountPendingApprovalScreen extends StatelessWidget {
  const AccountPendingApprovalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E2630),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFB87733), width: 2),
              ),
              child: const Icon(Icons.hourglass_top_rounded, color: Color(0xFFB87733), size: 50),
            ),
            const SizedBox(height: 24),
            const Text(
              'طلب انضمام الورشة قيد التحقق والاعتماد ⏳',
              style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            const Text(
              'تم استلام صورة البطاقة/الباسبور والسيلفي السري بنجاح. جاري مطابقة البيانات من قِبل إدارة "هاند ميد مصر". سيتم تفعيل حسابك فور إتمام مراجعة الأمان.',
              style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 12, height: 1.5),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

// 1. تبويب لوحة تحكم الورشة والطلبات الناتجة
class ArtisanDashboardTab extends StatelessWidget {
  const ArtisanDashboardTab({super.key});

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
                'مرحباً بك يا معلم إبراهيم ⚒️',
                style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 6),
              Text(
                'ورشة النحاسيات والتطعيم - خان الخليلي (هوية موثقة وضمان مفعل)',
                style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _StatCard(
                title: 'المبيعات هذا الشهر',
                value: '12,450 ج.م',
                icon: Icons.monetization_on_outlined,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _StatCard(
                title: 'طلبات قيد التنفيذ',
                value: '4 طلبات',
                icon: Icons.pending_actions_outlined,
              ),
            ),
          
