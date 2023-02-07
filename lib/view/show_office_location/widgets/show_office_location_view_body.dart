import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

import '../../resourse/color_manager.dart';

class ShowOfficeLocationViewBody extends StatelessWidget {
  final MapController mapController;

  const ShowOfficeLocationViewBody({super.key, required this.mapController});
  @override
  Widget build(BuildContext context) {
    return OSMFlutter(
      userLocationMarker: UserLocationMaker(
          personMarker: const MarkerIcon(
            icon: Icon(Icons.location_on,
              color: ColorManager.error,
              size: 50,
            ),
          ),
          directionArrowMarker: const MarkerIcon(
            icon: Icon(Icons.location_on,
              color: ColorManager.error,
              size: 50,
            ),
          ),

      ),
        initZoom: 4,
        markerOption: MarkerOption(
          defaultMarker: MarkerIcon(
            icon: Icon(Icons.location_on,
            color: ColorManager.error,
              size: 50,
            ),
          ),
        ),
        controller: mapController);
  }
}
