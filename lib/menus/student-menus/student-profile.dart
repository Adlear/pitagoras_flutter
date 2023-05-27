import 'package:flutter/material.dart';

import '../../user_provider.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    final userEmail = userProvider.userEmail;
    final userPassword = userProvider.userPassword;

    return Scaffold(

      body: Center(
        child: Container(
          width: 500,
          child: FutureBuilder<DocumentSnapshot>(
            future: FirebaseFirestore.instance
                .collection('users')
                .where('user_mail', isEqualTo: userEmail)
                .where('password', isEqualTo: userPassword)
                .limit(1)
                .get()
                .then((snapshot) => snapshot.docs.first),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData) {
                return Text('No user data found.');
              }

              final userData = snapshot.data!.data() as Map<String, dynamic>;

              final userId = userData['user_id'];
              final userName = userData['user_name'];
              final userLastName = userData['user_last_name'];
              final userEmail = userData['user_mail'];
              final userBirthday = userData['user_birthday'];

              return SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/user.png',
                      width: 200,
                      height: 200,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'ID: $userId',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Name: $userName',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Last Name: $userLastName',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Email: $userEmail',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Birthday: $userBirthday',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
