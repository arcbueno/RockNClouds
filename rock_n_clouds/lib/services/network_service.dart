import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkService {
  Future<bool> isOnline() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    return connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi);
  }
}
