import 'dart:convert';

import 'package:flutter/services.dart';

class ArtistsRepo {

  static Future<List<dynamic>> fetchArtists() async {
    rootBundle.loadString('assets/artists.json').then((file) {
      return jsonDecode(file);
    });
  }
}
