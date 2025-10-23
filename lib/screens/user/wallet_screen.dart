// [file name]: wallet_screen.dart
// [file content begin]
import 'package:flutter/material.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});

  @override
  _WalletScreenState createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  int _selectedTab = 0; // 0: Assets, 1: History

  // Sample wallet data
  final List<Map<String, dynamic>> _assets = [
    {
      'symbol': 'IDRT',
      'name': 'Rupiah Token',
      'balance': 5000000.0,
      'valueInIDR': 5000000000.0,
      'change': '+2.5%',
      'changeColor': Colors.green,
      'icon': 'IDRT',
    },
    {
      'symbol': 'USDT',
      'name': 'Tether',
      'balance': 50000.0,
      'valueInIDR': 785000000.0,
      'change': '+1.2%',
      'changeColor': Colors.green,
      'icon': 'USDT',
    },
    {
      'symbol': 'BNB',
      'name': 'Binance Coin',
      'balance': 30.0,
      'valueInIDR': 255000000.0,
      'change': '-0.8%',
      'changeColor': Colors.red,
      'icon': 'BNB',
    },
  ];

  final List<Map<String, dynamic>> _transactions = [
    {
      'type': 'receive',
      'symbol': 'IDRT',
      'amount': 1000000.0,
      'value': 1000000000.0,
      'description': 'Deposit dari Bank',
      'date': '12 Okt 2025',
      'time': '14:30',
      'status': 'Completed',
    },
    {
      'type': 'send',
      'symbol': 'USDT',
      'amount': 5000.0,
      'value': 78500000.0,
      'description': 'Transfer ke Teman',
      'date': '11 Okt 2025',
      'time': '09:15',
      'status': 'Completed',
    },
    {
      'type': 'receive',
      'symbol': 'BNB',
      'amount': 5.0,
      'value': 42500000.0,
      'description': 'Airdrop Reward',
      'date': '10 Okt 2025',
      'time': '16:45',
      'status': 'Completed',
    },
    {
      'type': 'purchase',
      'symbol': 'IDRT',
      'amount': 2000000.0,
      'value': 2000000000.0,
      'description': 'Pembelian Properti',
      'date': '8 Okt 2025',
      'time': '11:20',
      'status': 'Completed',
    },
  ];

  String _formatNumber(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(2)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(2)}K';
    } else if (number < 1) {
      return number.toStringAsFixed(4);
    } else {
      return number.toStringAsFixed(2);
    }
  }

  String _formatCurrency(double amount) {
    if (amount >= 1000000000) {
      return 'Rp ${(amount / 1000000000).toStringAsFixed(2)}B';
    } else if (amount >= 1000000) {
      return 'Rp ${(amount / 1000000).toStringAsFixed(2)}M';
    } else if (amount >= 1000) {
      return 'Rp ${(amount / 1000).toStringAsFixed(2)}K';
    } else {
      return 'Rp ${amount.toStringAsFixed(0)}';
    }
  }

  @override
  Widget build(BuildContext context) {
    double totalBalance = _assets.fold(
      0.0,
      (sum, asset) => sum + asset['valueInIDR'],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Dompet Blockchain',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        actions: [
          IconButton(
            icon: Icon(Icons.qr_code_scanner, color: Colors.grey[700]),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.grey[700]),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Total Balance Card
          Container(
            width: double.infinity,
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
              ),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Total Saldo',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  _formatCurrency(totalBalance),
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 4),
                Text(
                  'Setara dengan ${_formatNumber(totalBalance / 1000)} IDRT',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildActionButton(Icons.arrow_downward, 'Deposit'),
                    _buildActionButton(Icons.arrow_upward, 'Withdraw'),
                    _buildActionButton(Icons.swap_horiz, 'Swap'),
                    _buildActionButton(Icons.send, 'Transfer'),
                  ],
                ),
              ],
            ),
          ),

          // Tabs
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(child: _buildTabButton(0, 'Aset Saya')),
                Expanded(child: _buildTabButton(1, 'Riwayat')),
              ],
            ),
          ),

          SizedBox(height: 16),

          // Content
          Expanded(
            child: _selectedTab == 0
                ? _buildAssetsList()
                : _buildTransactionHistory(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton(int index, String text) {
    bool isActive = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isActive ? Color(0xFF1565C0) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isActive ? Colors.white : Colors.grey[600],
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAssetsList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: _assets.length,
      itemBuilder: (context, index) {
        final asset = _assets[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12),
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
          child: Row(
            children: [
              // Token Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: Color(0xFF1565C0).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    asset['icon'],
                    style: TextStyle(
                      color: Color(0xFF1565C0),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12),

              // Asset Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      asset['symbol'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      asset['name'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '${_formatNumber(asset['balance'])} ${asset['symbol']}',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              // Value and Change
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    _formatCurrency(asset['valueInIDR']),
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.grey[800],
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    asset['change'],
                    style: TextStyle(
                      color: asset['changeColor'],
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildTransactionHistory() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16),
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        final transaction = _transactions[index];
        return Container(
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[300]!),
          ),
          child: Row(
            children: [
              // Transaction Icon
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getTransactionColor(
                    transaction['type'],
                  ).withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Icon(
                    _getTransactionIcon(transaction['type']),
                    color: _getTransactionColor(transaction['type']),
                    size: 20,
                  ),
                ),
              ),
              SizedBox(width: 12),

              // Transaction Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      transaction['description'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 2),
                    Text(
                      '${transaction['date']} • ${transaction['time']}',
                      style: TextStyle(color: Colors.grey[500], fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        transaction['status'],
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Amount
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${transaction['type'] == 'send' || transaction['type'] == 'purchase' ? '-' : '+'}${_formatNumber(transaction['amount'])} ${transaction['symbol']}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getAmountColor(transaction['type']),
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    _formatCurrency(transaction['value']),
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Color _getTransactionColor(String type) {
    switch (type) {
      case 'receive':
        return Colors.green;
      case 'send':
        return Colors.red;
      case 'purchase':
        return Colors.orange;
      default:
        return Colors.blue;
    }
  }

  IconData _getTransactionIcon(String type) {
    switch (type) {
      case 'receive':
        return Icons.arrow_downward;
      case 'send':
        return Icons.arrow_upward;
      case 'purchase':
        return Icons.shopping_cart;
      default:
        return Icons.swap_horiz;
    }
  }

  Color _getAmountColor(String type) {
    switch (type) {
      case 'receive':
        return Colors.green;
      case 'send':
      case 'purchase':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
// [file content end]