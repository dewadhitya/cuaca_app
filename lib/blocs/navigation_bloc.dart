// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:cuaca_app/models/app_state.dart';
import 'package:rebloc/rebloc.dart' as rebloc;

class PushNamedRouteAction extends rebloc.Action {
  final String routeName;

  PushNamedRouteAction(this.routeName);
}

class PushNamedReplacementRouteAction extends rebloc.Action {
  final String routeName;

  PushNamedReplacementRouteAction(this.routeName);
}

class PopAction extends rebloc.Action {
  final bool removeHistory;

  PopAction({this.removeHistory = true});
}

class PopUntilAction extends rebloc.Action {
  final String route;

  PopUntilAction(this.route);
}

List<String> pageHistory = [];

class NavigationBloc extends rebloc.SimpleBloc<AppState> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigationBloc(this.navigatorKey);

  _printHistory(String event, {String? route}) {
    print("################################   debug for   pageHistory   ##### $event");
    print(pageHistory);
    print(route);
    print("################################   end of debug for   pageHistory");
  }

  @override
  rebloc.Action middleware(dispatcher, state, action) {
    if (action is PushNamedRouteAction) {
      navigatorKey.currentState?.pushNamed(action.routeName);
      pageHistory.add(action.routeName);
      _printHistory("PushNamedRouteAction", route: action.routeName);
    } else if (action is PushNamedReplacementRouteAction) {
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
          action.routeName, (Route<dynamic> route) => false);
      pageHistory.clear();
      pageHistory.add(action.routeName);
      _printHistory("PushNamedReplacementRouteAction", route: action.routeName);
    } else if (action is PopAction) {
      navigatorKey.currentState?.pop();
      if(action.removeHistory){
        pageHistory.removeLast();
        _printHistory("PopAction");
      }
    } else if (action is PopUntilAction) {
      navigatorKey.currentState?.popUntil(ModalRoute.withName(action.route));
      int index = pageHistory.indexOf(action.route);
      if (index != -1) {
        pageHistory.removeRange(index + 1, pageHistory.length);
      }
      _printHistory("PopUntilAction", route: action.route);
    } 

    return action;
  }

  @override
  AppState reducer(state, action) {

    return state;
  }

  @override
  rebloc.Action afterware(rebloc.DispatchFunction dispatcher, AppState state,
      rebloc.Action action) {

    return action;
  }
}
