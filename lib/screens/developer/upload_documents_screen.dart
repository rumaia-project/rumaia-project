// screens/developer/upload_documents_screen.dart
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rumaia_project/screens/developer/connect_wallet_screen.dart';

class UploadDocumentsScreen extends StatefulWidget {
  const UploadDocumentsScreen({super.key});

  @override
  State<UploadDocumentsScreen> createState() => _UploadDocumentsScreenState();
}

class _UploadDocumentsScreenState extends State<UploadDocumentsScreen> {
  final List<DocumentItem> _requiredDocuments = [
    DocumentItem(
      title: 'Akta Pendirian Perusahaan',
      description: 'Upload scan akta pendirian perusahaan yang sah',
      filePath: null,
      isRequired: true,
    ),
    DocumentItem(
      title: 'NPWP Perusahaan',
      description: 'Nomor Pokok Wajib Pajak perusahaan',
      filePath: null,
      isRequired: true,
    ),
    DocumentItem(
      title: 'TDP (Tanda Daftar Perusahaan)',
      description: 'Surat tanda daftar perusahaan yang masih berlaku',
      filePath: null,
      isRequired: false,
    ),
    DocumentItem(
      title: 'SIUP (Surat Izin Usaha Perdagangan)',
      description: 'Izin usaha perdagangan dari pemerintah',
      filePath: null,
      isRequired: false,
    ),
    DocumentItem(
      title: 'Surat Izin Lokasi',
      description: 'Izin lokasi untuk pembangunan properti',
      filePath: null,
      isRequired: true,
    ),
    DocumentItem(
      title: 'Portfolio Proyek Sebelumnya',
      description: 'Dokumentasi proyek properti yang pernah dikerjakan',
      filePath: null,
      isRequired: false,
    ),
  ];

  bool _isUploading = false;
  int? _currentUploadIndex; // Track which document is being uploaded
  int _uploadedCount = 0;

  // Data untuk styling seperti login screen
  final Map<String, dynamic> _developerData = {
    'icon': Icons.developer_board,
    'color': const Color(0xFF9B59B6),
    'gradient': const [Color(0xFF9B59B6), Color(0xFF8E44AD)],
  };

  Future<void> _pickDocument(int index) async {
    // Set loading state for specific document only
    setState(() {
      _isUploading = true;
      _currentUploadIndex = index;
    });

    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.any,
        allowMultiple: false,
        allowCompression: true,
      );

      if (result != null && result.files.isNotEmpty) {
        final file = result.files.first;
        if (file.path != null) {
          setState(() {
            _requiredDocuments[index].filePath = file.path;
            _requiredDocuments[index].isUploaded = true;
            _requiredDocuments[index].fileName = file.name;
            _uploadedCount = _requiredDocuments
                .where((doc) => doc.isUploaded)
                .length;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                '${_requiredDocuments[index].title} berhasil diupload',
              ),
              backgroundColor: Colors.green,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } finally {
      setState(() {
        _isUploading = false;
        _currentUploadIndex = null;
      });
    }
  }

  bool get _allRequiredUploaded {
    return _requiredDocuments
        .where((doc) => doc.isRequired)
        .every((doc) => doc.isUploaded);
  }

  void _continueToWallet() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectWalletScreen()),
    );
  }

  void _skipAndContinue() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Upload dokumen dilewati - Mode Demo'),
        backgroundColor: Colors.blue,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ConnectWalletScreen()),
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
                        'Upload Dokumen Perusahaan',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                          color: Colors.white,
                          letterSpacing: -0.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Lengkapi dokumen untuk verifikasi',
                        style: TextStyle(
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
                          'Langkah 1 dari 4',
                          style: TextStyle(
                            fontSize: 14,
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Verifikasi Dokumen Perusahaan',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '$_uploadedCount/${_requiredDocuments.length} dokumen terupload',
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.black54,
                          ),
                        ),
                        const SizedBox(height: 12),
                        LinearProgressIndicator(
                          value: _uploadedCount / _requiredDocuments.length,
                          backgroundColor: Colors.grey[300],
                          valueColor: AlwaysStoppedAnimation<Color>(color),
                          minHeight: 8,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _allRequiredUploaded
                              ? 'Semua dokumen wajib telah terupload!'
                              : 'Upload semua dokumen wajib untuk melanjutkan',
                          style: TextStyle(
                            fontSize: 12,
                            color: _allRequiredUploaded
                                ? Colors.green
                                : Colors.orange[700],
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: size.height * 0.04),

                  // Documents List
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
                          'Dokumen yang Diperlukan',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 4),
                        const Text(
                          'Upload dokumen-dokumen berikut untuk proses verifikasi',
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 20),

                        // Documents List
                        ..._requiredDocuments.asMap().entries.map((entry) {
                          final index = entry.key;
                          final doc = entry.value;
                          return _buildDocumentCard(doc, index, color);
                        }),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

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
                            onPressed: _continueToWallet,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: color,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                              elevation: 8,
                              shadowColor: color.withOpacity(0.4),
                            ),
                            child: const Text(
                              'Lanjut',
                              style: TextStyle(
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
                    'Dokumen akan diverifikasi oleh tim admin\nPastikan dokumen jelas dan valid',
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

  Widget _buildDocumentCard(DocumentItem doc, int index, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: doc.isUploaded ? Colors.green[300]! : Colors.grey[300]!,
          width: doc.isUploaded ? 2 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Document Header
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Document Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title dengan Wrap untuk mencegah overflow
                    Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          doc.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        if (doc.isRequired) ...[
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 6,
                              vertical: 2,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red[50],
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(color: Colors.red[200]!),
                            ),
                            child: Text(
                              'Wajib',
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.red[700],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      doc.description,
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),

                    // File info jika sudah diupload
                    if (doc.isUploaded && doc.fileName != null) ...[
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
                                doc.fileName!,
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
                child: _buildUploadButton(doc, index, primaryColor),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildUploadButton(DocumentItem doc, int index, Color primaryColor) {
    // Show loading only for the specific document being uploaded
    bool isCurrentUploading = _isUploading && _currentUploadIndex == index;

    if (isCurrentUploading) {
      return Center(
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
        ),
      );
    }

    return doc.isUploaded
        ? Container(
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.green[300]!),
            ),
            child: const Center(
              child: Icon(Icons.check_circle, color: Colors.green, size: 24),
            ),
          )
        : ElevatedButton(
            onPressed: () => _pickDocument(index),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 12),
              minimumSize: const Size(80, 40),
            ),
            child: const Text(
              'Upload',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          );
  }
}

class DocumentItem {
  final String title;
  final String description;
  final bool isRequired;
  String? filePath;
  String? fileName;
  bool isUploaded;

  DocumentItem({
    required this.title,
    required this.description,
    required this.isRequired,
    this.filePath,
    this.fileName,
    this.isUploaded = false,
  });
}
