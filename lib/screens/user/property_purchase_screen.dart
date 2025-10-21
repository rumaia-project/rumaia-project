// [file name]: property_purchase_screen.dart
import 'package:flutter/material.dart';

class PropertyPurchaseScreen extends StatefulWidget {
  final Map<String, dynamic> property;

  const PropertyPurchaseScreen({super.key, required this.property});

  @override
  _PropertyPurchaseScreenState createState() => _PropertyPurchaseScreenState();
}

class _PropertyPurchaseScreenState extends State<PropertyPurchaseScreen> {
  int _selectedPaymentMethod = 0; // 0: IDRT, 1: USDT, 2: BNB
  bool _isProcessing = false;

  // Data harga properti berdasarkan nama
  double get _propertyPrice {
    final name = widget.property["name"].toLowerCase();
    if (name.contains("cluster bukit asri")) {
      return 400000000.0; // 400 juta
    } else if (name.contains("cluster harmoni")) {
      return 600000000.0; // 600 juta
    } else if (name.contains("cluster alam hijau")) {
      return 750000000.0; // 750 juta
    } else if (name.contains("modern minimalis")) {
      return 2500000000.0; // 2.5 miliar
    } else if (name.contains("cluster exclusive")) {
      return 1800000000.0; // 1.8 miliar
    } else if (name.contains("villa modern")) {
      return 3200000000.0; // 3.2 miliar
    } else {
      return 950000000.0; // 950 juta untuk apartemen
    }
  }

  // Format harga ke Rupiah
  String get _formattedPrice {
    if (_propertyPrice >= 1000000000) {
      return 'Rp ${(_propertyPrice / 1000000000).toStringAsFixed(1)} M';
    } else {
      return 'Rp ${(_propertyPrice / 1000000).toStringAsFixed(0)} JT';
    }
  }

