import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  String? _userToken;
  bool _rememberMe = false;
  String? _verificationPhone;

  // Getters
  bool get isLoading => _isLoading;
  String? get error => _error;
  String? get userToken => _userToken;
  bool get rememberMe => _rememberMe;
  String? get verificationPhone => _verificationPhone;

  // OTP Verification Method
  Future<bool> verifyOTP({
    required String phoneNumber,
    required String otp,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Static verification - OTP 1234 is valid
      if (otp == '1234') {
        // Successful verification
        _userToken = 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}';
        _verificationPhone = phoneNumber;

        // Save login state
        await _saveLoginState();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        // Failed verification
        _error = 'Invalid OTP. Please try again.';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Verification failed. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Send OTP Method
  Future<bool> sendOTP({required String phoneNumber}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 1));

      // Validate phone number (basic validation)
      if (phoneNumber.length >= 10) {
        _verificationPhone = phoneNumber;
        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Invalid phone number';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Failed to send OTP. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  // Sign Up Method
  Future<bool> signUp({
    required String phoneNumber,
    required String name,
    required String email,
    required String password,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      // Simulate API call delay
      await Future.delayed(const Duration(seconds: 2));

      // Basic validation
      if (phoneNumber.length >= 10 &&
          name.isNotEmpty &&
          email.isNotEmpty &&
          password.length >= 6) {

        // Successful signup
        _userToken = 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}';
        _verificationPhone = phoneNumber;

        // Save login state
        await _saveLoginState();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Please fill all fields correctly';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Sign up failed. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<bool> login({
    required String phone,
    required String password,
    required bool rememberMe,
  }) async {
    _isLoading = true;
    _error = null;
    notifyListeners();

    try {
      await Future.delayed(const Duration(seconds: 2));

      if (phone.length == 10 && password.length >= 6) {
        _userToken = 'mock_jwt_token_${DateTime.now().millisecondsSinceEpoch}';

        if (rememberMe) {
          await _saveCredentials(phone, password);
        } else {
          await _clearCredentials();
        }

        await _saveLoginState();

        _isLoading = false;
        notifyListeners();
        return true;
      } else {
        _error = 'Invalid phone number or password';
        _isLoading = false;
        notifyListeners();
        return false;
      }
    } catch (e) {
      _error = 'Login failed. Please try again.';
      _isLoading = false;
      notifyListeners();
      return false;
    }
  }

  Future<void> logout() async {
    _userToken = null;
    _isLoading = false;
    _error = null;
    _verificationPhone = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userToken');
    await prefs.remove('rememberMe');

    notifyListeners();
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('userToken');
    final shouldRemember = prefs.getBool('rememberMe') ?? false;

    if (token != null && shouldRemember) {
      _userToken = token;
      _rememberMe = true;
      notifyListeners();
    }
  }

  // Private methods for data persistence
  Future<void> _saveCredentials(String phone, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('savedPhone', phone);
    await prefs.setString('savedPassword', password);
    await prefs.setBool('rememberMe', true);
  }

  Future<void> _clearCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('savedPhone');
    await prefs.remove('savedPassword');
    await prefs.setBool('rememberMe', false);
  }

  Future<void> _saveLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    if (_userToken != null) {
      await prefs.setString('userToken', _userToken!);
    }
  }

  Future<Map<String, String>?> getSavedCredentials() async {
    final prefs = await SharedPreferences.getInstance();
    final phone = prefs.getString('savedPhone');
    final password = prefs.getString('savedPassword');

    if (phone != null && password != null) {
      return {'phone': phone, 'password': password};
    }
    return null;
  }

  // Clear error
  void clearError() {
    _error = null;
    notifyListeners();
  }
}