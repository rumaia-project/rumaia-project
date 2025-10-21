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
  final double _tokenBalance = 12500000; // Saldo token contoh

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'IDRT Token',
      'symbol': 'IDRT',
      'icon': 'IDRT',
      'exchangeRate': 1.0,
      'balance': 12500000,
    },
    {
      'name': 'USDT',
      'symbol': 'USDT',
      'icon': 'USDT',
      'exchangeRate': 15750.0,
      'balance': 800,
    },
    {
      'name': 'BNB',
      'symbol': 'BNB',
      'icon': 'BNB',
      'exchangeRate': 5250000.0,
      'balance': 2.5,
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
          child: Padding(
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
                  'Transaksi pembelian properti telah berhasil dilakukan di blockchain. Detail transaksi telah dikirim ke email Anda.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      _buildTransactionDetail('ID Transaksi', '#TXB827361948'),
                      _buildTransactionDetail('Token Used', 'IDRT'),
                      _buildTransactionDetail('Amount', '2,500,000,000 IDRT'),
                      _buildTransactionDetail('Blockchain', 'BNB Smart Chain'),
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

  double get _propertyPrice {
    return 2500000000; // 2.5 Miliar
  }

  double get _requiredAmount {
    return _propertyPrice /
        _paymentMethods[_selectedPaymentMethod]['exchangeRate'];
  }

  bool get _hasSufficientBalance {
    return _paymentMethods[_selectedPaymentMethod]['balance'] >=
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
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
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
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.blue[700], size: 20),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Transaksi blockchain membutuhkan waktu beberapa detik untuk dikonfirmasi',
                    style: TextStyle(color: Colors.blue[700], fontSize: 12),
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
                image: AssetImage('assets/images/rumah_modern_min_2l.jpg'),
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
                  widget.property['title'] ?? 'Rumah Modern Minimalis 2 Lantai',
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
                  widget.property['location'] ?? 'Jakarta Selatan, DKI Jakarta',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                SizedBox(height: 4),
                Text(
                  widget.property['specs'] ?? '4 KT • 3 KM • 120 m²',
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
                SizedBox(height: 8),
                Text(
                  'Rp 2.5 M',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[700],
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
          double requiredAmount = _propertyPrice / method['exchangeRate'];

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
                    color: isSelected ? Colors.blue[50] : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected ? Colors.blue[700]! : Colors.grey[300]!,
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
                              ? Colors.blue[700]
                              : Colors.grey[200],
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            method['icon'],
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
                              method['name'],
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[800],
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              'Saldo: ${method['balance']} ${method['symbol']}',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Dibutuhkan: ${requiredAmount.toStringAsFixed(2)} ${method['symbol']}',
                              style: TextStyle(
                                color: _hasSufficientBalance
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
                        activeColor: Colors.blue[700],
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
          _buildPaymentDetailRow('Harga Properti', 'Rp 2,500,000,000'),
          _buildPaymentDetailRow('Mata Uang', selectedMethod['symbol']),
          _buildPaymentDetailRow(
            'Jumlah yang Dibayar',
            '${requiredAmount.toStringAsFixed(2)} ${selectedMethod['symbol']}',
          ),
          _buildPaymentDetailRow(
            'Kurs',
            '1 ${selectedMethod['symbol']} = Rp ${selectedMethod['exchangeRate'].toStringAsFixed(0)}',
          ),
          Divider(height: 24),
          _buildPaymentDetailRow(
            'Saldo Tersedia',
            '${selectedMethod['balance']} ${selectedMethod['symbol']}',
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
          '• Biaya gas network akan ditanggung oleh pembeli',
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
                ? Colors.blue[700]
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
