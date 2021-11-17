class Util {
  static String mode = "release";
  static String defaultPassword = '';
  static String defaultEmail = '';

  static String baseUrl = "";

  static bool get debugMode {
    var debug = false;
    assert(debug = true);
    return debug;
  }

  static checkDebugMode() {
    assert(() {
      baseUrl = "";
      mode = "debug";
      defaultPassword = '';
      defaultEmail = '';
      return true;
    }());
  }

  static forceRelease() {
    baseUrl = "";
    mode = "release";
    defaultPassword = '';
    defaultEmail = '';
  }

  static forceDebug() {
    baseUrl = "";
    mode = "debug";
    defaultPassword = '';
    defaultEmail = '';
  }
}