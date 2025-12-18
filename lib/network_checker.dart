import 'package:connectivity_plus/connectivity_plus.dart';

class NetworkChecker {
  Future<bool> check() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.wifi)) {
      return true;
    } else if (connectivityResult.contains(ConnectivityResult.ethernet)) {
      return true;
    }
    return false;
  }

  // dynamic checkInternet(Function func) {
  //   check().then((intenet) {
  //     if (intenet != null && intenet) {
  //       func(true);
  //     } else {
  //       func(false);
  //     }
  //   });
  // }
}
