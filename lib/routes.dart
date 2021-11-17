import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';

// EXAMPLE
// var exampleHandler = fluroFork.Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   return TheScreens();
// });

// -- IF BRING THE PARAMETERS TO NEXT SCREEN
// var exampleHandler = fluroFork.Handler(
//     handlerFunc: (BuildContext context, Map<String, List<String>> params) {
//   return TheScreens(
//     id: params['id'][0],
//   );
// });

class Routes {
  /// EXAMPLE
  /// static const example = '/example';
  /// 
  static const nextScreen = '/next_screen';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = Handler(
        handlerFunc: (BuildContext? context, Map<String, List<String>> params) {
      print("ROUTE WAS NOT FOUND !!!");
      return null;
    });

    /// WRITE HERE [router.define(.....)]
    ///
    /// EXAMPLE
    // router.define(theScreen,
    //     handler: theScreenHandler,
    //     transitionType: TransitionType.native);


  }
}