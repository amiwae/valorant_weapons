import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorantweapons/login/signuppage.dart';
import 'package:valorantweapons/login/user_model.dart';
import 'package:valorantweapons/login/user_repository.dart';

import '../main/navbar.dart';
import 'crypto_helper.dart';


class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final UserRepository _userRepository = UserRepository();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  late SharedPreferences logindata;
  late bool newuser;

  void initState(){
    super.initState();
    check_if_already_login();
  }
  void check_if_already_login() async{
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool("login")?? true);
    print(newuser);
    if(newuser==false){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
        return NavBar();
      }));
    }
  }

  @override //biar inputan ilang
  void dispose(){
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              SizedBox(height: 200,),
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
                        Text("Log In",
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
                        SizedBox(height: 30,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 70.0),
                          child: ElevatedButton(
                            onPressed: () => _login(),
                            style: ElevatedButton.styleFrom(
                              minimumSize: Size.fromHeight(40),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Text('Log In'),
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have account?"),
                            TextButton(
                              onPressed: () => _goToSignupScreen(),
                              child: Text('Sign Up'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 250,)
            ],
          ),
        ),
      ),
    );
  }


  Future<void> _login() async {
    final String username = _usernameController.text.trim();
    final String password = _passwordController.text.trim();

    if (username.isNotEmpty && password.isNotEmpty) {
      User? user = await _userRepository.getUserByUsername(username);

      if (user != null) {
        String encryptedPassword = CryptoHelper.encrypt(password);

        print('Encrypted Password: $encryptedPassword');
        if (user.password == encryptedPassword) {
          print('Login successful');

          // Simpan informasi login ke SharedPreferences
          logindata.setBool("login", false);
          logindata.setString("username", user.username);

          // Menampilkan Snackbar untuk login berhasil
          showSnackBar('Login successful', Colors.green);

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => NavBar()),
          );
        } else {
          // Menampilkan Snackbar untuk password tidak valid
          showSnackBar('Invalid password', Colors.red);
          print('Invalid password');
        }
      } else {
        // Menampilkan Snackbar untuk user tidak ditemukan
        showSnackBar('User not found', Colors.red);
        print('User not found');
      }
    } else {
      // Menampilkan Snackbar untuk memasukkan username dan password
      showSnackBar('Please enter username and password', Colors.red);
      print('Please enter username and password');
    }
  }

  void showSnackBar(String text, Color color) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _goToSignupScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignupScreen()),
    );
  }
}