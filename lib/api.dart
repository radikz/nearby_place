import 'package:http/http.dart' as http;
import 'package:near_place/models/constants.dart';
import 'package:near_place/models/place_result.dart';

class Api{

  Future<PlaceResult> getApi(String keyword) async {
    final latitude = -7.265312;
    final longitude = 112.750325;
    final baseUrl =
        "https://maps.googleapis.com/maps/api/place/nearbysearch/json";

    String url =
        '$baseUrl?key=$API_KEY&location=$latitude,$longitude&radius=$RADIUS&keyword=$keyword';
    print(url);
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return placeResultFromJson(response.body);
    } else {
      throw Exception('An error occurred getting places nearby');
    }
  }
}