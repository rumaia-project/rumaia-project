import 'package:flutter/material.dart';
import 'package:rumaia_project/utils/investor/investor_color.dart';

class InvestorCreateInvestScreen extends StatefulWidget {
  const InvestorCreateInvestScreen({super.key});

  @override
  State<InvestorCreateInvestScreen> createState() =>
      _InvestorCreateInvestScreenState();
}

class _InvestorCreateInvestScreenState
    extends State<InvestorCreateInvestScreen> {
  int currentStep = 0;
  int investmentAmount = 5000;
  String selectedDuration = "6 Months";
  String selectedPayment = "Wallet Balance";

  // 🔁 Stepper Control
  void nextStep() {
    if (currentStep < 3) {
      setState(() => currentStep += 1);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Investment Created Successfully!")),
      );
      Navigator.pop(context);
    }
  }

  void prevStep() {
    if (currentStep > 0) setState(() => currentStep -= 1);
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
        // iconTheme: const IconThemeData(color: primaryColor),
      ),
      body: Stepper(
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
                onPressed: details.onStepContinue,
                style: ElevatedButton.styleFrom(
                  backgroundColor: InvestorColor.primaryColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  currentStep == 3 ? "Confirm" : "Next",
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
            state: currentStep > 0 ? StepState.complete : StepState.indexed,
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
                      Text(
                        "\$${investmentAmount.toString()}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: InvestorColor.textColor,
                        ),
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
            state: currentStep > 1 ? StepState.complete : StepState.indexed,
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

          // 💳 STEP 3 - Payment
          Step(
            title: const Text("Payment"),
            isActive: currentStep >= 2,
            state: currentStep > 2 ? StepState.complete : StepState.indexed,
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Select payment method",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: InvestorColor.textColor,
                  ),
                ),
                const SizedBox(height: 12),
                _paymentOption(
                  "Wallet Balance",
                  Icons.account_balance_wallet_outlined,
                ),
                const SizedBox(height: 10),
                _paymentOption("Credit / Debit Card", Icons.credit_card),
                const SizedBox(height: 10),
                _paymentOption("Bank Transfer", Icons.account_balance),
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
                      _reviewRow("Amount", "\$$investmentAmount"),
                      const Divider(),
                      _reviewRow("Duration", selectedDuration),
                      const Divider(),
                      _reviewRow("Payment Method", selectedPayment),
                    ],
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

  // 💳 Helper Widget: Payment Option Box
  Widget _paymentOption(String label, IconData icon) {
    final isSelected = selectedPayment == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedPayment = label;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected
              ? InvestorColor.primaryColor.withOpacity(0.1)
              : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? InvestorColor.primaryColor
                : Colors.grey.shade300,
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.05),
              blurRadius: 4,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: isSelected ? InvestorColor.primaryColor : Colors.grey,
            ),
            const SizedBox(width: 12),
            Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? InvestorColor.primaryColor
                    : InvestorColor.textColor,
              ),
            ),
          ],
        ),
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