  String _formatNumber(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)}K';
    } else if (number < 1) {
      return number.toStringAsFixed(4); // untuk pecahan kecil seperti BNB
    } else {
      return number.toStringAsFixed(2);
    }
  }

  // GANTI bagian payment methods menjadi:
  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'IDRT Token',
      'symbol': 'IDRT',
      'icon': 'IDRT',
      'exchangeRate': 1.0, // 1 IDRT = 1 IDR
      'balance': 5000000000.0, // 5M IDRT (CUKUP untuk 400M IDRT)
    },
    {
      'name': 'USDT',
      'symbol': 'USDT',
      'icon': 'USDT',
      'exchangeRate': 15700.0, // 1 USDT = 15,700 IDR (realistik)
      'balance': 50000.0, // 50K USDT (CUKUP untuk 25.5K USDT)
    },
    {
      'name': 'BNB',
      'symbol': 'BNB',
      'icon': 'BNB',
      'exchangeRate': 8500000.0, // 1 BNB = 8.5M IDR (realistik)
      'balance': 30.0, // HANYA 30 BNB (TIDAK CUKUP untuk 47 BNB)
    },
  ];

  void _processPayment() async {
    setState(() {
      _isProcessing = true;
    });

    // Simulasi proses pembayaran blockchain
    await Future.delayed(Duration(seconds: 3));

    setState(() {
      _isProcessing = false;
    });

    _showSuccessDialog();
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Container(
            padding: EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 64),
                SizedBox(height: 16),
                Text(
                  'Pembelian Berhasil!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Transaksi pembelian properti telah berhasil dilakukan di blockchain.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),

                // Card Properti yang Berhasil Dibeli
                _buildPropertySuccessCard(),
                SizedBox(height: 20),

                // Detail Transaksi
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildTransactionDetail(
                        'ID Transaksi',
                        '#TX${DateTime.now().millisecondsSinceEpoch.toString().substring(8)}',
                      ),
                      _buildTransactionDetail(
                        'Token Used',
                        _paymentMethods[_selectedPaymentMethod]['symbol'],
                      ),
                      _buildTransactionDetail(
                        'Amount Paid',
                        '${_formatNumber(_requiredAmount)} ${_paymentMethods[_selectedPaymentMethod]['symbol']}',
                      ),
                      _buildTransactionDetail(
                        'Property Value',
                        _formattedPrice,
                      ),
                      _buildTransactionDetail('Blockchain', 'BNB Smart Chain'),
                      _buildTransactionDetail('Status', 'Confirmed'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // Kembali ke detail properti
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    'Selesai',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildPropertySuccessCard() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.1),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(widget.property['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Properti Anda',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  widget.property['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.grey[800],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 2),
                Text(
                  widget.property['location'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                ),
                SizedBox(height: 2),
                Text(
                  widget.property['specs'] ?? '4 KT • 3 KM • 120 m²',
                  style: TextStyle(color: Colors.grey[600], fontSize: 11),
                ),
              ],
            ),
          ),
          Icon(Icons.verified, color: Colors.green, size: 20),
        ],
      ),
    );
  }

  Widget _buildTransactionDetail(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
          Text(
            value,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
          ),
        ],
      ),
    );
  }

  double get _requiredAmount {
    return _propertyPrice /
        (_paymentMethods[_selectedPaymentMethod]['exchangeRate'] as double);
  }

  bool get _hasSufficientBalance {
    return (_paymentMethods[_selectedPaymentMethod]['balance'] as double) >=
        _requiredAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Pembelian Properti',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[700]),
      ),
      body: _isProcessing
          ? _buildProcessingScreen()
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Property Summary
                  _buildPropertySummary(),
                  SizedBox(height: 24),

                  // Payment Method Selection
                  _buildPaymentMethodSection(),
                  SizedBox(height: 24),

                  // Payment Details
                  _buildPaymentDetails(),
                  SizedBox(height: 32),

                  // Terms and Conditions
                  _buildTermsAndConditions(),
                  SizedBox(height: 24),

                  // Buy Button
                  _buildBuyButton(),
                ],
              ),
            ),
    );
  }

  Widget _buildProcessingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF1565C0)),
          ),
          SizedBox(height: 20),
          Text(
            'Memproses Pembayaran...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Transaksi sedang diproses di blockchain\nMohon tunggu sebentar',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
          SizedBox(height: 20),
          Container(
            padding: EdgeInsets.all(16),
            margin: EdgeInsets.symmetric(horizontal: 32),
            decoration: BoxDecoration(
              color: Color(0xFF1565C0).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Color(0xFF1565C0), size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Transaksi blockchain membutuhkan waktu beberapa detik untuk dikonfirmasi',
                    style: TextStyle(color: Color(0xFF1565C0), fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPropertySummary() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(widget.property['image']),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.property['name'],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    color: Colors.grey[800],
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                Text(
                  widget.property['location'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  widget.property['specs'] ?? '4 KT • 3 KM • 120 m²',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                SizedBox(height: 8),
                Text(
                  _formattedPrice,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Metode Pembayaran Blockchain',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 16),
        ..._paymentMethods.asMap().entries.map((entry) {
          int index = entry.key;
          var method = entry.value;
          bool isSelected = _selectedPaymentMethod == index;
          double requiredAmount = _requiredAmount;
          double methodBalance = method['balance'] as double;
          bool hasSufficientBalance = methodBalance >= requiredAmount;

          return Container(
            margin: EdgeInsets.only(bottom: 12),
            child: Material(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                onTap: () {
                  setState(() {
                    _selectedPaymentMethod = index;
                  });
                },
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Color(0xFF1565C0).withOpacity(0.1)
                        : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Color(0xFF1565C0) : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? Color(0xFF1565C0)
                              : Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            method['icon'] as String,
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.grey[700],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              method['name'] as String,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Saldo: ${_formatNumber(methodBalance)} ${method['symbol']}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Dibutuhkan: ${_formatNumber(requiredAmount)} ${method['symbol']}',
                              style: TextStyle(
                                color: hasSufficientBalance
                                    ? Colors.green
                                    : Colors.red,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Radio(
                        value: index,
                        groupValue: _selectedPaymentMethod,
                        onChanged: (value) {
                          setState(() {
                            _selectedPaymentMethod = value!;
                          });
                        },
                        activeColor: Color(0xFF1565C0),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ],
    );
  }

  Widget _buildPaymentDetails() {
    var selectedMethod = _paymentMethods[_selectedPaymentMethod];
    double requiredAmount = _requiredAmount;
    double methodBalance = selectedMethod['balance'] as double;
    double exchangeRate = selectedMethod['exchangeRate'] as double;

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Detail Pembayaran',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 12),
          _buildPaymentDetailRow('Harga Properti', _formattedPrice),
          _buildPaymentDetailRow(
            'Mata Uang',
            selectedMethod['symbol'] as String,
          ),
          _buildPaymentDetailRow(
            'Jumlah yang Dibayar',
            '${_formatNumber(requiredAmount)} ${selectedMethod['symbol']}',
          ),
          _buildPaymentDetailRow(
            'Kurs',
            '1 ${selectedMethod['symbol']} = Rp ${_formatNumber(exchangeRate)}',
          ),
          Divider(height: 24),
          _buildPaymentDetailRow(
            'Saldo Tersedia',
            '${_formatNumber(methodBalance)} ${selectedMethod['symbol']}',
            valueColor: _hasSufficientBalance ? Colors.green : Colors.red,
          ),
          _buildPaymentDetailRow(
            'Status',
            _hasSufficientBalance ? 'Cukup' : 'Tidak Cukup',
            valueColor: _hasSufficientBalance ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetailRow(
    String label,
    String value, {
    Color? valueColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          Text(
            value,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: valueColor ?? Colors.grey[800],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Syarat dan Ketentuan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          '• Dengan melanjutkan, Anda menyetujui bahwa transaksi ini bersifat final dan tidak dapat dibatalkan\n'
          '• Transaksi blockchain bersifat irreversible setelah dikonfirmasi\n'
          '• Properti akan ditransfer ke wallet Anda setelah 3 konfirmasi blockchain\n'
          '• Biaya gas network akan ditambahkan otomatis\n'
          '• Sertifikat kepemilikan akan dikirim dalam 7 hari kerja',
          style: TextStyle(color: Colors.grey[600], fontSize: 12, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildBuyButton() {
    return Column(
      children: [
        if (!_hasSufficientBalance)
          Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.red[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.red[200]!),
            ),
            child: Row(
              children: [
                Icon(Icons.warning_amber, color: Colors.red, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Saldo ${_paymentMethods[_selectedPaymentMethod]['symbol']} tidak mencukupi',
                    style: TextStyle(color: Colors.red[700], fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ElevatedButton(
          onPressed: _hasSufficientBalance ? _processPayment : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _hasSufficientBalance
                ? Color(0xFF1565C0)
                : Colors.grey[400],
            padding: EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 2,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_checkout, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Beli Sekarang dengan Blockchain',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
