import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'login_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  TextEditingController _citizenIdController = TextEditingController();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _userLastNameController = TextEditingController();
  TextEditingController _userMailController = TextEditingController();
  TextEditingController _userBirthdayController = TextEditingController();
  TextEditingController _userPasswordController = TextEditingController();
  String _selectedUserRole = "student";

  void _clearFormFields() {
    _citizenIdController.clear();
    _userNameController.clear();
    _userLastNameController.clear();
    _userMailController.clear();
    _userBirthdayController.clear();
    _userPasswordController.clear();

  }

  void validateUser(){
    _clearFormFields();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Bienvenido!'),
        content: Text('Registro Exitoso'),
        actions: [
          TextButton(
            child: Text('OK'),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
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
    Image.asset('assets/register.png', height: 200), // Replace with your header image asset
    SizedBox(height: 16.0),
    Text(
    'Pitágoras - Registro',
    style: TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    ),
    ),
    SizedBox(height: 32.0),
    TextField(
    controller: _citizenIdController,
    decoration: InputDecoration(
    labelText: 'Cédula de Ciudadanía',
    ),
    ),
    SizedBox(height: 16.0),
    TextField(
    controller: _userNameController,
    decoration: InputDecoration(
    labelText: 'Nombre',
    ),
    ),
    SizedBox(height: 16.0),
    TextField(
    controller: _userLastNameController,
    decoration: InputDecoration(
    labelText: 'Apellido',
    ),
    ),
    SizedBox(height: 16.0),
    TextField(
    controller: _userMailController,
    decoration: InputDecoration(
    labelText: 'Cooreo-electrónico',
    ),
    ),
    SizedBox(height: 16.0),
    TextField(
    controller: _userPasswordController,
    obscureText: true,
    decoration: InputDecoration(
    labelText: 'Contraseña',
    ),
    ),
    SizedBox(height: 32.0),
    ElevatedButton(
    onPressed: () {
    // Perform registration logic here
    String citizenId = _citizenIdController.text;
    String userName = _userNameController.text;
    String userLastName = _userLastNameController.text;
    String userMail = _userMailController.text;
    String userBirthday = _userBirthdayController.text;
    String userPassword = _userPasswordController.text;
    String userRole = _selectedUserRole;
    CollectionReference collRef = FirebaseFirestore.instance.collection('users');
    collRef.add({
      'user_id': citizenId,
      'user_name':userName,
      'user_last_name': userLastName,
      'user_mail': userMail,
      'user_birthday': '00-00-00',
      'password': userPassword,
      'role': 'student',

    });
  //Se valida usuario
    validateUser();
    },
      child: Text('Registrar'),
    ),
      SizedBox(height: 16.0),
      TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => LoginPage(),
            ),
          );
        },
        child: Text('Ya tengo una Cuenta'),
      ),
    ],
    ),
        ),
        ),
        ),
    );
  }
}

