import 'package:flutter/material.dart';
import 'package:tech_test_atto/presentation/pages/page1_page.dart';
import 'package:tech_test_atto/presentation/pages/page2_page.dart';

class Router {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Page1.routeName:
        return MaterialPageRoute(
          builder: (_) => const Page1(),
        );
      case Page2.routeName:
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => Page2(
            checkoutList: args['checkoutList'],
            isPurchased: args['isPurchased'],
          ),
        );
      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(
              child: Text('Page not found :('),
            ),
          );
        });
    }
  }
}
