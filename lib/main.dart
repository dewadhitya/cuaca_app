import 'package:bot_toast/bot_toast.dart';
import 'package:cuaca_app/screens/landing.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cuaca_app/routes.dart';
import 'package:cuaca_app/util.dart';
import 'package:rebloc/rebloc.dart';

import 'blocs/navigation_bloc.dart';
import 'models/app_state.dart';

void main() {
  Util.checkDebugMode();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  
  final navigatorKey = GlobalKey<NavigatorState>();

  final store = Store<AppState>(
    initialState: AppState.initialState(),
    blocs: [
      NavigationBloc(navigatorKey),
    ],
  );
  
  runApp(MyApp(store, navigatorKey));
}

class MyApp extends StatelessWidget {
  final Store<AppState> store;
  final GlobalKey<NavigatorState> navigatorKey;

  final router = FluroRouter();

  MyApp(this.store, this.navigatorKey, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Routes.configureRoutes(router);

    return StoreProvider(
      store: store,
      child: MaterialApp(
        builder: BotToastInit(),
        navigatorObservers: [BotToastNavigatorObserver()],
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        onGenerateRoute: router.generator,
        navigatorKey: navigatorKey,
        home: LandingPage(),
      ),
    );
  }
}
