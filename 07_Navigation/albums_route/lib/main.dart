import 'dart:convert';

import 'package:albums_route/routes.dart';
import 'package:albums_route/screens/albums_screen.dart';
import 'package:albums_route/screens/home_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'fetch_file.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FluroRouter router;

  MyApp() {
    router = FluroRouter();
    Routes.setupRouter(router);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
      onGenerateRoute: router.generator,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    fetchFileFromAssets('assets/artists.json').then((String value) {
      print(jsonDecode(value));
    });
    
    return Scaffold(
      appBar: AppBar(
        title: Text('Routes'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            GestureDetector(
              child: ListTile(title: Text('Home')),
              onTap: () {
                Navigator.of(context).pushNamed(HomeScreen.routeName);
              },
            ),
            GestureDetector(
              child: ListTile(title: Text('Albums')),
              onTap: () {
                Navigator.of(context).pushNamed(AlbumsScreen.routeName);
              },
            )
          ],
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Home page',
            ),
          ],
        ),
      ),
    );
  }
}
