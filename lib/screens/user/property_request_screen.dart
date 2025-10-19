import 'package:flutter/material.dart';

class PropertyRequestScreen extends StatefulWidget {
  @override
  _PropertyRequestScreenState createState() => _PropertyRequestScreenState();
}

class _PropertyRequestScreenState extends State<PropertyRequestScreen> {
  int _currentStep = 0;
  bool _isSubmitted = false;

  // Controller untuk form fields
  final TextEditingController _kotaController = TextEditingController();
  final TextEditingController _kecamatanController = TextEditingController();
  final TextEditingController _tipeRumahController = TextEditingController();
  final TextEditingController _jumlahUnitController = TextEditingController();
  final TextEditingController _budgetMinController = TextEditingController();
  final TextEditingController _budgetMaxController = TextEditingController();
  final TextEditingController _spesifikasiController = TextEditingController();

  bool _kolamRenang = false;
  bool _taman = false;

  @override
  void dispose() {
    _kotaController.dispose();
    _kecamatanController.dispose();
    _tipeRumahController.dispose();
    _jumlahUnitController.dispose();
    _budgetMinController.dispose();
    _budgetMaxController.dispose();
    _spesifikasiController.dispose();
    super.dispose();
  }

  void _submitForm() {
    setState(() {
      _isSubmitted = true;
    });

    // Simulasi proses pengiriman data
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isSubmitted = false;
      });
      _showSuccessDialog();
    });
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
                  'Pengajuan Berhasil!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                SizedBox(height: 12),
                Text(
                  'Terima kasih! Data yang Anda kirimkan telah kami terima dan akan menjadi bahan pertimbangan bagi developer dalam proses pembangunan di wilayah Anda.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Reset form dan kembali ke step pertama
                    setState(() {
                      _currentStep = 0;
                      _kotaController.clear();
                      _kecamatanController.clear();
                      _tipeRumahController.clear();
                      _jumlahUnitController.clear();
                      _budgetMinController.clear();
                      _budgetMaxController.clear();
                      _spesifikasiController.clear();
                      _kolamRenang = false;
                      _taman = false;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  ),
                  child: Text(
                    'Oke, Mengerti',
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

  @override
  Widget build(BuildContext context) {
    if (_isSubmitted) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.blue[700]!),
              ),
              SizedBox(height: 20),
              Text(
                'Mengirim Pengajuan...',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Ajukan Pembangunan',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.grey[700]),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Text(
              'Sampaikan kebutuhan rumah Anda kepada developer',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 24),

            // Progress Steps
            Container(
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                children: [
                  Expanded(
                    flex: _currentStep + 1,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF1565C0), Color(0xFF42A5F5)],
                        ),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ),
                  Expanded(flex: 4 - _currentStep, child: Container()),
                ],
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildStepIndicator(0, 'Lokasi'),
                _buildStepIndicator(1, 'Detail'),
                _buildStepIndicator(2, 'Budget'),
                _buildStepIndicator(3, 'Preferensi'),
              ],
            ),
            SizedBox(height: 32),

            // Form Content
            _buildStepContent(),
            SizedBox(height: 32),

            // Navigation Buttons
            Row(
              children: [
                if (_currentStep > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        setState(() {
                          _currentStep--;
                        });
                      },
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        side: BorderSide(color: Colors.grey[300]!),
                      ),
                      child: Text(
                        'Kembali',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                if (_currentStep > 0) SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentStep < 3) {
                        setState(() {
                          _currentStep++;
                        });
                      } else {
                        _submitForm();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue[700],
                      padding: EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 2,
                    ),
                    child: Text(
                      _currentStep == 3 ? 'Ajukan Sekarang' : 'Lanjutkan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStepIndicator(int stepNumber, String title) {
    bool isActive = _currentStep == stepNumber;
    bool isCompleted = _currentStep > stepNumber;

    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isActive || isCompleted
                ? Colors.blue[700]
                : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: Colors.white, size: 18)
                : Text(
                    '${stepNumber + 1}',
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[600],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            color: isActive ? Colors.blue[700] : Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildStepContent() {
    switch (_currentStep) {
      case 0:
        return _buildLokasiStep();
      case 1:
        return _buildDetailStep();
      case 2:
        return _buildBudgetStep();
      case 3:
        return _buildPreferensiStep();
      default:
        return _buildLokasiStep();
    }
  }

  Widget _buildLokasiStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.location_on_outlined, color: Colors.blue[700]),
            SizedBox(width: 8),
            Text(
              'Lokasi yang Diinginkan',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text(
          'Tentukan area pembangunan',
          style: TextStyle(color: Colors.grey[600]),
        ),
        SizedBox(height: 24),
        TextField(
          controller: _kotaController,
          decoration: InputDecoration(
            labelText: 'Kota/Kabupaten',
            hintText: 'Pilih kota',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _kecamatanController,
          decoration: InputDecoration(
            labelText: 'Kecamatan/Area Spesifik',
            hintText: 'Contoh: Cilandak, Pondok Indah',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
      ],
    );
  }

  Widget _buildDetailStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Detail Rumah',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Tentukan spesifikasi rumah yang diinginkan',
          style: TextStyle(color: Colors.grey[600]),
        ),
        SizedBox(height: 24),
        TextField(
          controller: _tipeRumahController,
          decoration: InputDecoration(
            labelText: 'Tipe Rumah',
            hintText: 'Contoh: Minimalis, Modern, Klasik',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _jumlahUnitController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Jumlah Unit',
            hintText: 'Contoh: 1, 2, 3',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
      ],
    );
  }

  Widget _buildBudgetStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Budget Pembangunan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Tentukan kisaran budget yang dimiliki',
          style: TextStyle(color: Colors.grey[600]),
        ),
        SizedBox(height: 24),
        TextField(
          controller: _budgetMinController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Budget Minimal (Rp)',
            hintText: 'Contoh: 500.000.000',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[50],
            prefixText: 'Rp ',
          ),
        ),
        SizedBox(height: 16),
        TextField(
          controller: _budgetMaxController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            labelText: 'Budget Maksimal (Rp)',
            hintText: 'Contoh: 1.000.000.000',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[50],
            prefixText: 'Rp ',
          ),
        ),
      ],
    );
  }

  Widget _buildPreferensiStep() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Preferensi Tambahan',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.grey[800],
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Pilih fasilitas tambahan yang diinginkan',
          style: TextStyle(color: Colors.grey[600]),
        ),
        SizedBox(height: 24),
        TextField(
          controller: _spesifikasiController,
          maxLines: 3,
          decoration: InputDecoration(
            labelText: 'Spesifikasi Khusus',
            hintText: 'Tuliskan spesifikasi khusus yang diinginkan...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
            filled: true,
            fillColor: Colors.grey[50],
          ),
        ),
        SizedBox(height: 20),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[300]!),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Fasilitas Tambahan',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 12),
              CheckboxListTile(
                title: Text('Kolam Renang'),
                value: _kolamRenang,
                onChanged: (value) {
                  setState(() {
                    _kolamRenang = value!;
                  });
                },
                activeColor: Colors.blue[700],
              ),
              CheckboxListTile(
                title: Text('Taman'),
                value: _taman,
                onChanged: (value) {
                  setState(() {
                    _taman = value!;
                  });
                },
                activeColor: Colors.blue[700],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
