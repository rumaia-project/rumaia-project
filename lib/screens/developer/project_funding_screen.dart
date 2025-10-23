// [file name]: project_funding_screen.dart
// [file content begin]
import 'package:flutter/material.dart';
import 'package:rumaia_project/utils/developer/app_color.dart';

class ProjectFundingScreen extends StatefulWidget {
  final Map<String, dynamic> project;

  const ProjectFundingScreen({super.key, required this.project});

  @override
  _ProjectFundingScreenState createState() => _ProjectFundingScreenState();
}

class _ProjectFundingScreenState extends State<ProjectFundingScreen> {
  int _selectedPaymentMethod = 0; // 0: IDRT, 1: BNB, 2: USDT
  double _fundingAmount = 0.0;
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'IDRT Token',
      'symbol': 'IDRT',
      'icon': 'IDRT',
      'exchangeRate': 1.0, // 1 IDRT = 1 IDR
      'balance': 500000000.0, // 500M IDRT
    },
    {
      'name': 'BNB',
      'symbol': 'BNB',
      'icon': 'BNB',
      'exchangeRate': 8500000.0, // 1 BNB = 8.5M IDR
      'balance': 50.0, // 50 BNB
    },
    {
      'name': 'USDT',
      'symbol': 'USDT',
      'icon': 'USDT',
      'exchangeRate': 15700.0, // 1 USDT = 15,700 IDR
      'balance': 30000.0, // 30K USDT
    },
  ];

  final TextEditingController _amountController = TextEditingController();

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

  double get _requiredAmount {
    if (_fundingAmount <= 0) return 0;

    // FIX: Convert to double explicitly
    double exchangeRate =
        (_paymentMethods[_selectedPaymentMethod]['exchangeRate'] as num)
            .toDouble();
    return _fundingAmount / exchangeRate;
  }

  bool get _hasSufficientBalance {
    // FIX: Convert to double explicitly
    double balance = (_paymentMethods[_selectedPaymentMethod]['balance'] as num)
        .toDouble();
    return balance >= _requiredAmount;
  }

  void _processFunding() async {
    if (_fundingAmount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid funding amount'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (!_hasSufficientBalance) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Insufficient balance for selected payment method'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isProcessing = true;
    });

    // Simulate blockchain transaction
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
                  'Funding Successful!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Your investment has been successfully processed on the blockchain.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),

                // Project Investment Card
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.green.withOpacity(0.3)),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Investment Details',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green,
                        ),
                      ),
                      SizedBox(height: 8),
                      _buildTransactionDetail(
                        'Project',
                        widget.project['title'],
                      ),
                      _buildTransactionDetail(
                        'Amount',
                        _formatCurrency(_fundingAmount),
                      ),
                      _buildTransactionDetail(
                        'Token Used',
                        _paymentMethods[_selectedPaymentMethod]['symbol'],
                      ),
                      _buildTransactionDetail(
                        'Tokens Paid',
                        '${_formatNumber(_requiredAmount)} ${_paymentMethods[_selectedPaymentMethod]['symbol']}',
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // Back to projects list
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    'Back to Projects',
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundColor,
      appBar: AppBar(
        title: Text(
          'Project Funding',
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
                  // Project Summary
                  _buildProjectSummary(),
                  SizedBox(height: 24),

                  // Funding Amount Input
                  _buildFundingAmountSection(),
                  SizedBox(height: 24),

                  // Payment Method Selection
                  _buildPaymentMethodSection(),
                  SizedBox(height: 24),

                  // Funding Details
                  _buildFundingDetails(),
                  SizedBox(height: 32),

                  // Terms and Conditions
                  _buildTermsAndConditions(),
                  SizedBox(height: 24),

                  // Fund Button
                  _buildFundButton(),
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
            valueColor: AlwaysStoppedAnimation<Color>(AppColor.primaryColor),
          ),
          SizedBox(height: 20),
          Text(
            'Processing Investment...',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[700],
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Transaction is being processed on the blockchain\nPlease wait a moment',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey[600], fontSize: 14),
          ),
        ],
      ),
    );
  }

  Widget _buildProjectSummary() {
    // FIX: Convert project data to double explicitly
    double fundingRaised = (widget.project['fundingRaised'] as num).toDouble();
    double fundingTarget = (widget.project['fundingTarget'] as num).toDouble();
    double progress = (widget.project['progress'] as num).toDouble();

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Project Investment',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 12),
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColor.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(Icons.apartment, color: AppColor.primaryColor),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.project['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.grey[800],
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.project['location'],
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'ROI: ${widget.project['estimatedROI']} • ${widget.project['duration']}',
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildProjectStat('Target', widget.project['totalFunding']),
              _buildProjectStat(
                'Raised',
                _formatCurrency(fundingRaised + _fundingAmount),
              ),
              _buildProjectStat(
                'Progress',
                '${((progress * 100) + (_fundingAmount / fundingTarget * 100)).toStringAsFixed(1)}%',
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProjectStat(String label, String value) {
    return Column(
      children: [
        Text(label, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
        SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColor.primaryColor,
          ),
        ),
      ],
    );
  }

  Widget _buildFundingAmountSection() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Funding Amount',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              labelText: 'Amount in IDR',
              hintText: 'Enter funding amount',
              prefixText: 'Rp ',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              setState(() {
                _fundingAmount = double.tryParse(value) ?? 0.0;
              });
            },
          ),
          SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              _buildQuickAmountButton(100000000, 'Rp100M'),
              _buildQuickAmountButton(500000000, 'Rp500M'),
              _buildQuickAmountButton(1000000000, 'Rp1B'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAmountButton(double amount, String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _fundingAmount = amount;
          _amountController.text = amount.toStringAsFixed(0);
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: _fundingAmount == amount
            ? AppColor.primaryColor
            : Colors.grey[200],
        foregroundColor: _fundingAmount == amount
            ? Colors.white
            : Colors.grey[700],
      ),
      child: Text(label),
    );
  }

  Widget _buildPaymentMethodSection() {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Payment Method',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 12),
          ..._paymentMethods.asMap().entries.map((entry) {
            int index = entry.key;
            var method = entry.value;
            bool isSelected = _selectedPaymentMethod == index;

            return Container(
              margin: EdgeInsets.only(bottom: 8),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    setState(() {
                      _selectedPaymentMethod = index;
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColor.primaryColor.withOpacity(0.1)
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: isSelected
                            ? AppColor.primaryColor
                            : Colors.grey[300]!,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColor.primaryColor
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
                              Text(
                                'Balance: ${_formatNumber((method['balance'] as num).toDouble())} ${method['symbol']}',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
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
                          activeColor: AppColor.primaryColor,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildFundingDetails() {
    var selectedMethod = _paymentMethods[_selectedPaymentMethod];

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
            'Funding Details',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          SizedBox(height: 12),
          _buildDetailRow('Project', widget.project['title']),
          _buildDetailRow('Developer', widget.project['developerCompany']),
          _buildDetailRow('Funding Amount', _formatCurrency(_fundingAmount)),
          _buildDetailRow('Payment Method', selectedMethod['name']),
          _buildDetailRow(
            'Tokens Required',
            '${_formatNumber(_requiredAmount)} ${selectedMethod['symbol']}',
          ),
          _buildDetailRow(
            'Exchange Rate',
            '1 ${selectedMethod['symbol']} = Rp ${_formatNumber((selectedMethod['exchangeRate'] as num).toDouble())}',
          ),
          Divider(height: 20),
          _buildDetailRow(
            'Your Balance',
            '${_formatNumber((selectedMethod['balance'] as num).toDouble())} ${selectedMethod['symbol']}',
            valueColor: _hasSufficientBalance ? Colors.green : Colors.red,
          ),
          _buildDetailRow(
            'Status',
            _hasSufficientBalance
                ? 'Sufficient Balance'
                : 'Insufficient Balance',
            valueColor: _hasSufficientBalance ? Colors.green : Colors.red,
          ),
        ],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value, {Color? valueColor}) {
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
          'Terms & Conditions',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          '• This investment is subject to project completion and market conditions\n'
          '• Returns are estimated and not guaranteed\n'
          '• Blockchain transactions are irreversible\n'
          '• Your investment will be locked until project completion\n'
          '• Early withdrawal may incur penalties',
          style: TextStyle(color: Colors.grey[600], fontSize: 12, height: 1.5),
        ),
      ],
    );
  }

  Widget _buildFundButton() {
    return Column(
      children: [
        if (!_hasSufficientBalance && _fundingAmount > 0)
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
                Icon(Icons.warning, color: Colors.red, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Insufficient ${_paymentMethods[_selectedPaymentMethod]['symbol']} balance',
                    style: TextStyle(color: Colors.red[700], fontSize: 12),
                  ),
                ),
              ],
            ),
          ),
        ElevatedButton(
          onPressed: _fundingAmount > 0 && _hasSufficientBalance
              ? _processFunding
              : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: _fundingAmount > 0 && _hasSufficientBalance
                ? AppColor.primaryColor
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
              Icon(Icons.attach_money, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Invest in Project',
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
// [file content end]