import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      home: MyHomePage(title: 'Load file'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _myController = TextEditingController();
  String _fileContent = '';

  @override
  void dispose() {
    _myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      width: 200,
                      child: TextField(
                        controller: _myController,
                        style: TextStyle(),
                        decoration: InputDecoration(
                          border: OutlineInputBorder()
                        ),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => _loadFile(),
                    child: Text('Найти'),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(_fileContent),
            ),
          ],
        ),
      )
    );
  }

  void _loadFile()  {
    rootBundle
        .loadString(_myController.text)
        .then((value) {
          setState(() {
            _fileContent = value;
          });
    }).catchError((error) {
      setState(() {
        _fileContent = 'Файл не найден';
      });
    });

  }
}
