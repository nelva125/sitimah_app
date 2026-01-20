import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA), // Light grey background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF2563EB),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.widgets, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 8),
            Text(
              'siTIMAH',
              style: GoogleFonts.inter(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: InkWell(
              onTap: () => Provider.of<AuthProvider>(context, listen: false).logout(),
              child: Row(
                children: [
                  const Icon(Icons.logout, color: Colors.black, size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Keluar',
                    style: GoogleFonts.inter(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildProfileInfoCard(context),
            const SizedBox(height: 16),
            _buildAppInfoCard(),
            const SizedBox(height: 30), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildProfileInfoCard(BuildContext context) {
    // Consume data from AuthProvider
    final authProvider = Provider.of<AuthProvider>(context);
    
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Informasi Profil',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Kelola informasi akun Anda',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () => _showEditProfileDialog(context, authProvider),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F172A), // Dark color like in image
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  minimumSize: const Size(0, 36),
                ),
                child: Text(
                  'Edit Profil',
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          _buildProfileField(
            label: 'Nama Lengkap',
            value: authProvider.fullName,
            icon: Icons.person_outline,
          ),
          _buildProfileField(
            label: 'Email',
            value: authProvider.email,
            icon: Icons.email_outlined,
          ),
          _buildProfileField(
            label: 'Nomor Telepon',
            value: authProvider.phoneNumber,
            icon: Icons.phone_outlined,
          ),
          _buildProfileField(
            label: 'Perusahaan',
            value: authProvider.companyName,
            icon: Icons.business_outlined,
          ),
          _buildProfileField(
            label: 'Alamat',
            value: authProvider.address,
            icon: Icons.location_on_outlined,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileField({required String label, required String value, required IconData icon}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: Colors.grey[700]),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFF8F9FA), // Very light grey bg for input
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 14,
                color: value.isEmpty || value == 'Nama perusahaan' || value == 'Alamat lengkap' 
                    ? Colors.grey[400] 
                    : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppInfoCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
         boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tentang Aplikasi',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Versi', '1.0.0'),
          const SizedBox(height: 8),
          _buildInfoRow('Aplikasi', 'siTIMAH'),
          const SizedBox(height: 16),
          Text(
            'Aplikasi ini dirancang untuk membantu Anda mencatat dan melacak pembelian timah dengan mudah dan efisien.',
            style: GoogleFonts.inter(
              fontSize: 13,
              height: 1.5,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.inter(fontSize: 13, color: Colors.black87),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          TextSpan(
            text: value,
            style: const TextStyle(fontWeight: FontWeight.normal),
          ),
        ],
      ),
    );
  }

  void _showEditProfileDialog(BuildContext context, AuthProvider authProvider) {
    final _formKey = GlobalKey<FormState>();
    final _nameController = TextEditingController(text: authProvider.fullName);
    final _emailController = TextEditingController(text: authProvider.email);
    final _phoneController = TextEditingController(text: authProvider.phoneNumber);
    final _companyController = TextEditingController(text: authProvider.companyName);
    final _addressController = TextEditingController(text: authProvider.address);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Profil', style: GoogleFonts.inter(fontWeight: FontWeight.w600)),
        content: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTextField(_nameController, 'Nama Lengkap', Icons.person),
                const SizedBox(height: 12),
                _buildTextField(_emailController, 'Email', Icons.email),
                const SizedBox(height: 12),
                _buildTextField(_phoneController, 'Nomor Telepon', Icons.phone),
                const SizedBox(height: 12),
                _buildTextField(_companyController, 'Perusahaan', Icons.business),
                const SizedBox(height: 12),
                _buildTextField(_addressController, 'Alamat', Icons.location_on),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal', style: GoogleFonts.inter(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                authProvider.updateProfile(
                  fullName: _nameController.text,
                  email: _emailController.text,
                  phoneNumber: _phoneController.text,
                  companyName: _companyController.text,
                  address: _addressController.text,
                );
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Profil berhasil diperbaharui!')),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0F172A),
            ),
            child: Text('Simpan', style: GoogleFonts.inter(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label, IconData icon) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, size: 20),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label tidak boleh kosong';
        }
        return null;
      },
    );
  }
}
