import 'package:flutter/material.dart';
import 'package:valorantweapons/login/user_model.dart';
import 'package:valorantweapons/login/user_repository.dart';

import 'crypto_helper.dart';
import 'loginpage.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final UserRepository _userRepository = UserRepository();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomCenter,
              colors: [Color(0xFFBD3944), Color(0xFF000000)]
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 140,),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 10,),
                        Image.network(
                            "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Valorant_logo_-_pink_color_version.svg/2560px-Valorant_logo_-_pink_color_version.svg.png",
                            height: 80
                        ),
                        SizedBox(height: 20),
                        Text("Sign Up",
                          style: TextStyle(fontSize: 20),),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: _usernameController,
                          enabled: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Username',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          enabled: true,
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          enabled: true,
                          controller: _confirmPasswordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            hintText: 'Confirm Password',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70.0),
                          child: ElevatedButton(
                            onPressed: () => _signup(),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text('Sign Up'),
                          ),
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 260,)
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _signup() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();
    final String confirmPassword = _confirmPasswordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty) {
      if (password == confirmPassword) {
        String encryptedPassword = CryptoHelper.encrypt(password);

        User newUser = User(username: username, password: encryptedPassword);

        await _userRepository.addUser(newUser);

        print('Sign up successful');

        // Munculkan Snackbar "Sign Up Success"
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Sign Up success'),
            duration: Duration(seconds: 2),
          ),
        );

        // Navigasi langsung ke halaman login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      } else {
        // Munculkan Snackbar "Confirm Password must be the same as the password"
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Confirm Password must be the same as the password'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    } else if (username.isEmpty) {
      // Munculkan Snackbar "Please Input Username"
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please Input Username'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      // Munculkan Snackbar "Please enter password and confirm password"
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter password and confirm password'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}