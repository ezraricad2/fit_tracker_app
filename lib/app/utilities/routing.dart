import 'package:fit_tracker_app/app/utilities/slide_route.dart';
import 'package:flutter/material.dart';

import 'enter_exit_route.dart';

class Routing {
  static Future<T> pushReplacement<T extends Object>(
      BuildContext context, Widget widgetExit, Widget widgetEnter) async {
    var result = await Navigator.pushReplacement(
      context,
        SlideLeftRoute(
            widget: widgetEnter,
            settings: RouteSettings(name: widgetEnter.runtimeType.toString()))
    );
    return result;
  }

  static Future<T> push2<T extends Object>(
      BuildContext context, Widget widget) async {
    var result = await Navigator.push(
      context,
      SlideLeftRoute(
          widget: widget,
          settings: RouteSettings(name: widget.runtimeType.toString())),
    );
    return result;
  }

  static Future<T> push<T extends Object>(
      BuildContext context, Widget widgetExit, Widget widgetEnter) async {
    var result = await Navigator.push(
      context,
        SlideLeftRoute(
            widget: widgetEnter,
            settings: RouteSettings(name: widgetEnter.runtimeType.toString()))
//      EnterExitRoute(
//          exitPage: widgetExit,
//          enterPage: widgetEnter,
//          settings: RouteSettings(name: widgetEnter.runtimeType.toString())),
    );
    return result;
  }

  static Future<T> pushTop<T extends Object>(
      BuildContext context, Widget widgetExit, Widget widgetEnter) async {
    var result = await Navigator.push(
        context,
        SlideTopRoute(
            widget: widgetEnter,
            settings: RouteSettings(name: widgetEnter.runtimeType.toString()))
//      EnterExitRoute(
//          exitPage: widgetExit,
//          enterPage: widgetEnter,
//          settings: RouteSettings(name: widgetEnter.runtimeType.toString())),
    );
    return result;
  }

  static Future<T> pushAndRemoveUntil<T extends Object>(
      BuildContext context, Widget widgetExit, Widget widgetEnter, RoutePredicate predicate) async {
//    logger.d(
//        'push and remove until ${widget.runtimeType.toString()} : ${predicate}');
    String routeName = widgetEnter.runtimeType.toString();

    if (routeName == "HomePage") routeName = "/";

    var result = await Navigator.pushAndRemoveUntil(
        context,
        SlideLeftRoute(
            widget: widgetEnter,
            settings: RouteSettings(name: widgetEnter.runtimeType.toString())),
//        EnterExitRoute(
//            exitPage: widgetExit,
//            enterPage: widgetEnter,
//            settings: RouteSettings(name: routeName)),
        predicate);
    return result;
  }

  static void replace<T extends Object>(BuildContext context,
      Widget widgetExit, Widget widgetEnter) {
    if (Navigator.of(context) == null) return;

    try {
      Navigator.replace(
        context,
        oldRoute: EnterExitRoute(
            exitPage: widgetEnter,
            enterPage: widgetExit,
            settings: RouteSettings(name: widgetExit.runtimeType.toString())),
        newRoute: widgetEnter == null
            ? null
            : EnterExitRoute(
            exitPage: widgetExit,
            enterPage: widgetEnter,
            settings: RouteSettings(name: widgetEnter.runtimeType.toString())),
      );
    } on Exception catch (e) {
      print("alalal => $e");
    }
  }
}
