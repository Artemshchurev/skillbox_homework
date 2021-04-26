import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/services/auth_service.dart';
import 'package:firebase_project/views/todos_view.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  static const String routeName = '/profile';
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Профиль'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 100,
            ),
            ListTile(
              leading: Text('ToDos'),
              onTap: () {
                Navigator.of(context).pushNamed(TodosView.routeName);
              },
            ),
            ListTile(
              leading: Text('Выйти'),
              onTap: _authService.signOut,
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30),
            child: Container(
              color: Colors.grey,
              child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Icon(
                  Icons.person_rounded,
                  color: Colors.black,
                  size: 30,
                ),
              ),
            ),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 5),
              child: RichText(
                textDirection: TextDirection.ltr,
                text: TextSpan(
                  text: 'Email: ',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                  children: <TextSpan>[
                    TextSpan(
                      text: _authService.getUserEmail(),
                      style: TextStyle(fontWeight: FontWeight.normal)
                    ),
                  ],
                )
              ),
            ),
          )
        ],
      ),
    );
  }
}
