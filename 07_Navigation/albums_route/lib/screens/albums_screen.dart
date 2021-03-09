import 'package:flutter/material.dart';

class AlbumsScreen extends StatelessWidget {
  static String routeName = '/albums';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Albums'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Albums'),
          ],
        ),
      ),
    );
  }
}
