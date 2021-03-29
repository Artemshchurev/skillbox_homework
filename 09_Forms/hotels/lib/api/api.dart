import 'dart:convert';

import '../models/hotel.dart';
import 'package:http/http.dart' as http;

Future<List<HotelPreview>> fetchHotels() async {
  var response = await http.get(Uri.parse('https://run.mocky.io/v3/ac888dc5-d193-4700-b12c-abb43e289301'));
  return jsonDecode(response.body)
      .map<HotelPreview>((hotel) => HotelPreview.fromJson(hotel))
      .toList();
}

Future<Hotel> fetchHotel(String id) async {
  var response = await http.get(Uri.parse('https://run.mocky.io/v3/$id'));
  if (jsonDecode(response.body)['message'] != null) {
    throw Exception(jsonDecode(response.body)['message']);
  }
  return Hotel.fromJson(jsonDecode(response.body));
}