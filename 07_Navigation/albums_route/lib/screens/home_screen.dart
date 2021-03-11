import 'package:flutter/material.dart';

import 'albums_screen.dart';

class HomeScreen extends StatelessWidget {
  static String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: ListTile(
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: Theme.of(context).accentColor
                  ),
                ),
              ),
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
