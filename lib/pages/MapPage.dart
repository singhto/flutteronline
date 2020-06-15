import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:location/location.dart';

class MapPage extends StatefulWidget {
  MapPage({Key key}) : super(key: key);

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Completer<GoogleMapController> _controller = Completer();
  double lat, lng;

  _openGoogleMapApp(double lat, double long) async {
    var url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void initState() {
    super.initState();
    findLocation();
  }

  Future<void> findLocation() async {
    LocationData myData = await locationData();
    setState(() {
      lat = myData.latitude;
      lng = myData.longitude;
    });
  }

  Future<LocationData> locationData() async {
    var location = Location();

    try {
      return await location.getLocation();
    } catch (e) {
      return null;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('แผนที่มิเตอร์'),
      ),
      body: showMap(),
    );
  }

  Marker userMarker() {
    return Marker(
      markerId: MarkerId('userID'),
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(16.751121, 101.218448),
      infoWindow: InfoWindow(
          title: 'PEA: 5670700103',
          snippet: 'Mr.sinhto Nonklang',
          onTap: () {
            _openGoogleMapApp(16.751121, 101.218448);
          }),
    );
  }

  Marker userMarker2() {
    return Marker(
      markerId: MarkerId('userID'),
      icon: BitmapDescriptor.defaultMarkerWithHue(100),
      position: LatLng(16.753556, 101.216488),
      infoWindow: InfoWindow(
          title: 'PEA: 5670723203',
          snippet: 'Miss.Kantima Janla',
          onTap: () {
            _openGoogleMapApp(16.753556, 101.216488);
          }),
    );
  }

  Set<Marker> myMarker() {
    return <Marker>[userMarker(), userMarker2()].toSet();
  }

  GoogleMap showMap() {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(lat, lng),
      zoom: 16.0,
    );
    return GoogleMap(
      myLocationEnabled: true,
      initialCameraPosition: cameraPosition,
      mapType: MapType.normal,
      onMapCreated: (controller) {},
      markers: myMarker(),
    );
  }
}
