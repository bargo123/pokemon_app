import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkInfoService {
  Future<bool> isAvailable() async {
    ConnectivityResult result = await Connectivity().checkConnectivity();
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
        return true;
      default:
        return false;
    }
  }
}
