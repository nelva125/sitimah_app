import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      
      // Simulate network delay for effect
      await Future.delayed(const Duration(seconds: 1));
      
      if (!mounted) return;
      
      final success = Provider.of<AuthProvider>(context, listen: false)
          .login(_userController.text, _passController.text);
          
      setState(() => _isLoading = false);
      
      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username atau Password salah!')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo Placeholder
              Container(
                width: 80,
                height: 80,
                decoration: const BoxDecoration(
                  color: Color(0xFF2563EB), // Blue 600
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.token, color: Colors.white, size: 40),
              ),
              const SizedBox(height: 24),
              const Text(
                'siTIMAH',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Masuk untuk melanjutkan',
                style: TextStyle(color: Color(0xFF64748B)),
              ),
              const SizedBox(height: 48),
              
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text('Username', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _userController,
                      decoration: const InputDecoration(hintText: 'Masukkan username'),
                      validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 24),
                    
                    const Text('Password', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                    const SizedBox(height: 8),
                    TextFormField(
                      controller: _passController,
                      obscureText: true,
                      decoration: const InputDecoration(hintText: 'Masukkan password'),
                      validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    const SizedBox(height: 32),
                    
                    SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _handleLogin,
                        child: _isLoading 
                          ? const CircularProgressIndicator(color: Colors.white)
                          : const Text('Masuk', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              const Text('Demo: username: admin, password: admin123', 
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }
}
