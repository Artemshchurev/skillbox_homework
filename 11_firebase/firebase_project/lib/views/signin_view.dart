import 'package:firebase_project/services/auth_service.dart';
import 'package:firebase_project/views/signup_view.dart';
import 'package:flutter/material.dart';

class SignInView extends StatefulWidget {
  static const String routeName = '/signin';

  @override
  _SignInViewState createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthService _authService = AuthService();

  void _submit() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      _authService.signIn();
      _formKey.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Вход'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value == '') return 'Заполните email';
                return null;
              },
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: 'Password',
              ),
              validator: (value) {
                if (value == '') return 'Заполните пароль';
                return null;
              },
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text('Войти'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(SignUpView.routeName);
                },
                child: Text('Нет аккаунта?'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
