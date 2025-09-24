import 'package:flutter/material.dart';

class Routes {
  static const String authPage = '/auth';

}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      // case Routes.loginPage:
      //   return MaterialPageRoute(builder: (_) => const LoginPage());


      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
        builder: (_) => const Scaffold(
                body: SizedBox(
              child: Center(
                child: Text("Page Not Found"),
              ),
            )));
  }
}
