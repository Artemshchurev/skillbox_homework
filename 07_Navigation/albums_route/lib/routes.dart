import 'dart:ffi';

import 'package:albums_route/screens/albums_screen.dart';
import 'package:albums_route/screens/artist_screen.dart';
import 'package:albums_route/screens/home_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routes {
    static void setupRouter(FluroRouter router) {
    router.define(HomeScreen.routeName, handler: Handler(handlerFunc: (BuildContext context, Map<String,dynamic> params) {
      return HomeScreen();
    }));

    router.define(AlbumsScreen.routeName, handler: Handler(handlerFunc: (BuildContext context, Map<String,dynamic> params) {
      return AlbumsScreen();
    }));
    
    router.define('${ArtistScreen.routeName}/:link', handler: Handler( handlerFunc: (BuildContext context, Map<String,dynamic> params) {
      print(params);
      return ArtistScreen(link: params['link'][0]);
    }));
  }
}