import 'dart:ffi';

import 'package:albums_route/screens/albums_screen.dart';
import 'package:albums_route/screens/artist_screen.dart';
import 'package:albums_route/screens/home_screen.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';

class Routes {
  static void setupRouter(FluroRouter router) {
    router.define(HomeScreen.routeName, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return HomeScreen();
    }));

    router.define(AlbumsScreen.routeName, handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return AlbumsScreen();
    }));

    router.define('${ArtistScreen.routeName}/:link', handler: Handler(
        handlerFunc: (BuildContext context, Map<String, dynamic> params) {
      return ArtistScreen(link: params['link'][0]);
    }), transitionBuilder: (context, animation, secondaryAnimation, child) {
      Offset begin = Offset(0.0, 1.0);
      Offset end = Offset.zero;
      Cubic curve = Curves.easeIn;

      Tween<Offset> tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
    transitionDuration: Duration(milliseconds: 2000));
  }
}
