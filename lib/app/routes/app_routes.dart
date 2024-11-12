import 'package:chacrita/features/main_features/record/pages/record_page.dart';
import 'package:chacrita/features/main_features/chat/pages/chat_page.dart';
import 'package:chacrita/features/main/pages/permission_location_page.dart';
import 'package:chacrita/features/guide/pages/guide_page.dart';
import 'package:chacrita/features/index/pages/index_page.dart';
import 'package:flutter/material.dart';
class AppRoutes {
    static const String record = '/record';
    static const String chat = '/chat';
    static const String permissionLocation = '/permission_location';
    static const String guide = '/guide';
    static const String index = '/index';
  static Map<String, WidgetBuilder> getRoutes() {
    return {
    record :(context)=> const RecordPage(),
    chat :(context)=> const ChatPage(),
    permissionLocation :(context)=> const LocationPermissionPage(),
    guide :(context)=> const GuidePage(),
    index :(context)=> const IndexPage(),
    };
  }
}


