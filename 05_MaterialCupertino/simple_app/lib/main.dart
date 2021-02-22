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

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  final List<Map<String, dynamic>> bottomBarItems = [
    {'title': 'Photo', 'icon': Icons.home},
    {'title': 'Chat', 'icon': Icons.chat},
    {'title': 'Albums', 'icon': Icons.album},
  ];
  final List<Map<String, dynamic>> drawerItems = [
    {'title': 'Home', 'icon': Icons.home},
    {'title': 'Profile', 'icon': Icons.person_rounded},
    {'title': 'Images', 'icon': Icons.album},
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
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                DrawerHeader(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundColor: Colors.red,
                    backgroundImage: NetworkImage(
                      'https://picsum.photos/200/200'
                    ),
                  ),
                ),
                Column(
                  children: drawerItems.map((item) {
                    return ListTile(
                      leading: Icon(item['icon']),
                      title: Text(item['title']),
                      trailing: Icon(Icons.chevron_right),
                    );
                  }).toList(),
                ),
              ],
            ),
            Padding(
                padding: EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(onPressed: () {}, child: Text('Вход'),),
                  RaisedButton(onPressed: () {}, child: Text('Регистрация'))
                ],
              ),
            ),
          ],
        ),
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
        items: bottomBarItems.map((item) => BottomNavigationBarItem(
            icon: Icon(item['icon']), label: item['title'])).toList(),
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
