// [file name]: investor_blockchain_invest_screen.dart
import 'package:flutter/material.dart';
import 'package:rumaia_project/utils/investor/investor_color.dart';

class InvestorBlockchainInvestScreen extends StatefulWidget {
  final Map<String, dynamic> investment;

  const InvestorBlockchainInvestScreen({super.key, required this.investment});

  @override
  State<InvestorBlockchainInvestScreen> createState() =>
      _InvestorBlockchainInvestScreenState();
}

class _InvestorBlockchainInvestScreenState
    extends State<InvestorBlockchainInvestScreen> {
  int currentStep = 0;
  double investmentAmount = 5000.0;
  String selectedDuration = "6 Months";
  int _selectedPaymentMethod = 0; // 0: IDRT, 1: USDT, 2: BNB
  bool _isProcessing = false;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'IDRT Token',
      'symbol': 'IDRT',
      'icon': 'IDRT',
      'exchangeRate': 15750.0,
      'balance': 12500000,
    },
    {
      'name': 'USDT',
      'symbol': 'USDT',
      'icon': 'USDT',
      'exchangeRate': 1.0,
      'balance': 800,
    },
    {
      'name': 'BNB',
      'symbol': 'BNB',
      'icon': 'BNB',
      'exchangeRate': 0.00019,
      'balance': 2.5,
    },
  ];

  // 🔁 Stepper Control
  void nextStep() {
    if (currentStep < 3) {
      setState(() => currentStep += 1);
    } else {
      _processBlockchainPayment();
    }
  }

  void prevStep() {
    if (currentStep > 0) setState(() => currentStep -= 1);
  }

  void _processBlockchainPayment() async {
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
                  'Investasi Berhasil!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Transaksi investasi Anda telah berhasil diproses di blockchain. Detail investasi telah dikirim ke email Anda.',
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
                      _buildTransactionDetail(
                        'Proyek',
                        widget.investment['title'],
                      ),
                      _buildTransactionDetail(
                        'Token Used',
                        _paymentMethods[_selectedPaymentMethod]['symbol'],
                      ),
                      _buildTransactionDetail(
                        'Amount',
                        '${_requiredAmount.toStringAsFixed(2)} ${_paymentMethods[_selectedPaymentMethod]['symbol']}',
                      ),
                      _buildTransactionDetail('Blockchain', 'BNB Smart Chain'),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop(); // Kembali ke detail investasi
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

  double get _requiredAmount {
    return investmentAmount /
        _paymentMethods[_selectedPaymentMethod]['exchangeRate'];
  }

  bool get _hasSufficientBalance {
    return _paymentMethods[_selectedPaymentMethod]['balance'] >=
        _requiredAmount;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: InvestorColor.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Create Investment",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: _isProcessing
          ? _buildProcessingScreen()
          : Stepper(
              type: StepperType.vertical,
              currentStep: currentStep,
              onStepContinue: nextStep,
              onStepCancel: prevStep,
              controlsBuilder: (context, details) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (currentStep > 0)
                      TextButton(
                        onPressed: details.onStepCancel,
                        child: const Text(
                          "Back",
                          style: TextStyle(color: InvestorColor.primaryColor),
                        ),
                      ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _hasSufficientBalance || currentStep != 2
                          ? details.onStepContinue
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: InvestorColor.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        currentStep == 3 ? "Confirm Investment" : "Next",
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                );
              },
              steps: [
                // 💵 STEP 1 - Investment Amount
                Step(
                  title: const Text("Amount"),
                  isActive: currentStep >= 0,
                  state: currentStep > 0
                      ? StepState.complete
                      : StepState.indexed,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Choose investment amount",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: InvestorColor.textColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 4,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.remove_circle_outline,
                                color: InvestorColor.primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (investmentAmount > 1000) {
                                    investmentAmount -= 500;
                                  }
                                });
                              },
                            ),
                            Column(
                              children: [
                                Text(
                                  "\$${investmentAmount.toStringAsFixed(0)}",
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: InvestorColor.textColor,
                                  ),
                                ),
                                Text(
                                  "≈ ${_requiredAmount.toStringAsFixed(2)} ${_paymentMethods[_selectedPaymentMethod]['symbol']}",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.add_circle_outline,
                                color: InvestorColor.primaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  investmentAmount += 500;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // ⏳ STEP 2 - Duration
                Step(
                  title: const Text("Duration"),
                  isActive: currentStep >= 1,
                  state: currentStep > 1
                      ? StepState.complete
                      : StepState.indexed,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select investment duration",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: InvestorColor.textColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        children: [
                          _durationChip("3 Months"),
                          _durationChip("6 Months"),
                          _durationChip("12 Months"),
                        ],
                      ),
                    ],
                  ),
                ),

                // 💳 STEP 3 - Blockchain Payment
                Step(
                  title: const Text("Blockchain Payment"),
                  isActive: currentStep >= 2,
                  state: currentStep > 2
                      ? StepState.complete
                      : StepState.indexed,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Select blockchain payment method",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: InvestorColor.textColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ..._paymentMethods.asMap().entries.map((entry) {
                        int index = entry.key;
                        var method = entry.value;
                        bool isSelected = _selectedPaymentMethod == index;
                        double requiredAmount =
                            investmentAmount / method['exchangeRate'];

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
                                      ? Colors.blue[50]
                                      : Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: isSelected
                                        ? InvestorColor.primaryColor
                                        : Colors.grey[300]!,
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
                                            ? InvestorColor.primaryColor
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                      activeColor: InvestorColor.primaryColor,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),

                      if (!_hasSufficientBalance)
                        Container(
                          padding: EdgeInsets.all(12),
                          margin: EdgeInsets.only(top: 16),
                          decoration: BoxDecoration(
                            color: Colors.red[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.red[200]!),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.warning_amber,
                                color: Colors.red,
                                size: 20,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Saldo ${_paymentMethods[_selectedPaymentMethod]['symbol']} tidak mencukupi',
                                  style: TextStyle(
                                    color: Colors.red[700],
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),

                // 🧾 STEP 4 - Review
                Step(
                  title: const Text("Review"),
                  isActive: currentStep >= 3,
                  state: StepState.indexed,
                  content: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Review your investment details",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: InvestorColor.textColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.1),
                              blurRadius: 6,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _reviewRow("Project", widget.investment['title']),
                            const Divider(),
                            _reviewRow(
                              "Amount",
                              "\$${investmentAmount.toStringAsFixed(0)}",
                            ),
                            _reviewRow(
                              "Token Amount",
                              "${_requiredAmount.toStringAsFixed(2)} ${_paymentMethods[_selectedPaymentMethod]['symbol']}",
                            ),
                            const Divider(),
                            _reviewRow("Duration", selectedDuration),
                            const Divider(),
                            _reviewRow(
                              "Payment Method",
                              _paymentMethods[_selectedPaymentMethod]['name'],
                            ),
                            const Divider(),
                            _reviewRow("Blockchain", "BNB Smart Chain"),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Container(
                        padding: EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '• Transaksi blockchain bersifat irreversible\n'
                          '• Investasi akan dikonfirmasi dalam 3 blok\n'
                          '• Biaya gas network akan ditambahkan otomatis',
                          style: TextStyle(
                            color: Colors.blue[700],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget _buildProcessingScreen() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              InvestorColor.primaryColor,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Memproses Investasi di Blockchain...',
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
                Icon(
                  Icons.info_outline,
                  color: InvestorColor.primaryColor,
                  size: 20,
                ),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Transaksi blockchain membutuhkan waktu beberapa detik untuk dikonfirmasi',
                    style: TextStyle(
                      color: InvestorColor.primaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔘 Helper Widget: Duration Choice Chip
  Widget _durationChip(String label) {
    final isSelected = selectedDuration == label;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (bool selected) {
        setState(() {
          selectedDuration = label;
        });
      },
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : InvestorColor.textColor,
        fontWeight: FontWeight.w500,
      ),
      selectedColor: InvestorColor.primaryColor,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(color: InvestorColor.primaryColor),
      ),
    );
  }

  // 📄 Helper Widget: Review Row
  Widget _reviewRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          Text(
            value,
            style: const TextStyle(
              color: InvestorColor.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
