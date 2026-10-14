import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HandmadeEgyptApp());
}

class HandmadeEgyptApp extends StatelessWidget {
  const HandmadeEgyptApp({super.key});

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
      home: const MainDashboardScreen(),
    );
  }
}

class MainDashboardScreen extends StatefulWidget {
  const MainDashboardScreen({super.key});

  @override
  State<MainDashboardScreen> createState() => _MainDashboardScreenState();
}

class _MainDashboardScreenState extends State<MainDashboardScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      const StoreTab(),
      const ArtisanTab(),
      const AdminTab(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text('هاند ميد مصر - المنصة الموحدة', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 16)),
        backgroundColor: const Color(0xFF12181F),
        centerTitle: true,
      ),
      body: screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        backgroundColor: const Color(0xFF1E2630),
        selectedItemColor: const Color(0xFFB87733),
        unselectedItemColor: const Color(0xFF9E9E9E),
        type: BottomNavigationBarType.fixed,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.storefront), label: 'العميل'),
          BottomNavigationBarItem(icon: Icon(Icons.handyman), label: 'التاجر والورش'),
          BottomNavigationBarItem(icon: Icon(Icons.admin_panel_settings), label: 'الإدارة'),
        ],
      ),
    );
  }
}

// 1. واجهة العميل (المتجر)
class StoreTab extends StatelessWidget {
  const StoreTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('أهلاً بك في متجر هاند ميد مصر 🏛️', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(color: const Color(0xFF1E2630), borderRadius: BorderRadius.circular(10)),
          child: const Text('🔒 أموالك محمية بنظام الضمان الكامل للمنصة حتى استلام القطعة ومراجعتها.', style: TextStyle(color: Colors.amber, fontSize: 12)),
        ),
        const SizedBox(height: 20),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, childAspectRatio: 0.75, crossAxisSpacing: 12, mainAxisSpacing: 12,
          ),
          itemCount: 2,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(color: const Color(0xFF1E2630), borderRadius: BorderRadius.circular(10)),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.image, color: Color(0xFFB87733), size: 40),
                  SizedBox(height: 8),
                  Text('عباية تراثية مطرزة', style: TextStyle(color: Colors.white, fontSize: 12)),
                  Text('1,450 ج.م', style: TextStyle(color: Color(0xFFB87733), fontWeight: FontWeight.bold)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

// 2. واجهة التاجر والورش
class ArtisanTab extends StatefulWidget {
  const ArtisanTab({super.key});

  @override
  State<ArtisanTab> createState() => _ArtisanTabState();
}

class _ArtisanTabState extends State<ArtisanTab> {
  bool _verified = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('بوابة الورش والتجار 🛠️', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        TextField(
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            labelText: 'اسم الورشة أو الصانع',
            filled: true,
            fillColor: const Color(0xFF1E2630),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10), borderSide: BorderSide.none),
          ),
        ),
        const SizedBox(height: 16),
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: _verified ? Colors.green : const Color(0xFFB87733)),
          onPressed: () {
            setState(() => _verified = true);
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم التحقق ورفع بيانات التوثيق بنجاح!')));
          },
          icon: Icon(_verified ? Icons.check : Icons.camera_front),
          label: Text(_verified ? 'تم توثيق الورشة' : 'رفع سيلفي التحقق والبطاقة'),
        ),
      ],
    );
  }
}

// 3. واجهة الإدارة
class AdminTab extends StatelessWidget {
  const AdminTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        const Text('لوحة تحكم الأدمن 🛡️', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 18, fontWeight: FontWeight.bold)),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: const Color(0xFF1E2630), borderRadius: BorderRadius.circular(10)),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('حساب الضمان الإجمالي (Escrow)', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 12)),
              SizedBox(height: 6),
              Text('48,500 ج.م', style: TextStyle(color: Colors.green, fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }
}
