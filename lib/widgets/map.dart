import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:travel_planner/blocs/map_bloc.dart';
import 'package:travel_planner/resources/provider.dart';

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
    final bloc = AppProvider.map(context);
    return _createMap(bloc);
  }

  Widget _createMap(MapBloc bloc) {
    return StreamBuilder(
      stream: bloc.spotsStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            bloc.loadSpots();
            _controller.complete(controller);
          },
          markers: new List.from(snapshot.data)
              .map((spot) => Marker(
                    markerId: MarkerId(spot.id),
                    position: LatLng(
                      spot.location[0] as double,
                      spot.location[1] as double,
                    ),
                    infoWindow: InfoWindow(
                      title: spot.title,
                      snippet: spot.address,
                    ),
                  ))
              .toSet(),
        );
      },
    );
  }
}
