import 'package:chacrita/features/permission_location/pages/permission_location_page.dart';
import 'package:chacrita/features/guide/pages/guide_page.dart';
import 'package:chacrita/features/index/pages/index_page.dart';
import 'package:flutter/material.dart';
class AppRoutes {
    static const String permissionLocation = '/permission_location';
    static const String guide = '/guide';
    static const String index = '/index';
  static Map<String, WidgetBuilder> getRoutes() {
    return {
    permissionLocation :(context)=> const LocationPermissionPage(),
    guide :(context)=> const GuidePage(),
    index :(context)=> const IndexPage(),
    };
  }
}


