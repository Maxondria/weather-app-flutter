import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    PermissionStatus permission =
        await LocationPermissions().checkPermissionStatus();

    if (permission == PermissionStatus.granted) {
      Position position = await Geolocator().getCurrentPosition(
          desiredAccuracy: LocationAccuracy.bestForNavigation);

      print(position);
    } else {
      if (Platform.isAndroid) {
        PermissionStatus getPermission =
            await LocationPermissions().requestPermissions();

        if (getPermission != null) {
          getLocation();
        }
      } else if (Platform.isIOS) {
        if (permission == PermissionStatus.restricted) {
          print('Proceed to App');
        } else {
          print('Warn User and proceed');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
