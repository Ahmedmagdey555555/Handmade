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
    const AdminAdsManagementTab(),
    const AdminShippingAndBarcodesTab(),
    const AdminFinancialsAndEscrowTab(),
    const AdminSettingsAndUpdatesTab(),
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
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_outlined, color: Color(0xFFB87733)),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('ماسح الباركود جاهز لفحص وتسجيل الشحنات في نقطة التجميع!')),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.system_update_outlined),
            label: 'التحديثات',
          ),
        ],
      ),
    );
  }
}

// 1. تبويب الإحصائيات العامة
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
              Text('المنظومة متصلة بالكامل ومزامنة مع تطبيقات التجار والعملاء وشركات الشحن', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 11)),
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
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(child: _AdminStatCard(title: 'أموال مؤمنة (Escrow)', value: '88,500 ج.م', icon: Icons.security, color: Colors.green)),
            const SizedBox(width: 10),
            Expanded(child: _AdminStatCard(title: 'إجمالي الورش المعتمدة', value: '128 ورشة', icon: Icons.store, color: Colors.blue)),
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

// 2. تبويب إدارة المستخدمين والتفعيل والحذف
class AdminApprovalsAndUsersTab extends StatelessWidget {
  const AdminApprovalsAndUsersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('طلبات توثيق الورش وإدارة الحسابات', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold)),
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
                  Text('ورشة الفتح للنحاسيات', style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 13)),
                  Text('قيد المراجعة', style: TextStyle(color: Colors.amber, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 4),
              const Text('صاحب الورشة: إبراهيم محمد | الرقم القومي: 2980101****', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(color: const Color(0xFF12181F), borderRadius: BorderRadius.circular(8)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.camera_front, color: Color(0xFFB87733), size: 18),
                          SizedBox(height: 4),
                          Text('سيلفي التوثيق (للإدارة فقط)', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 9)),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(color: const Color(0xFF12181F), borderRadius: BorderRadius.circular(8)),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.badge, color: Color(0xFFB87733), size: 18),
                          SizedBox(height: 4),
                          Text('صورة البطاقة / الباسبور', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 9)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800, foregroundColor: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم تفعيل وتوثيق حساب الورشة بنجاح!')),
                        );
                      },
                      icon: const Icon(Icons.check_circle_outline, size: 16),
                      label: const Text('تفعيل الورشة', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade900, foregroundColor: Colors.white),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('تم حذف/حظر الحساب ومنع تكرار الهوية!')),
                      );
                    },
                    icon: const Icon(Icons.delete_outline, size: 16),
                    label: const Text('حظر / حذف', style: TextStyle(fontSize: 11)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 3. تبويب إدارة وتفعيل البنرات والإعلانات المدفوعة
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
                  const Text('إعلان مدفوع: ورشة المعلم إبراهيم', style: TextStyle(color: Color(0xFFFEC7C2), fontWeight: FontWeight.bold, fontSize: 12)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.amber, borderRadius: BorderRadius.circular(4)),
                    child: const Text('طلب جديد', style: TextStyle(color: Colors.black, fontSize: 9, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
              const SizedBox(height: 6),
              const Text('العنوان: خصم 20% على الصواني النحاسية', style: TextStyle(color: Colors.white, fontSize: 11)),
              const Text('المدة: 7 أيام | القيمة: 350 ج.م (مدفوعة من محفظة الورشة)', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800, foregroundColor: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم نشر الإعلان فوراً في الشاشة الرئيسية لتطبيق العملاء!')),
                        );
                      },
                      icon: const Icon(Icons.campaign, size: 16),
                      label: const Text('موافقة ونشر بالمتجر', style: TextStyle(fontSize: 11)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red.shade900, foregroundColor: Colors.white),
                    onPressed: () {},
                    child: const Text('رفض', style: TextStyle(fontSize: 11)),
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
                labelText: 'عنوان الإعلان الرئيسي',
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
                const SnackBar(content: Text('تم نشر بنَر الإعلان بالمتجر بنجاح!')),
              );
            },
            child: const Text('نشر الإعلان'),
          ),
        ],
      ),
    );
  }
}

