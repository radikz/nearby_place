import 'dart:async';

import 'package:flutter/material.dart';
import 'package:near_place/models/place_result.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PlaceItem extends StatelessWidget {
  final Result result;
  final Completer<GoogleMapController> controller;

  PlaceItem(this.result, this.controller);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _gotoLocation,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.all(Radius.circular(40.0)),
        ),
        padding: EdgeInsets.all(8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_rounded,
              color: Colors.red,
              size: 48,
            ),
            SizedBox(
              width: 10,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(
                    result.name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Text(result.vicinity),
                ),
                SizedBox(height: 5,),
                Container(
                  width: MediaQuery.of(context).size.width * 0.55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        child: result.openingHours != null
                            ? Text(
                                result.openingHours.openNow ? 'Open' : 'Closed',
                                style: TextStyle(
                                    color: result.openingHours.openNow
                                        ? Colors.green
                                        : Colors.red),
                              )
                            : Text('Unknown'),
                      ),
                      SizedBox(width: 10,),
                      Row(
                        children: [
                          Container(
                            child: Icon(
                              Icons.star,
                              color: Colors.amber,
                              size: 15.0,
                            ),
                          ),
                          SizedBox(width: 5),
                          Text(result.rating.toString())
                        ],
                      ),
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  static final CameraPosition place = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future<void> _gotoLocation() async {
    final GoogleMapController _controller = await controller.future;
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target:
          LatLng(result.geometry.location.lat, result.geometry.location.lng),
      zoom: 17,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
}
