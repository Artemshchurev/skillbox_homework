import 'dart:convert';

import 'package:flutter/services.dart';

class ArtistsRepo {

  static Future<List<dynamic>> fetchArtists() async {
    return rootBundle.loadString('assets/artists.json').then((file) {
      return jsonDecode(file);
    });
  }

  static Future<String> fetchAboutArtist(String link) async {
    return rootBundle.loadString('assets/artists.json').then((file) {
      String about = '';
      List<dynamic> data = jsonDecode(file);
      data.forEach((element) {
        if (element['link'] == link) about = element['about'];
      });

      return about;
    });
  }
}
