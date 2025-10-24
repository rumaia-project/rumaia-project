// screens/developer/kyc_verification_screen.dart
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rumaia_project/screens/developer/admin_verification_screen.dart';

class KYCVerificationScreen extends StatefulWidget {
  const KYCVerificationScreen({super.key});

  @override
  State<KYCVerificationScreen> createState() => _KYCVerificationScreenState();
}

class _KYCVerificationScreenState extends State<KYCVerificationScreen> {
  bool _isVerifying = false;
  bool _isVerified = false;
  String? _selfiePath;
  String? _idCardFrontPath;
  String? _idCardBackPath;

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _idNumberController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  // Data untuk styling seperti screen sebelumnya
  final Map<String, dynamic> _developerData = {
    'icon': Icons.verified_user_rounded,
    'color': const Color(0xFF9B59B6),
    'gradient': const [Color(0xFF9B59B6), Color(0xFF8E44AD)],
  };

  Future<void> _pickImage(String type) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null && result.files.single.path != null) {
      setState(() {
        switch (type) {
          case 'selfie':
            _selfiePath = result.files.single.path;
            break;
          case 'id_front':
            _idCardFrontPath = result.files.single.path;
            break;
          case 'id_back':
            _idCardBackPath = result.files.single.path;
            break;
        }
      });
    }
  }

  Future<void> _submitVerification() async {
    if (_fullNameController.text.isEmpty ||
        _idNumberController.text.isEmpty ||
        _dateOfBirthController.text.isEmpty ||
        _selfiePath == null ||
        _idCardFrontPath == null ||
        _idCardBackPath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Harap lengkapi semua data verifikasi'),
          backgroundColor: Colors.orange,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      return;
    }

    setState(() => _isVerifying = true);

    // Simulate KYC verification process
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isVerifying = false;
      _isVerified = true;
    });

    // Auto navigate to admin verification after successful KYC
    await Future.delayed(const Duration(seconds: 1));
    _continueToAdminVerification();
  }

  void _continueToAdminVerification() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminVerificationScreen()),
    );
  }

  void _skipAndContinue() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('KYC verification skipped - Mode Demo'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AdminVerificationScreen()),
    );
  }

  bool get _allDocumentsUploaded {
    return _selfiePath != null &&
        _idCardFrontPath != null &&
        _idCardBackPath != null;
  }

  bool get _canContinue {
    return _isVerified ||
        (_allDocumentsUploaded &&
            _fullNameController.text.isNotEmpty &&
            _idNumberController.text.isNotEmpty &&
            _dateOfBirthController.text.isNotEmpty);
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
                        'Verifikasi KYC',
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
                        _isVerified
                            ? 'Identitas Anda telah terverifikasi'
                            : 'Verifikasi identitas untuk keamanan transaksi',
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
                          'Langkah 3 dari 4',
                          style: TextStyle(
                            fontSize: 14,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Know Your Customer (KYC)',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),

                        // Verification Status
                        if (_isVerified) ...[
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
                                  Icons.verified_user,
                                  color: Colors.green[600],
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'KYC Verification Successful',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.green[800],
                                        ),
                                      ),
                                      Text(
                                        'Identitas Anda telah terverifikasi',
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
                          _isVerified
                              ? 'Verifikasi KYC berhasil!'
                              : 'Lengkapi data dan upload dokumen identitas',
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

                  // KYC Form
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
                          'Informasi Pribadi',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Isi data diri sesuai dokumen identitas',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 20),

                        // Personal Information Form
                        _buildTextField(
                          controller: _fullNameController,
                          label: 'Nama Lengkap',
                          hint: 'Masukkan nama lengkap sesuai KTP',
                          color: color,
                        ),
                        _buildTextField(
                          controller: _idNumberController,
                          label: 'Nomor KTP',
                          hint: 'Masukkan 16 digit nomor KTP',
                          keyboardType: TextInputType.number,
                          color: color,
                        ),
                        _buildTextField(
                          controller: _dateOfBirthController,
                          label: 'Tanggal Lahir',
                          hint: 'DD/MM/YYYY',
                          onTap: () => _selectDate(context),
                          color: color,
                        ),

                        const SizedBox(height: 24),

                        // Document Uploads
                        const Text(
                          'Upload Dokumen',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Upload foto dokumen identitas yang jelas',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 20),

                        _buildDocumentUpload(
                          title: 'Foto Selfie dengan KTP',
                          description: 'Ambil foto selfie Anda memegang KTP',
                          filePath: _selfiePath,
                          onTap: () => _pickImage('selfie'),
                          color: color,
                        ),

                        _buildDocumentUpload(
                          title: 'Foto KTP (Depan)',
                          description: 'Upload foto depan KTP yang jelas',
                          filePath: _idCardFrontPath,
                          onTap: () => _pickImage('id_front'),
                          color: color,
                        ),

                        _buildDocumentUpload(
                          title: 'Foto KTP (Belakang)',
                          description: 'Upload foto belakang KTP yang jelas',
                          filePath: _idCardBackPath,
                          onTap: () => _pickImage('id_back'),
                          color: color,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Loading State
                  if (_isVerifying) ...[
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
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(color),
                            strokeWidth: 3,
                          ),
                          const SizedBox(height: 20),
                          const Text(
                            'Memverifikasi KYC...',
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
                            onPressed: _canContinue && !_isVerifying
                                ? _submitVerification
                                : null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: color,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 8,
                              shadowColor: color.withOpacity(0.4),
                            ),
                            child: _isVerifying
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    _isVerified ? 'Lanjut' : 'Verifikasi KYC',
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
                    'Data KYC akan digunakan untuk verifikasi identitas\n dan keamanan transaksi blockchain',
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    TextInputType keyboardType = TextInputType.text,
    VoidCallback? onTap,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            onTap: onTap,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.grey[50],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey[300]!, width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: color, width: 2),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDocumentUpload({
    required String title,
    required String description,
    required String? filePath,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: filePath != null ? Colors.green[300]! : Colors.grey[300]!,
          width: filePath != null ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),

                    // File info jika sudah diupload
                    if (filePath != null) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green[600],
                              size: 16,
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                filePath.split('/').last,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.green[700],
                                  fontWeight: FontWeight.w500,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              const SizedBox(width: 12),

              // Upload Button
              ConstrainedBox(
                constraints: const BoxConstraints(
                  minWidth: 80,
                  maxWidth: 80,
                  minHeight: 40,
                ),
                child: filePath != null
                    ? Container(
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.green[300]!),
                        ),
                        child: const Center(
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24,
                          ),
                        ),
                      )
                    : ElevatedButton(
                        onPressed: onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: color,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          minimumSize: const Size(80, 40),
                        ),
                        child: const Text(
                          'Upload',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      _dateOfBirthController.text =
          "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
    }
  }
}
