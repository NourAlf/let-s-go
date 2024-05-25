import 'package:flutter/material.dart';
import 'package:letsgohome/screens/login_page.dart';

class ResetPassword extends StatefulWidget {


  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  String _passwordError = '';
  String _confirmPasswordError = '';

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _isPasswordValid(String password) {
    // Password validation rules
    if (password.isEmpty) {
      setState(() {
        _passwordError = 'Please enter a password';
      });
      return false;
    } else if (password.length < 8) {
      setState(() {
        _passwordError = 'Password must be at least 8 characters long';
      });
      return false;
    }
    setState(() {
      _passwordError = '';
    });
    return true;
  }
  bool _doPasswordsMatch(String password, String confirmPassword) {
    if (password != confirmPassword) {
      _confirmPasswordError = 'Passwords do not match';
      return false;
    }
    _confirmPasswordError = '';
    return true;
  }

  void _savePassword() {
    final String password = _passwordController.text;
    final String confirmPassword = _confirmPasswordController.text;

    if (_isPasswordValid(password) && _doPasswordsMatch(password, confirmPassword)) {
      // Save the password or perform further actions
      print('Password saved: $password');
      // Navigator.of(context).push(MaterialPageRoute(builder: (context) => HomePage()));
    } else {
      // Handle password validation error or display an error message
      print('Password validation failed');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: 390,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF5C955D),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
            ),
          ),
          Positioned(
            top: 20,
            left: 20,
            child: IconButton(
              onPressed: () {
                // Navigator.of(context).push(
                //   MaterialPageRoute(builder: (context) => HomePage()),
                // );
              },
              icon: const Icon(Icons.arrow_back),
            ),
          ),
          Positioned(
            top: 20,
            right: 20,
            child: Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset('assets/logo.png',fit: BoxFit.contain ,),
              // Add your content for the small container here
            ),
          ),
          const Positioned(
            top: 130,
            left: 27,
            child: Text(
              "Create New Password",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const Positioned(
            top: 160,
            left: 27,
            child: Text(
              "Please enter a new password and rewrite it to confirm",
              style: TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
            ),
          ),
          Center(
            child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Color(0xffE2D4B0),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(
                  'assets/verify.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            left: 27,
            right: 27,
            child: Center(
              child: Container(
                width: 300,
                height: 300,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                    padding: const EdgeInsets.all(10),
                    margin: const EdgeInsets.only(top: 20),
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(


                      controller: _passwordController,
                      obscureText: _isPasswordVisible,
                      onChanged: (value) {
                        _isPasswordValid(value);
                      },
                      decoration: InputDecoration(
                        hintText: 'New Password',
                        border: InputBorder.none,
                        hintStyle: const TextStyle(color: Colors.grey),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                    if (_passwordError.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _passwordError,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      margin: const EdgeInsets.only(top: 20),
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _confirmPasswordController,
                        obscureText: !_isConfirmPasswordVisible,
                        onChanged: (value) {
                          _doPasswordsMatch(_passwordController.text, value);
                        },
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          hintStyle: const TextStyle(color: Colors.grey),
                          border: InputBorder.none,
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                              });
                            },
                            child: Icon(
                              _isConfirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                            ),
                          ),
                        ),
                      ),),
                    if (_confirmPasswordError.isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(left: 30),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          _confirmPasswordError,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    Container(
                      margin: const EdgeInsets.only(top: 20, bottom: 20),
                      width: 250,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF5C955D),
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        border: Border.all(
                          color: Colors.green,
                          width: 2,
                        ),
                      ),
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) =>  LoginPage()),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF5C955D),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          "Save",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: const Center(
                        child: Text(
                          "Change Password",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xFF5C955D),
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}