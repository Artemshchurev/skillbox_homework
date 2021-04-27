import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_project/views/profile_view.dart';
import 'package:firebase_project/views/signin_view.dart';
import 'package:firebase_project/views/signup_view.dart';
import 'package:firebase_project/views/todo_view.dart';
import 'package:firebase_project/views/todos_view.dart';
import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();

    return MaterialApp(
      title: 'FireBase',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case SignInView.routeName:
            return MaterialPageRoute(builder: (BuildContext context) => SignInView());
          case SignUpView.routeName:
            return MaterialPageRoute(builder: (BuildContext context) => SignUpView());
          case ProfileView.routeName:
            return MaterialPageRoute(builder: (BuildContext context) => ProfileView());
          case TodoView.routeName:
            final args = settings.arguments as Map<String,String>;
            return MaterialPageRoute(builder: (BuildContext context) => TodoView(args['id']));
          case TodosView.routeName:
            return MaterialPageRoute(builder: (BuildContext context) => TodosView());
          default:
            return null;
        }

      },
      home: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Scaffold(
              body: Center(
                child: Text('Error occurred'),
              ),
            );

          if (snapshot.connectionState == ConnectionState.done)
            return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
                if (snapshot.hasData) {
                  return ProfileView();
                }
                return SignInView();
              }
            );

          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
