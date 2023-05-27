import 'package:flutter/material.dart';
import 'package:pitagoras/menus/student-menus/student-dashboard.dart';
import 'registration_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:pitagoras/user_provider.dart';



class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();



  // Validate user during login
  void validateUser(String userMail, String userPassword) async {
    CollectionReference collRef = FirebaseFirestore.instance.collection('users');

    try {
      QuerySnapshot querySnapshot = await collRef
          .where('user_mail', isEqualTo: userMail)
          .where('password', isEqualTo: userPassword)
          .get();

      List<QueryDocumentSnapshot> docs = querySnapshot.docs;

      if (docs.length > 0) {
        // User found, login successful
        print('Login successful');

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Bienvenido!'),
            content: Text('Inicio Exitoso'),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: () =>  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DashboardPage(),
                  ),
                )
              ),
            ],
          ),
        );


        // Perform further actions after successful login
      } else {
        // User not found, login failed
        print('Login failed: User does not exist or invalid credentials');
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Verifica tus datos'),
            actions: [
              TextButton(
                  child: Text('OK'),
                  onPressed: () =>  Navigator.of(context).pop()
              ),
            ],
          ),
        );
        // Display error message or perform other actions for login failure
      }
    } catch (e) {
      print('Error validating user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            width: 500,
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/login_header.png', height: 200), // Replace with your header image asset
                SizedBox(height: 16.0),
                Text(
                  'Pitágoras',
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 32.0),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                  ),
                ),
                SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                  ),
                ),
                SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed: () {
                    // Perform login logic here
                    String email = _emailController.text;
                    String password = _passwordController.text;
                    // Add your login implementation

                    final userProvider = Provider.of<UserProvider>(context, listen: false);
                    userProvider.setUser(email, password);
                    print('Email: $email, Password: $password');



                    validateUser(email, password);

                  },
                  child: Text('Login'),
                ),
                SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationPage(),
                      ),
                    );
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
