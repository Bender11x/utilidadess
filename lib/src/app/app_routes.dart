import 'package:flutter/material.dart';
import 'package:utilidades/src/app/app_menu.dart';
import 'package:utilidades/src/views/base_layout.dart';

Map<String, WidgetBuilder> generateRoutes() {
  final Map<String, WidgetBuilder> routes = {};

  for (var item in appMenuItems) {
    routes[item.route] =
        (context) => BaseLayout(title: item.title, body: item.page);
  }

  return routes;
}
