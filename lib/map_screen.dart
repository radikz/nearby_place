import 'dart:async';
import 'dart:collection';
import 'package:flutter/widgets.dart';
import 'package:near_place/models/place_result.dart';
import 'package:near_place/place_item.dart';
import 'package:near_place/search_widget.dart';

import 'api.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'models/constants.dart';

class MapScreen extends StatefulWidget {
  @override
  State<MapScreen> createState() {
    return _MapScreen();
  }
}

class _MapScreen extends State<MapScreen> {

  static double latitude = -7.265312;
  static double longitude = 112.750325;

  List<Marker> markers = <Marker>[];
  Set<Circle> _circles = HashSet<Circle>();
  int _circleIdCounter = 1;
  Error error;
  List<Result> places;
  bool searching = true;

  String keyword = "";

  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _myLocation = CameraPosition(
    target: LatLng(latitude, longitude),
    bearing: 192.0,
    tilt: 59.440717697143555,
    zoom: 16,
  );

  void _setCircles(LatLng point) {
    final String circleIdVal = 'circle_id_$_circleIdCounter';

    _circleIdCounter++;
    print(
        'Circle | Latitude: ${point.latitude}  Longitude: ${point.longitude}  Radius: $RADIUS');
    _circles.add(Circle(
        circleId: CircleId(circleIdVal)  ,
        center: point,
        radius: RADIUS.toDouble(),
        fillColor: Colors.redAccent.withOpacity(0.1),
        strokeWidth: 3,
        strokeColor: Colors.redAccent));
  }

  void _setStyle(GoogleMapController controller) async {
    String value = await DefaultAssetBundle.of(context                                )
        .loadString('assets/map_style.json');
    controller.setMapStyle(value);
  }

  void searchNearby(String keyword) async {
    setState(() {
      markers.clear(); // 2
    });

    final data = await Api().getApi(keyword);
    if (data.status == "OK") {
      _handleResponse(data);
    } else {
      throw Exception('An error occurred getting places nearby');
    }
  }

  void _handleResponse(PlaceResult data){
    setState(() {
      places = data.results;
      for (int i = 0; i < places.length; i++) {
        markers.add(
          Marker(
            markerId: MarkerId(places[i].placeId),
            position: LatLng(places[i].geometry.location.lat,
                places[i].geometry.location.lng),
            infoWindow: InfoWindow(
                title: places[i].name, snippet: places[i].vicinity),
            onTap: () {},
          ),
        );
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: _myLocation,
              onMapCreated: (GoogleMapController controller) {
                _setStyle(controller);
                _controller.complete(controller);
              },
              // onMapCreated: _onMapCreated,
              onCameraMove: (cameraPos) {},
              zoomControlsEnabled: false,
              compassEnabled: false,
              markers: Set<Marker>.of(markers),
              circles: _circles,
            ),
            Positioned(
              top: 24,
              right: 12,
              left: 12,
              child: SearchWidget(
                onSearchSubmitted: (keyword) {
                  setState(() {
                    this.keyword = keyword;
                  });
                  searchNearby(keyword);
                  _setCircles(LatLng(latitude, longitude));
                },
              ),
            ),
            places != null ? Positioned(
              bottom: 48,
              right: 12,
              left: 12,
              child: Container(
                height: 134,
                child: ListView.separated(
                  separatorBuilder: (ctx, i) => SizedBox(
                    width: 10,
                  ),
                  scrollDirection: Axis.horizontal,
                  itemCount: places.length,
                  itemBuilder: (ctx, i) => PlaceItem(places[i], _controller)
                ),
              ),
            ) : Container()
          ],
        ),
      ),
    );
  }
}
