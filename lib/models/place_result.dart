// To parse this JSON data, do
//
//     final placeResult = placeResultFromJson(jsonString);

import 'dart:convert';

PlaceResult placeResultFromJson(String str) => PlaceResult.fromJson(json.decode(str));

String placeResultToJson(PlaceResult data) => json.encode(data.toJson());

class PlaceResult {
  PlaceResult({
    this.results,
    this.status,
  });

  List<Result> results;
  String status;

  factory PlaceResult.fromJson(Map<String, dynamic> json) => PlaceResult(
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
    "status": status,
  };
}

class Result {
  Result({
    this.geometry,
    this.icon,
    this.iconMaskBaseUri,
    this.name,
    this.openingHours,
    this.placeId,
    this.priceLevel,
    this.rating,
    this.reference,
    this.types,
    this.userRatingsTotal,
    this.vicinity,
    this.permanentlyClosed,
  });

  Geometry geometry;
  String icon;
  String iconMaskBaseUri;
  String name;
  OpeningHours openingHours;
  String placeId;
  int priceLevel;
  double rating;
  String reference;
  List<Type> types;
  int userRatingsTotal;
  String vicinity;
  bool permanentlyClosed;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    geometry: Geometry.fromJson(json["geometry"]),
    icon: json["icon"],
    iconMaskBaseUri: json["icon_mask_base_uri"],
    name: json["name"],
    openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
    placeId: json["place_id"],
    priceLevel: json["price_level"] == null ? null : json["price_level"],
    rating: json["rating"].toDouble(),
    reference: json["reference"],
    userRatingsTotal: json["user_ratings_total"],
    vicinity: json["vicinity"],
    permanentlyClosed: json["permanently_closed"] == null ? null : json["permanently_closed"],
  );

  Map<String, dynamic> toJson() => {
    "geometry": geometry.toJson(),
    "icon": icon,
    "icon_mask_base_uri": iconMaskBaseUri,
    "name": name,
    "opening_hours": openingHours == null ? null : openingHours.toJson(),
    "place_id": placeId,
    "price_level": priceLevel == null ? null : priceLevel,
    "rating": rating,
    "reference": reference,
    "user_ratings_total": userRatingsTotal,
    "vicinity": vicinity,
    "permanently_closed": permanentlyClosed == null ? null : permanentlyClosed,
  };
}

class Geometry {
  Geometry({
    this.location,
  });

  Location location;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: Location.fromJson(json["location"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location.toJson(),
  };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"].toDouble(),
    lng: json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat,
    "lng": lng,
  };
}

class OpeningHours {
  OpeningHours({
    this.openNow,
  });

  bool openNow;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
    openNow: json["open_now"],
  );

  Map<String, dynamic> toJson() => {
    "open_now": openNow,
  };
}