// 4. تبويب الشحن والباركود والربط مع الشركات وتكلفة المسافات وتجميع الطرود (Consolidation)
class AdminShippingAndBarcodesTab extends StatelessWidget {
  const AdminShippingAndBarcodesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('إدارة الشحن، الباركود، وحساب المسافات', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold)),
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
                  Text('شحنة #ORD-9901', style: TextStyle(color: Color(0xFFB87733), fontWeight: FontWeight.bold, fontSize: 13)),
                  Text('شركة الشحن: Bosta', style: TextStyle(color: Colors.blue, fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 6),
              const Text('العميل: أحمد م. (تم إخفاء الرقم عن التاجر للخصوصية)', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 11)),
              const Text('المسافة: أسوان ⬅️ القاهرة (تكلفة التوصيل الديناميكية: 85 ج.م)', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(color: const Color(0xFF12181F), borderRadius: BorderRadius.circular(6)),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Barcode: HME-883921-EG', style: TextStyle(color: Colors.white, fontSize: 11, fontFamily: 'monospace')),
                    Icon(Icons.qr_code, color: Color(0xFFB87733), size: 20),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              // خيار دمج وتجميع الطرود للعميل في الـ Hub
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF12181F),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.blue.withOpacity(0.4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.merge_type_outlined, color: Colors.blue, size: 18),
                        SizedBox(width: 6),
                        Text('تجميع طرود متعددة للعميل (Consolidation)', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    const Text('العميل طلب عدة قطع من ورش مختلفة وتم وصولها لنقطة التجميع (Hub)', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
                    const SizedBox(height: 8),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade800, foregroundColor: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم دمج الطرود في طرد موحد واستخراج بوليصة شحن واحدة للعميل!')),
                        );
                      },
                      icon: const Icon(Icons.inventory_2_outlined, size: 14),
                      label: const Text('دمج في طرد موحد لتقليل مصاريف الشحن', style: TextStyle(fontSize: 10)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB87733), foregroundColor: Colors.white),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('جاري طباعة بوليصة الشحن والباركود للتغليف!')),
                        );
                      },
                      icon: const Icon(Icons.print_outlined, size: 16),
                      label: const Text('طباعة البوليصة', style: TextStyle(fontSize: 10)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF12181F), foregroundColor: const Color(0xFFFEC7C2), side: const BorderSide(color: Color(0xFFA97835))),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('تم إرسال إشعار للتاجر بتوجيه الشحنة لنقطة التجميع!')),
                        );
                      },
                      icon: const Icon(Icons.hub_outlined, size: 16),
                      label: const Text('توجيه لـ Hub', style: TextStyle(fontSize: 10)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 5. تبويب الماليات وحفظ الأموال والضمان
class AdminFinancialsAndEscrowTab extends StatelessWidget {
  const AdminFinancialsAndEscrowTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('الأموال المحفوظة (Escrow) والضمان للطلبات', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold)),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xFF1E2630),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.green.withOpacity(0.3)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('مبلغ محفوظ: 1,850 ج.م', style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 14)),
              const SizedBox(height: 4),
              const Text('الورشة: ورشة المعلم إبراهيم | رقم المحفظة: 01012345678', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 11)),
              const Text('حالة الضمان: تم التسليم والعميل يراجع القطعة (متبقي 24 ساعة)', style: TextStyle(color: Color(0xFF9E9E9E), fontSize: 10)),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green.shade800, foregroundColor: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم تأكيد تحويل الأرباح لحساب محفظة الحرفي بنجاح!')),
                  );
                },
                icon: const Icon(Icons.verified, size: 16),
                label: const Text('تأكيد وإتمام تحرير الأموال للمحفظة'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// 6. تبويب التحكم في التحديث الإجباري وإصدارات التطبيق
class AdminSettingsAndUpdatesTab extends StatelessWidget {
  const AdminSettingsAndUpdatesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        const Text('إدارة تحديث التطبيقات والنسخ الإجبارية', style: TextStyle(color: Color(0xFFFEC7C2), fontSize: 14, fontWeight: FontWeight.bold)),
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
              const Text('إصدار تطبيق العملاء: v1.0.0', style: TextStyle(color: Colors.white, fontSize: 12)),
              const Text('إصدار تطبيق التجار: v1.0.0', style: TextStyle(color: Colors.white, fontSize: 12)),
              const SizedBox(height: 12),
              TextField(
                style: const TextStyle(color: Colors.white, fontSize: 12),
                decoration: InputDecoration(
                  labelText: 'رقم الإصدار المطلوب للتحديث الإجباري (Force Update)',
                  labelStyle: const TextStyle(color: Color(0xFF9E9E9E), fontSize: 11),
                  filled: true,
                  fillColor: const Color(0xFF12181F),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8), borderSide: Border.none),
                ),
              ),
              const SizedBox(height: 12),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFFB87733), foregroundColor: Colors.white),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('تم نشر التحديث الإجباري بنجاح بكافة التطبيقات!')),
                  );
                },
                icon: const Icon(Icons.system_update_launch_outlined, size: 16),
                label: const Text('إطلاق وتفعيل التحديث الإجباري'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
