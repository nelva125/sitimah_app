import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import '../models/tin_transaction.dart';
import '../providers/transaction_provider.dart';
import '../providers/auth_provider.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({Key? key}) : super(key: key);

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _priceController = TextEditingController();
  final _supplierController = TextEditingController();
  final _qualityController = TextEditingController();
  final _notesController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _amountController.dispose();
    _priceController.dispose();
    _supplierController.dispose();
    _qualityController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('siTIMAH', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => Provider.of<AuthProvider>(context, listen: false).logout(),
            tooltip: 'Keluar',
          ),
          const SizedBox(width: 8),
          const Center(child: Text('Keluar', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14))),
          const SizedBox(width: 16),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Card(
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16), side: const BorderSide(color: Color(0xFFE2E8F0))),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Pencatatan Pembelian Timah', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  const SizedBox(height: 4),
                  const Text('Tambahkan data pembelian timah baru', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 24),

                  _buildLabel('Tanggal *'),
                  InkWell(
                    onTap: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      );
                      if (picked != null) setState(() => _selectedDate = picked);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          Text(DateFormat('dd/MM/yyyy').format(_selectedDate)),
                          const Spacer(),
                          const Icon(Icons.calendar_today_outlined, size: 20, color: Colors.grey),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  _buildLabel('Pemasok *'),
                  TextFormField(
                    controller: _supplierController,
                    decoration: const InputDecoration(hintText: 'Nama pemasok'),
                    validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  const SizedBox(height: 16),

                  _buildLabel('Jumlah (Kg) *'),
                  TextFormField(
                    controller: _amountController,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    decoration: const InputDecoration(hintText: '0.00'),
                    validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  const SizedBox(height: 16),

                  _buildLabel('Harga per Kg (Rp) *'),
                  TextFormField(
                    controller: _priceController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(hintText: '0.00'),
                    validator: (v) => v!.isEmpty ? 'Wajib diisi' : null,
                  ),
                  const SizedBox(height: 16),

                  _buildLabel('Kualitas/Grade'),
                  TextFormField(
                    controller: _qualityController,
                    decoration: const InputDecoration(hintText: 'Contoh: Grade A, Grade B'),
                  ),
                  const SizedBox(height: 16),

                  _buildLabel('Catatan'),
                  TextFormField(
                    controller: _notesController,
                    decoration: const InputDecoration(hintText: 'Catatan tambahan'),
                  ),
                  const SizedBox(height: 32),

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _saveTransaction,
                      child: const Text('Simpan Pembelian', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0, left: 4.0),
      child: Text(text, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
    );
  }

  void _saveTransaction() {
    if (_formKey.currentState!.validate()) {
      final transaction = TinTransaction(
        date: _selectedDate,
        supplierName: _supplierController.text,
        weightKg: double.parse(_amountController.text),
        pricePerKg: double.parse(_priceController.text),
        quality: _qualityController.text,
        notes: _notesController.text,
      );

      Provider.of<TransactionProvider>(context, listen: false).addTransaction(transaction);

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Data berhasil disimpan!')));
      
      // Reset form (keep date)
      _supplierController.clear();
      _amountController.clear();
      _priceController.clear();
      _qualityController.clear();
      _notesController.clear();
    }
  }
}
