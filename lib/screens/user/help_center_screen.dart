// [file name]: help_center_screen.dart
// [file content begin]
import 'package:flutter/material.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({super.key});

  @override
  _HelpCenterScreenState createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  final List<Map<String, dynamic>> _faqs = [
    {
      'question': 'Bagaimana cara membeli properti dengan blockchain?',
      'answer':
          'Anda dapat membeli properti dengan memilih properti yang diinginkan, lalu pilih "Pesan Properti". '
          'Setelah itu, pilih metode pembayaran blockchain (IDRT, USDT, atau BNB) dan ikuti proses pembayaran. '
          'Transaksi akan diproses di blockchain dan properti akan menjadi milik Anda setelah konfirmasi.',
      'isExpanded': false,
    },
    {
      'question': 'Apa itu IDRT Token?',
      'answer':
          'IDRT Token adalah stablecoin yang dipatok dengan Rupiah Indonesia (1 IDRT = 1 IDR). '
          'Token ini berjalan di blockchain BSC (Binance Smart Chain) dan dapat digunakan untuk '
          'pembelian properti dengan biaya transaksi yang lebih rendah dan proses yang lebih cepat.',
      'isExpanded': false,
    },
    {
      'question': 'Bagaimana cara mengajukan pembangunan rumah?',
      'answer':
          'Anda dapat mengajukan pembangunan rumah dengan mengklik "Ajukan Pembangunan" di beranda. '
          'Isi formulir dengan lokasi yang diinginkan, tipe rumah, budget, dan preferensi tambahan. '
          'Developer akan meninjau pengajuan Anda dan menghubungi jika ada yang tertarik di area yang sama.',
      'isExpanded': false,
    },
    {
      'question': 'Berapa lama proses pembelian properti?',
      'answer':
          'Proses pembelian properti dengan blockchain biasanya memakan waktu 5-15 menit untuk konfirmasi transaksi. '
          'Setelah transaksi dikonfirmasi, sertifikat kepemilikan akan dikirim dalam 7 hari kerja.',
      'isExpanded': false,
    },
    {
      'question': 'Apakah transaksi blockchain aman?',
      'answer':
          'Ya, transaksi blockchain sangat aman karena menggunakan teknologi cryptography yang canggih. '
          'Setiap transaksi tercatat secara permanen dan transparan di blockchain, sehingga tidak dapat dimanipulasi.',
      'isExpanded': false,
    },
  ];

  final List<Map<String, dynamic>> _contactMethods = [
    {
      'icon': Icons.phone,
      'title': 'Telepon',
      'subtitle': 'Hubungi kami 24/7',
      'value': '+62 21 1234 5678',
      'color': Colors.green,
    },
    {
      'icon': Icons.email,
      'title': 'Email',
      'subtitle': 'Kirim pertanyaan detail',
      'value': 'support@rumala.com',
      'color': Colors.blue,
    },
    {
      'icon': Icons.chat,
      'title': 'Live Chat',
      'subtitle': 'Chat langsung dengan agent',
      'value': 'Tersedia 24 jam',
      'color': Colors.orange,
    },
    {
      'icon': Icons.chat_bubble,
      'title': 'WhatsApp',
      'subtitle': 'Chat via WhatsApp',
      'value': '+62 812 3456 7890',
      'color': Colors.green,
    },
  ];

  void _callSupport() {
    // Simulasi panggilan telepon
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.phone, color: Colors.green),
            SizedBox(width: 8),
            Text('Hubungi Support'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Anda akan menghubungi tim support kami:'),
            SizedBox(height: 8),
            Text(
              '+62 21 1234 5678',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Tim support kami tersedia 24 jam untuk membantu Anda.',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              _showCallConfirmation();
            },
            child: Text('Hubungi Sekarang'),
          ),
        ],
      ),
    );
  }

  void _showCallConfirmation() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(Icons.phone, color: Colors.white),
            SizedBox(width: 8),
            Text('Menghubungi tim support...'),
          ],
        ),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _openWhatsApp() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.chat_bubble, color: Colors.green),
            SizedBox(width: 8),
            Text('Chat via WhatsApp'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Buka chat dengan tim support kami:'),
            SizedBox(height: 8),
            Text(
              '+62 812 3456 7890',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.chat_bubble, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Membuka WhatsApp...'),
                    ],
                  ),
                  backgroundColor: Colors.green,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('Buka WhatsApp'),
          ),
        ],
      ),
    );
  }

  void _sendEmail() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.email, color: Colors.blue),
            SizedBox(width: 8),
            Text('Kirim Email'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Kirim email ke tim support kami:'),
            SizedBox(height: 8),
            Text(
              'support@rumala.com',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Kami akan membalas email Anda dalam 1x24 jam.',
              style: TextStyle(color: Colors.grey[600], fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Row(
                    children: [
                      Icon(Icons.email, color: Colors.white),
                      SizedBox(width: 8),
                      Text('Membuka aplikasi email...'),
                    ],
                  ),
                  backgroundColor: Colors.blue,
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: Text('Buka Email'),
          ),
        ],
      ),
    );
  }

  void _startLiveChat() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.chat, color: Colors.orange),
            SizedBox(width: 8),
            Text('Live Chat'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Memulai chat dengan agent kami...'),
            SizedBox(height: 12),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.access_time, color: Colors.orange, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Menghubungkan Anda dengan agent tersedia',
                      style: TextStyle(color: Colors.orange, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context);
              // Simulasi koneksi live chat
              _simulateLiveChatConnection();
            },
            child: Text('Mulai Chat'),
          ),
        ],
      ),
    );
  }

  void _simulateLiveChatConnection() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
              SizedBox(height: 16),
              Text(
                'Menghubungkan ke Agent...',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                'Harap tunggu sebentar',
                style: TextStyle(color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );

    Future.delayed(Duration(seconds: 2), () {
      Navigator.pop(context); // Close loading dialog
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Terhubung dengan Agent!'),
            ],
          ),
          backgroundColor: Colors.green,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Pusat Bantuan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[700]),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Icon(Icons.help_outline, color: Colors.white, size: 40),
                  SizedBox(height: 12),
                  Text(
                    'Butuh Bantuan?',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tim support kami siap membantu Anda 24 jam',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // 24/7 Support Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.red[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.red[100]!),
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.access_time,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bantuan 24 Jam',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red[800],
                          ),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Hubungi tim dukungan kami kapan saja',
                          style: TextStyle(
                            color: Colors.red[700],
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(Icons.arrow_forward_ios, color: Colors.red, size: 16),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Contact Methods
            Text(
              'Hubungi Kami',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),
            GridView.count(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 1.2,
              children: _contactMethods.map((method) {
                return _buildContactMethodCard(method);
              }).toList(),
            ),

            SizedBox(height: 32),

            // FAQ Section
            Text(
              'Pertanyaan Umum',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 12),
            ..._faqs.asMap().entries.map((entry) {
              int index = entry.key;
              var faq = entry.value;
              return _buildFAQItem(faq, index);
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildContactMethodCard(Map<String, dynamic> method) {
    return GestureDetector(
      onTap: () {
        switch (method['title']) {
          case 'Telepon':
            _callSupport();
            break;
          case 'WhatsApp':
            _openWhatsApp();
            break;
          case 'Email':
            _sendEmail();
            break;
          case 'Live Chat':
            _startLiveChat();
            break;
        }
      },
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[300]!),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: method['color'].withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(method['icon'], color: method['color'], size: 24),
            ),
            SizedBox(height: 12),
            Text(
              method['title'],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
            SizedBox(height: 4),
            Text(
              method['subtitle'],
              style: TextStyle(color: Colors.grey[600], fontSize: 11),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFAQItem(Map<String, dynamic> faq, int index) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: ExpansionTile(
        title: Text(
          faq['question'],
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
            fontSize: 14,
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.all(16),
            child: Text(
              faq['answer'],
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: 14,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// [file content end]