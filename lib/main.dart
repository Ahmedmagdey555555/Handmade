import 'package:flutter/material.dart';

// استيراد التطبيقات الثلاثة من مجلداتها
import 'consumer_app/main_consumer.dart' as consumer;
import 'artisan_app/main_artisan.dart' as artisan;
import 'admin_app/main_admin.dart' as admin;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const GatewayApp());
}

class GatewayApp extends StatelessWidget {
  const GatewayApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'هاند ميد مصر - بوابة المنصات',
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
      home: const PlatformSelectorScreen(),
    );
  }
}

class PlatformSelectorScreen extends StatelessWidget {
  const PlatformSelectorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.handyman_rounded, color: Color(0xFFB87733), size: 70),
              const SizedBox(height: 16),
              const Text(
                'منصة هاند ميد مصر 🇪🇬',
                style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              const Text(
                'اختر البوابة التي ترغب في دخولها للبدء:',
                style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 13),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),

              // 1. زرار تطبيق العميل (المتجر)
              _buildPortalButton(
                context,
                title: 'بوابة العميل (المتجر التسوقي)',
                subtitle: 'تصفح القطع التراثية والطلب والدفع الآمن',
                icon: Icons.shopping_bag_outlined,
                color: const Color(0xFFB87733),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const consumer.LoginScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),

              // 2. زرار تطبيق التاجر (الورش)
              _buildPortalButton(
                context,
                title: 'بوابة التاجر والورش 🛠️',
                subtitle: 'تسجيل الورشة، رفع المنتجات، ومتابعة الأرباح',
                icon: Icons.storefront_outlined,
                color: const Color(0xFFA97835),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const artisan.ArtisanRegisterScreen()),
                  );
                },
              ),
              const SizedBox(height: 16),

              // 3. زرار لوحة تحكم الأدمن
              _buildPortalButton(
                context,
                title: 'لوحة تحكم الإدارة (Admin) 🛡️',
                subtitle: 'توثيق الورش، مراجعة الجودة، وإدارة الضمان',
                icon: Icons.admin_panel_settings_outlined,
                color: Colors.
