import 'package:flutter/material.dart';
import 'package:pitagoras/menus/student-menus/home-page.dart';
import 'package:pitagoras/menus/student-menus/student-profile.dart';
import 'package:pitagoras/user-auth/login_page.dart';
import 'package:provider/provider.dart';
import 'package:pitagoras/user_provider.dart';


class DashboardPage extends StatefulWidget {

  @override

  _DashboardPageState createState() => _DashboardPageState();

}

class _DashboardPageState extends State<DashboardPage> {

  int _selectedIndex = 0;


  static final List<Widget> _pages = <Widget>[

    HomePage(),
   StudentProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.blue,
      ),
    );
  }
}


