import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valorantweapons/main/halaman_utama.dart';
import 'package:valorantweapons/main/menu_saran.dart';
import 'package:valorantweapons/main/myprofile.dart';

class NavBar extends StatefulWidget {
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late SharedPreferences logindata;
  late String username;
  @override
  void initState(){
    super.initState();
    initial();
  }

  void initial() async{
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString("username")!;
    });
  }

  int _selectedIndex = 0;
  final List<Widget> _page = [
    HalamanUtama(),
    MyProfile(),
    MenuSaran()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(

        child: _page.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: Container(

        child: BottomNavigationBar(
          backgroundColor: Colors.black,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.message),
              label: 'Impression',
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white60,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
