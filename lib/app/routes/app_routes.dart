import 'package:chacrita/features/guide/pages/guide_page.dart';
import 'package:chacrita/features/index/pages/index_page.dart';
import 'package:flutter/material.dart';
class AppRoutes {
    static const String guide = '/guide';
    static const String index = '/index';
  static Map<String, WidgetBuilder> getRoutes() {
    return {
    guide :(context)=> const GuidePage(),
    index :(context)=> const IndexPage(),
    };
  }
}


