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
        title: Text('แผนที่'),
      ),
      body: showMap(),
    );
  }

  Marker userMarker() {
    return Marker(
      markerId: MarkerId('userID'),
      icon: BitmapDescriptor.defaultMarkerWithHue(310.0),
      position: LatLng(16.751635, 101.215736),
      infoWindow: InfoWindow(
        title: 'สถานที่ส่งอาหาร',
        snippet: 'Mr.sinhto Nonklang',
                onTap: () {
                  _openGoogleMapApp(16.751635, 101.215736);
                }
      ),
    );
  }

  Set<Marker> myMarker() {
    return <Marker>[userMarker()].toSet();
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
