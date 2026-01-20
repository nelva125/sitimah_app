import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  String? _username; // Used for login

  // Profile Data
  String _fullName = 'Admin User';
  String _email = 'email@example.com';
  String _phoneNumber = '08xxxxxxxxxxx';
  String _companyName = 'Nama perusahaan';
  String _address = 'Alamat lengkap';

  bool get isLoggedIn => _isLoggedIn;
  String? get username => _username;
  
  String get fullName => _fullName;
  String get email => _email;
  String get phoneNumber => _phoneNumber;
  String get companyName => _companyName;
  String get address => _address;

  bool login(String user, String pass) {
    // Mock Logic as per Screenshot 1
    if (user == 'admin' && pass == 'admin123') {
      _isLoggedIn = true;
      _username = user;
      // In a real app, we would fetch profile data here
      notifyListeners();
      return true;
    }
    return false;
  }

  void logout() {
    _isLoggedIn = false;
    _username = null;
    notifyListeners();
  }

  void updateProfile({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String companyName,
    required String address,
  }) {
    _fullName = fullName;
    _email = email;
    _phoneNumber = phoneNumber;
    _companyName = companyName;
    _address = address;
    notifyListeners();
  }
}
