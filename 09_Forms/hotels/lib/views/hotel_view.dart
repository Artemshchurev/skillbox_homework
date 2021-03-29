import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hotels/api/api.dart';
import 'package:hotels/models/hotel.dart';

class HotelView extends StatefulWidget {
  static const String routeName = '/hotel';
  final String uuid;

  HotelView({Key key, this.uuid}) : super(key: key);

  @override
  _HotelViewState createState() => _HotelViewState(uuid);
}

class _HotelViewState extends State<HotelView> {
  Future<Hotel> _fetchHotel;
  final String uuid;

  _HotelViewState(this.uuid);

  @override
  void initState() {
    super.initState();
    _fetchHotel = fetchHotel(uuid);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: _fetchHotel,
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
              Hotel hotel = snapshot.data;
              return ListView(
                children: [
                  CarouselSlider(
                    options: CarouselOptions(),
                    items: hotel.photos.map((photo) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: Image.asset('assets/images/$photo'),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  text: 'Страна: ',
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: hotel.address.country,
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                    )
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  text: 'Город: ',
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: hotel.address.city,
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                    )
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  text: 'Улица: ',
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: hotel.address.street,
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                    )
                                  ],
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  text: 'Рейтинг: ',
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: hotel.rating.toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold)
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(
                              'Сервисы',
                              style: TextStyle(
                                  fontSize: 20
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            'Платные',
                                            style: TextStyle(
                                                fontSize: 18
                                            ),
                                          ),
                                        ),
                                        ...hotel.services.paid.map((service) => Text(service))
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(3),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(bottom: 5),
                                          child: Text(
                                            'Бесплатно',
                                            style: TextStyle(
                                                fontSize: 18
                                            ),
                                          ),
                                        ),
                                        ...hotel.services.free.map((service) => Text(service))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      )
                  )
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
