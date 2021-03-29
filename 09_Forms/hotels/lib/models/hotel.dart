import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'hotel.g.dart';

@JsonSerializable(explicitToJson: true)
class HotelPreview {
  final String uuid;
  final String name;
  final String poster;

  HotelPreview({this.uuid, this.name, this.poster});

  factory HotelPreview.fromJson(Map<String, dynamic> json) =>
      _$HotelPreviewFromJson(json);
  Map<String, dynamic> toJson() => _$HotelPreviewToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Hotel {
  final String uuid;
  final String name;
  final String poster;
  final Address address;
  final double price;
  final double rating;
  final List<String> photos;
  final Services services;

  Hotel({this.uuid, this.name, this.poster, this.address, this.price, this.rating, this.photos, this.services});

  factory Hotel.fromJson(Map<String, dynamic> json) =>
      _$HotelFromJson(json);
  Map<String, dynamic> toJson() => _$HotelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Address {
  final String country;
  final String street;
  final String city;
  @JsonKey(name: 'zip_code')
  final int zipCode;
  final Coords coords;
  final Services services;

  Address({this.country, this.street, this.city, this.zipCode, this.coords, this.services});

  factory Address.fromJson(Map<String, dynamic> json) =>
      _$AddressFromJson(json);
  Map<String, dynamic> toJson() => _$AddressToJson(this);
}

@JsonSerializable()
class Coords {
  final double lat;
  final double lan;

  Coords({this.lat, this.lan});

  factory Coords.fromJson(Map<String, dynamic> json) =>
      _$CoordsFromJson(json);
  Map<String, dynamic> toJson() => _$CoordsToJson(this);
}

@JsonSerializable(explicitToJson: true)
class Services {
  final List<String> free;
  final List<String> paid;

  Services({this.free, this.paid});

  factory Services.fromJson(Map<String, dynamic> json) =>
      _$ServicesFromJson(json);
  Map<String, dynamic> toJson() => _$ServicesToJson(this);
}