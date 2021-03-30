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
      backgroundColor: Colors.grey.shade300,
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
              if (snapshot.hasError)
                return Center(
                  child: Text('Контент временно недоступен')
                );

              return CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.all(5),
                    sliver: SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: isGrid ? 2 : 1,
                        childAspectRatio: isGrid ? 1 : 1.7
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          HotelPreview hotel = snapshot.data[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            elevation: 7,
                            clipBehavior: Clip.antiAlias,
                            child: Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: AssetImage('assets/images/${hotel.poster}'),
                                        fit: BoxFit.cover
                                      )
                                    ),
                                  )
                                ),
                                if (isGrid)
                                  Container(
                                    height: 40,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 5),
                                      child: Text(
                                        hotel.name,
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis
                                      ),
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
                                              'name': hotel.name,
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
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 8),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 5),
                                            child: Text(
                                              hotel.name,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              // overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(right: 10),
                                          child: Container(
                                            width: 120,
                                            child: RaisedButton(
                                              onPressed: () {
                                                Navigator.of(context).pushNamed(
                                                    HotelView.routeName,
                                                    arguments: {
                                                      'uuid': hotel.uuid,
                                                      'name': hotel.name,
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
                                        ),
                                      ],
                                    ),
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
