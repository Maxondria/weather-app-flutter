import 'dart:io' show Platform;

import 'package:clima/services/exceptions.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_permissions/location_permissions.dart';

class Location {
  Future<Position> getCurrentLocation() async {
    bool isLocationEnabled = await Geolocator().isLocationServiceEnabled();

    if (!isLocationEnabled) {
      throw CustomException(cause: 'LOCATION.DISABLED');
    }

    PermissionStatus permission =
        await LocationPermissions().checkPermissionStatus();

    Position currentPosition;

    if (permission == PermissionStatus.granted) {
      try {
        currentPosition = await Geolocator().getCurrentPosition(
            desiredAccuracy: LocationAccuracy.bestForNavigation);
      } catch (e) {
        throw CustomException(cause: e);
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
          throw CustomException(cause: 'IOS.USER.RESTRICTED.LOCATION.USE');
        } else {
          throw CustomException(cause: 'IOS.USER.DENIED.LOCATION.PERMISSION');
        }
      }
    }

    return currentPosition;
  }
}
