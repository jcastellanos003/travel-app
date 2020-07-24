import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatelessWidget {
  static final route = 'map';

  final Completer<GoogleMapController> _controller = Completer();

  //Inital Position (User Current Location ?)
  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(6.209100, -75.578430),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _kGooglePlex,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }
}
