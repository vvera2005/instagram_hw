import 'package:flutter/material.dart';

import '../../presentation/pages/home_page/home_page.dart';
import '../../presentation/pages/profile_page/profile_page.dart';
import '../../presentation/pages/settings/settings.dart';

// ignore: avoid_classes_with_only_static_members
class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/settings':
        return MaterialPageRoute(builder: (_) => const Settings());
      case '/homepage':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/profile_page':
        return MaterialPageRoute(builder: (_) => ProfilePage());
      default:
        throw Exception('No page found');
    }
  }
}
