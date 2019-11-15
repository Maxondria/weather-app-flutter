import 'dart:io' show Platform;

import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

class Location {
  Future<Position> getCurrentLocation() async {
    PermissionStatus permission =
        await LocationPermissions().checkPermissionStatus();

    Position currentPosition;

    if (permission == PermissionStatus.granted) {
      GeolocationStatus geolocationStatus =
          await Geolocator().checkGeolocationPermissionStatus();

      if (geolocationStatus == GeolocationStatus.disabled) {
        print('Alert user to turn on, and re-run checks within method');
        throw 'GPS.IS.OFF';
      } else {
        try {
          currentPosition = await Geolocator().getCurrentPosition(
              desiredAccuracy: LocationAccuracy.bestForNavigation);
        } catch (e) {
          throw e.toString();
        }
      }
    } else {
      if (Platform.isAndroid) {
        PermissionStatus getPermission =
            await LocationPermissions().requestPermissions();

        if (getPermission != null) {
          getCurrentLocation();
        }
      } else if (Platform.isIOS) {
        if (permission == PermissionStatus.restricted) {
          throw 'IOS.USER.RESTRICTED.LOCATION.USE';
        } else {
          throw 'IOS.USER.DENIED.LOCATION.PERMISSION';
        }
      }
    }
    return currentPosition;
  }
}
