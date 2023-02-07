import 'package:currency_app/translations/locale_keys.g.dart';
import 'package:currency_app/view/show_office_location/widgets/show_office_location_view_body.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';

class ShowOfficeLocationView extends StatelessWidget {
  final double longitude , latitude;

  const ShowOfficeLocationView({super.key, required this.longitude, required this.latitude});

  @override
  Widget build(BuildContext context) {
    var mapController = MapController.withPosition(
        initPosition: GeoPoint(
          latitude: latitude,
          longitude: longitude
        ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(tr(LocaleKeys.location)),
      ),
      body: ShowOfficeLocationViewBody(
        mapController: mapController,
      ),
    );
  }
}
