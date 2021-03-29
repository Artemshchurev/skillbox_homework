// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hotel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HotelPreview _$HotelPreviewFromJson(Map<String, dynamic> json) {
  return HotelPreview(
    uuid: json['uuid'] as String,
    name: json['name'] as String,
    poster: json['poster'] as String,
  );
}

Map<String, dynamic> _$HotelPreviewToJson(HotelPreview instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'poster': instance.poster,
    };

Hotel _$HotelFromJson(Map<String, dynamic> json) {
  return Hotel(
    uuid: json['uuid'] as String,
    name: json['name'] as String,
    poster: json['poster'] as String,
    address: json['address'] == null
        ? null
        : Address.fromJson(json['address'] as Map<String, dynamic>),
    price: (json['price'] as num)?.toDouble(),
    rating: (json['rating'] as num)?.toDouble(),
    photos: (json['photos'] as List)?.map((e) => e as String)?.toList(),
    services: json['services'] == null
        ? null
        : Services.fromJson(json['services'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$HotelToJson(Hotel instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'poster': instance.poster,
      'address': instance.address?.toJson(),
      'price': instance.price,
      'rating': instance.rating,
      'photos': instance.photos,
      'services': instance.services?.toJson(),
    };

Address _$AddressFromJson(Map<String, dynamic> json) {
  return Address(
    country: json['country'] as String,
    street: json['street'] as String,
    city: json['city'] as String,
    zipCode: json['zip_code'] as int,
    coords: json['coords'] == null
        ? null
        : Coords.fromJson(json['coords'] as Map<String, dynamic>),
    services: json['services'] == null
        ? null
        : Services.fromJson(json['services'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$AddressToJson(Address instance) => <String, dynamic>{
      'country': instance.country,
      'street': instance.street,
      'city': instance.city,
      'zip_code': instance.zipCode,
      'coords': instance.coords?.toJson(),
      'services': instance.services?.toJson(),
    };

Coords _$CoordsFromJson(Map<String, dynamic> json) {
  return Coords(
    lat: (json['lat'] as num)?.toDouble(),
    lan: (json['lan'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$CoordsToJson(Coords instance) => <String, dynamic>{
      'lat': instance.lat,
      'lan': instance.lan,
    };

Services _$ServicesFromJson(Map<String, dynamic> json) {
  return Services(
    free: (json['free'] as List)?.map((e) => e as String)?.toList(),
    paid: (json['paid'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$ServicesToJson(Services instance) => <String, dynamic>{
      'free': instance.free,
      'paid': instance.paid,
    };
