import 'package:flutter/material.dart';
import 'package:hotels/api/api.dart';
import 'package:hotels/models/hotel.dart';
import 'package:hotels/views/hotel_view.dart';

class HomeView extends StatefulWidget {
  static String routeName = '/';

  HomeView({Key key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Future<List<HotelPreview>> _fetchHotels;
  bool isGrid = true;

  @override
  void initState() {
    _fetchHotels = fetchHotels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              child: Icon(
                isGrid
                  ? Icons.list
                  : Icons.grid_view
              ),
              onTap: () {
                setState(() {
                  isGrid = !isGrid;
                });
              },
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: _fetchHotels,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
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
              return CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(10),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isGrid ? 2 : 1
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          HotelPreview hotel = snapshot.data[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Container(
                                  height: isGrid ? 110 : 300,
                                  child: Image.asset(
                                    'assets/images/${hotel.poster}',
                                  ),
                                ),
                                if (isGrid)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Text(hotel.name),
                                    ),
                                  ),
                                if (isGrid)
                                  SizedBox(
                                    width: double.infinity,
                                    height: 25,
                                    child: RaisedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            HotelView.routeName,
                                            arguments: {
                                              'uuid': hotel.uuid,
                                            }
                                        );
                                      },
                                      child: Text(
                                        'Подробнее',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      color: Theme.of(context).accentColor,
                                    ),
                                  ),
                                if (!isGrid)
                                  Expanded(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(left: 10),
                                          child: Text(hotel.name),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: RaisedButton(
                                            onPressed: () {
                                              Navigator.of(context).pushNamed(
                                                  HotelView.routeName,
                                                  arguments: {
                                                    'uuid': hotel.uuid,
                                                  }
                                              );
                                            },
                                            child: Text(
                                              'Подробнее',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            color: Theme.of(context).accentColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  )
                              ],
                            ),
                          );
                        },
                        childCount: snapshot.data.length,
                      ),
                    )
                  ),
                ],
              );
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
