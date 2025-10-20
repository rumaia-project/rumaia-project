import 'package:flutter/material.dart';

class SalePropertyScreen extends StatelessWidget {
  const SalePropertyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        title: const Text('Jual Properti Anda'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: colorScheme.surface,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: _buildFormBody(context),
    );
  }

  // --- Body Form ---
  Widget _buildFormBody(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Header Section ---
          Text(
            'Langkah Mudah Jual Properti',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Isi detail berikut agar properti Anda segera tayang di marketplace.',
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: colorScheme.outline),
          ),
          const SizedBox(height: 28),

          // --- 1. DETAIL DASAR ---
          _buildSectionTitle(context, '1. Detail Dasar Properti'),
          _buildInputField(
            context,
            labelText: 'Judul Listing',
            hintText: 'Misalnya: Rumah Minimalis 3KT di Jakarta',
            icon: Icons.title_rounded,
          ),
          _buildInputField(
            context,
            labelText: 'Lokasi Lengkap',
            hintText: 'Jl. Melati No.10, Jakarta Selatan',
            icon: Icons.location_on_outlined,
          ),
          _buildInputField(
            context,
            labelText: 'Luas Tanah (m²)',
            hintText: 'Contoh: 120',
            icon: Icons.square_foot,
            keyboardType: TextInputType.number,
          ),
          _buildInputField(
            context,
            labelText: 'Luas Bangunan (m²)',
            hintText: 'Contoh: 90',
            icon: Icons.home_work_outlined,
            keyboardType: TextInputType.number,
          ),
          _buildDescriptionField(
            context,
            labelText: 'Deskripsi Properti',
            hintText:
                'Ceritakan fitur unggulan, fasilitas sekitar, dan kondisi properti Anda.',
            icon: Icons.description_outlined,
          ),
          const SizedBox(height: 30),

          // --- 2. HARGA & TIPE ---
          _buildSectionTitle(context, '2. Harga & Tipe Properti'),
          _buildInputField(
            context,
            labelText: 'Harga Jual (Rp)',
            hintText: 'Misalnya: 1500000000',
            icon: Icons.attach_money_rounded,
            keyboardType: TextInputType.number,
          ),
          _buildDropdownField(
            context,
            labelText: 'Tipe Properti',
            icon: Icons.category_outlined,
            items: const ['Rumah', 'Apartemen', 'Ruko', 'Tanah'],
          ),
          const SizedBox(height: 30),

          // --- 3. GAMBAR ---
          _buildSectionTitle(context, '3. Foto Utama'),
          _buildImageUploadArea(context),
          const SizedBox(height: 40),

          // --- Submit Button ---
          FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Properti sedang diunggah...')),
              );
            },
            icon: const Icon(Icons.cloud_upload_rounded),
            label: const Text(
              'Ajukan Properti',
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            style: FilledButton.styleFrom(
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  // --- Section Title ---
  Widget _buildSectionTitle(BuildContext context, String title) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: colorScheme.primary,
        ),
      ),
    );
  }

  // --- Input Field ---
  Widget _buildInputField(
    BuildContext context, {
    required String labelText,
    required String hintText,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Icon(icon, color: colorScheme.primary),
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 10,
          ),
        ),
      ),
    );
  }

  // --- Deskripsi Field ---
  Widget _buildDescriptionField(
    BuildContext context, {
    required String labelText,
    required String hintText,
    required IconData icon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        maxLines: 4,
        textAlignVertical: TextAlignVertical.top,
        decoration: InputDecoration(
          labelText: labelText,
          hintText: hintText,
          prefixIcon: Padding(
            padding: const EdgeInsets.only(top: 15.0),
            child: Icon(icon, color: colorScheme.primary),
          ),
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 10,
          ),
        ),
      ),
    );
  }

  // --- Dropdown Field ---
  Widget _buildDropdownField(
    BuildContext context, {
    required String labelText,
    required IconData icon,
    required List<String> items,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: Icon(icon, color: colorScheme.primary),
          filled: true,
          fillColor: colorScheme.surfaceContainerHighest,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        items: items
            .map((e) => DropdownMenuItem(value: e, child: Text(e)))
            .toList(),
        onChanged: (_) {},
      ),
    );
  }

  // --- Upload Area ---
  Widget _buildImageUploadArea(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: Column(
        children: [
          Icon(
            Icons.photo_camera_back_outlined,
            size: 48,
            color: colorScheme.primary,
          ),
          const SizedBox(height: 10),
          Text(
            'Upload Foto Properti (Maks. 5)',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: colorScheme.onSurface,
            ),
          ),
          const SizedBox(height: 12),
          OutlinedButton.icon(
            onPressed: () {},
            icon: Icon(Icons.add_a_photo_rounded, color: colorScheme.primary),
            label: Text(
              'Pilih Gambar',
              style: TextStyle(color: colorScheme.primary),
            ),
            style: OutlinedButton.styleFrom(
              side: BorderSide(color: colorScheme.primary),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
