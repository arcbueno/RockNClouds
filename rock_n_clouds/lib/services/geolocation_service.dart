import 'package:geolocator/geolocator.dart';
import 'package:result_dart/result_dart.dart';
import 'package:rock_n_clouds/exceptions/unexpected_error.dart';
import 'package:rock_n_clouds/i18n/text_data.dart';

class GeolocationService {
  Future<Result<(double, double), Exception>> getCurrentLocation() async {
    try {
      if (!(await Geolocator.isLocationServiceEnabled())) {
        return Failure(Exception(TextData.locationServiceDisabled));
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Failure(Exception(TextData.locationPermissionDenied));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Failure(Exception(TextData.locationPermissionPermanentlyDenied));
      }

      var position = await Geolocator.getCurrentPosition();
      return Result.success((position.latitude, position.longitude));
    } catch (e) {
      return _errorHandler(e) as Failure<(double, double), Exception>;
    }
  }

  Failure _errorHandler(dynamic error) {
    if (error is Exception) {
      return Failure(error);
    }
    return Failure(UnexpectedError());
  }
}
