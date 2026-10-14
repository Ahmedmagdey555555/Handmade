import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const HandmadeEgyptAdminApp());
}

class HandmadeEgyptAdminApp extends StatelessWidget {
  const HandmadeEgyptAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Handmade Egypt - Admin',
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
      home: const AdminHomeScreen(),
    );
  }
}

class AdminHomeScreen extends StatefulWidget {
  const AdminHomeScreen({super.key});

  @override
  State<AdminHomeScreen> createState() => _AdminHomeScreenState();
}

class _AdminHomeScreenState extends State<AdminHomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const AdminDashboardTab(),
    const AdminApprovalsAndUsersTab(),
    const AdminAdsManagementTab(), // تبويب إدارة وتفعيل الإعلانات المدفوعة
    const AdminShippingAndBarcodesTab(),
    const AdminFinancialsAndEscrowTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF12181F),
      appBar: AppBar(
        title: const Text(
          'هاند ميد مصر - لوحة التحكم الشاملة',
          style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 16),
        ),
        backgroundColor: const Color(0xFF12181F),
        elevation: 0,
        centerTitle: true,
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
            icon: Icon(Icons.dashboard_outlined),
            label: 'الرئيسية',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people_outline),
            label: 'المستخدمين',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.campaign_outlined),
            label: 'الإعلانات',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_outlined),
            label: 'الشحن والباركود',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_outlined),
            label: 'الماليات',
          ),
        ],
      ),
    );
  }
}

class AdminDashboardTab extends StatelessWidget {
  const AdminDashboardTab({super.key});

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
            border: Border.all(color: const Color(0xFFB87733).withOpacity(0.5)),
          ),
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('مرحباً أحمد مجدي - الإدارة العليا 🛡️', style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 16)),
              SizedBox(height: 4),
              Text('المنظومة الربط المباشر مع شركات الشحن وتطبيقات العميل والتاجر والإعلانات', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11)),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _AdminStatCard(title: 'إجمالي الشحنات', value: '342 شحنة', icon: Icons.inventory_2, color: const Color(0xFFB87733))),
            const SizedBox(width: 10),
            Expanded(child: _AdminStatCard(title: 'إعلانات نشطة', value: '8 إعلانات', icon: Icons.campaign, color: Colors.amber)),
          ],
        ),
      ],
    );
  }
}

class _AdminStatCard extends StatelessWidget {
  const _AdminStatCard({required this.title, required this.value, required this.icon, required this.color});
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2630),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: color, size: 22),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
          const SizedBox(height: 2),
          Text(value, style: const TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 13)),
        ],
      ),
    );
  }
}

class AdminApprovalsAndUsersTab extends StatelessWidget {
  const AdminApprovalsAndUsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('إدارة المستخدمين والحسابات', style: TextStyle(color: Colors.white)),
    );
  }
}

// تبويب مخصص لإدارة البنرات الإعلانية والطلب المدفوع من التجار
class AdminAdsManagementTab extends StatelessWidget {
  const AdminAdsManagementTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text('طلبات الإعلانات المدفوعة والبنرات', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold)),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB87733), foregroundColor: Colors.white),
              onPressed: () {
                _showAddBannerDialog(context);
              },
              icon: const Icon(Icons.add, size: 16),
              label: const Text('إعلان جديد', style: TextStyle(fontSize: 11)),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2630),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.amber.withOpacity(0.4)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('طلب إعلان مميز: ورشة المعلم إبراهيم', style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 12)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)),
                    child: const Text('قيد المراجعة', style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text('العنوان: خصم 20% على طقم النحاس التراثي', style: TextStyle(color: Colors.white, fontSize: 11)),
              const Text('المدة المطلوبة: 7 أيام | القيمة المفترضة: 350 ج.م (مدفوعة من المحفظة)', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800, foregroundColor: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم تفعيل ونشر الإعلان بنجاح في واجهة المتجر الرئيسية!')),
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline, size: 16),
                      label: const Text('موافقة ونشر بالمتجر', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade900, foregroundColor: Colors.white),
                    onPressed: () {},
                    child: const Text('رفض الطلب', style: TextStyle(fontSize: 11)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  static void _showAddBannerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: const Color(0xFF1E2630),
        title: const Text('إضافة إعلان خاص بالمنصة', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 15, fontWeight: FontWeight.bold)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'عنوان الإعلان الرئيسية',
                labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                filled: true,
                fillColor: const Color(0xFF12181F),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: Border.none),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'الوصف الفرعي للإعلان',
                labelStyle: const TextStyle(color: Color(0xFF9E9E9E)),
                filled: true,
                fillColor: const Color(0xFF12181F),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: Border.none),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB87733), foregroundColor: Colors.white),
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('تم نشر الإعلان الخاص بالمنصة بنجاح!')),
              );
            },
            child: const Text('نشر الإعلان'),
          ),
        ],
      ),
    );
  }
}

class AdminShippingAndBarcodesTab extends StatelessWidget {
  const AdminShippingAndBarcodesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('الشحن والباركود', style: TextStyle(color: Colors.white)));
  }
}

class AdminFinancialsAndEscrowTab extends StatelessWidget {
  const AdminFinancialsAndEscrowTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('الماليات والضمان', style: TextStyle(color: Colors.white)));
  }
}
// جزء من شاشة تفاصيل الطلب والأرباح للتاجر لتوضيح الخصومات وكارت الضمان
class ArtisanOrderDetailsCard extends StatelessWidget {
  const ArtisanOrderDetailsCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E2630),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFA97835).withOpacity(0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('تفاصيل الأرباح والخصومات للأوردر #ORD-9901', style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(height: 8),
          const Text('• إجمالي سعر القطعة: 1,250 ج.م', style: TextStyle(color: Colors.white, fontSize: 11)),
          const Text('• خصم عمولة المنصة (10%): -125 ج.م', style: TextStyle(color: Colors.redAccent, fontSize: 11)),
          const Text('• تكلفة الشحن (تحمل الورشة لوجود ملاحظة/عيب): -75 ج.م', style: TextStyle(color: Colors.redAccent, fontSize: 11)),
          const Divider(color: Color(0xFF12181F)),
          const Text('صافي المبلغ المضاف لمحفظتك: 1,050 ج.م', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 14),
          
          // تنبيه إلزامي لإرفاق كارت الضمان والرسالة الترحيبية للبراند
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF12181F),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: const Color(0xFFB87733)),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.card_giftcard, color: Color(0xFFB87733), size: 18),
                    SizedBox(width: 6),
                    Text('تنبيه هام جداً قبل التغليف وإرسال الطرد:', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 11, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 6),
                Text(
                  '1. يجب إرفاق كارت الضمان الخاص بالقطعة داخل الطرد.\n'
                  '2. يجب وضع كارت الرسالة الترحيبية الرسمية:\n'
                  '   "أهلاً بك في عالم التراث.. شكراً لاختيارك منتجات هاند ميد مصر اليدوية الأصلية 🏺✨".',
                  style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10, height: 1.5),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
