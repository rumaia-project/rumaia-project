// screens/developer/connect_wallet_screen.dart
import 'package:flutter/material.dart';
import 'package:rumaia_project/screens/developer/kyc_verification_screen.dart';

class ConnectWalletScreen extends StatefulWidget {
  const ConnectWalletScreen({super.key});

  @override
  State<ConnectWalletScreen> createState() => _ConnectWalletScreenState();
}

class _ConnectWalletScreenState extends State<ConnectWalletScreen> {
  bool _isConnecting = false;
  bool _isConnected = false;
  String? _connectedWallet;

  // Data untuk styling seperti login screen
  final Map<String, dynamic> _developerData = {
    'icon': Icons.account_balance_wallet_rounded,
    'color': const Color(0xFF9B59B6),
    'gradient': const [Color(0xFF9B59B6), Color(0xFF8E44AD)],
  };

  final List<WalletOption> _walletOptions = [
    WalletOption(
      name: 'MetaMask',
      icon: '🦊',
      description: 'Connect with MetaMask wallet',
      color: Colors.orange,
    ),
    WalletOption(
      name: 'Trust Wallet',
      icon: '🔷',
      description: 'Connect with Trust Wallet',
      color: Colors.blue,
    ),
    WalletOption(
      name: 'Coinbase Wallet',
      icon: '⭕',
      description: 'Connect with Coinbase Wallet',
      color: Colors.blue[800]!,
    ),
    WalletOption(
      name: 'WalletConnect',
      icon: '🔗',
      description: 'Connect with WalletConnect',
      color: Colors.blue[400]!,
    ),
  ];

  Future<void> _connectWallet(WalletOption wallet) async {
    setState(() {
      _isConnecting = true;
    });

    // Simulate wallet connection process
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isConnecting = false;
      _isConnected = true;
      _connectedWallet = wallet.name;
    });

    // Auto navigate to KYC after successful connection
    await Future.delayed(const Duration(seconds: 1));
    _continueToKYC();
  }

  void _continueToKYC() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const KYCVerificationScreen()),
    );
  }

  void _skipAndContinue() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Wallet connection skipped - Mode Demo'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const KYCVerificationScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final color = _developerData['color'] as Color;
    final gradient = _developerData['gradient'] as List<Color>;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: gradient,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  SizedBox(height: size.height * 0.03),

                  // Back Button
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back_rounded),
                      color: Colors.white,
                      iconSize: 28,
                    ),
                  ),

                  SizedBox(height: size.height * 0.02),

                  // Logo & Title
                  Column(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 30,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          _developerData['icon'],
                          size: 56,
                          color: color,
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Connect Wallet',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _isConnected
                            ? 'Wallet $_connectedWallet berhasil terhubung'
                            : 'Hubungkan wallet untuk akses blockchain',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),

                  SizedBox(height: size.height * 0.04),

                  // Progress Card
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 30,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Progress Info
                        Text(
                          'Langkah 2 dari 4',
                          style: TextStyle(
                            fontSize: 14,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Connect Your Wallet',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        // Connection Status
                        if (_isConnected) ...[
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.green[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.green[300]!),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green[600],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Wallet Connected Successfully',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green[800],
                                        ),
                                      ),
                                      Text(
                                        'Anda terhubung dengan $_connectedWallet',
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: Colors.green[700],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],

                        Text(
                          _isConnected
                              ? 'Wallet sudah terhubung!'
                              : 'Pilih wallet untuk terkoneksi dengan blockchain',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.04),

                  // Wallet Options List
                  if (!_isConnected && !_isConnecting) ...[
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Pilih Wallet',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Pilih wallet favorit Anda untuk terhubung',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black54,
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Wallet List
                          ..._walletOptions.map(
                            (wallet) => _buildWalletCard(wallet, color),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Loading State
                  if (_isConnecting) ...[
                    Container(
                      padding: const EdgeInsets.all(40),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 30,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                            strokeWidth: 3,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Connecting to wallet...',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Harap tunggu sebentar',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],

                  // Action Buttons
                  Row(
                    children: [
                      // Skip Button
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: OutlinedButton(
                            onPressed: _skipAndContinue,
                            style: OutlinedButton.styleFrom(
                              foregroundColor: Colors.white,
                              side: const BorderSide(color: Colors.white),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: const Text(
                              'Lewati',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      // Continue Button
                      Expanded(
                        child: SizedBox(
                          height: 56,
                          child: ElevatedButton(
                            onPressed: _isConnected ? _continueToKYC : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: color,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 8,
                              shadowColor: color.withOpacity(0.4),
                            ),
                            child: Text(
                              _isConnected ? 'Lanjut' : 'Pilih Wallet',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Footer
                  const Text(
                    'Wallet digunakan untuk transaksi blockchain\n dan verifikasi identitas digital',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70,
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWalletCard(WalletOption wallet, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _connectWallet(wallet),
          child: Row(
            children: [
              // Wallet Icon
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: wallet.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: wallet.color.withOpacity(0.3)),
                ),
                child: Center(
                  child: Text(
                    wallet.icon,
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
              ),

              const SizedBox(width: 16),

              // Wallet Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      wallet.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      wallet.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Connect Icon
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: primaryColor,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WalletOption {
  final String name;
  final String icon;
  final String description;
  final Color color;

  WalletOption({
    required this.name,
    required this.icon,
    required this.description,
    required this.color,
  });
}
