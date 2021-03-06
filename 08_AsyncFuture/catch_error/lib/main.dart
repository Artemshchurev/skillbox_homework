import 'package:catch_error/fetch_file.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<String> _future;

  @override
  void initState() {
    _future = fetchFileFromAssets('assets/somefile.txt');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catch error'),
      ),
      body: FutureBuilder<String>(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          print(snapshot.connectionState);
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(
                child: Text('NONE'),
              );
              break;
            case ConnectionState.waiting:
              return Center(child: CircularProgressIndicator());
              break;
            case ConnectionState.done:
              return SingleChildScrollView(child: Text(snapshot.data));
              break;
            default:
              return SingleChildScrollView(
                child: Text('Default'),
              );
          }
        },
      ),
    );
  }
}
