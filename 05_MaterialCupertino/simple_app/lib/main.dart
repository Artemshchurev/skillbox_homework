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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with SingleTickerProviderStateMixin {

  final List<Map<String,dynamic>> bottomBarItems = [
    {'title': 'Photo', 'icon': Icons.home},
    {'title': 'Chat', 'icon': Icons.chat},
    {'title': 'Albums', 'icon': Icons.album},
  ];
  bool _isPaid = false;
  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this, initialIndex: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            child: Center(
               child: _isPaid ? Text('Заказ успешно оплачен') : null,
            ),
          ),
          Container(
            color: Colors.purple,
          ),
          Container(
            color: Colors.green,
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _tabController.index,
        onTap: (int index) {
          setState(() {
            _tabController.index = index;
          });
        },
        items: bottomBarItems.map((item) => BottomNavigationBarItem(icon: Icon(item['icon']), label: item['title'])).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add
        ),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 200,
                color: Colors.white,
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(Icons.payment),
                      title: const Text('Сумма'),
                      trailing: const Text('200 руб'),
                    ),
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          _isPaid = true;
                        });
                      },
                      child: Text('Оплатить'),
                    )
                  ],
                ),
              );
            }
          );
        },
      ),
    );
  }
}
