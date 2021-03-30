import 'package:flutter/material.dart';
import 'package:hotels/views/hotel_view.dart';
import 'package:hotels/views/home_view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomeView(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case HotelView.routeName:
            final args = settings.arguments as Map<String,String>;
            return MaterialPageRoute(builder: (BuildContext context) {
              return HotelView(uuid: args['uuid'], name: args['name'],);
            });
            break;
          default:
            return null;
        }
      },
    );
  }
}
