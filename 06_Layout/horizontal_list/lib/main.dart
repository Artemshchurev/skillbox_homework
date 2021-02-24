import 'package:flutter/material.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Color> _colors = [
    Colors.green.shade50,
    Colors.green.shade100,
    Colors.green.shade200,
    Colors.green.shade300,
    Colors.green.shade400,
    Colors.green.shade500,
    Colors.green.shade600,
    Colors.green.shade700,
    Colors.green.shade800,
    Colors.green.shade900,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Horizontal list'),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          bool _isHorizontal = constraints.constrainWidth() > 500;

          return Container(
            height: 170,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ..._colors.map((color) => Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    color: color,
                    width: 150,
                    height: 150,
                  ),
                ))
              ],
            ),
          );
        },
      )
    );
  }
}
