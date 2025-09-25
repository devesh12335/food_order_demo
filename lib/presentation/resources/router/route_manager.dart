import 'package:flutter/material.dart';
import 'package:food_orders/presentation/screens/cart/view.dart';
import 'package:food_orders/presentation/screens/home/view.dart';
import 'package:food_orders/presentation/screens/orders/view.dart';
import 'package:food_orders/presentation/screens/search_produts/view.dart';
import 'package:food_orders/presentation/screens/splash/view.dart';

class Routes {
  static const String splashPage = '/splash';
static const String homePage = '/home';
static const String orderPage = '/orders';
static const String cartPage = '/cart';
static const String searchPage = '/search';
}

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case Routes.splashPage:
        return MaterialPageRoute(builder: (_) => const SplashPage());
  case Routes.cartPage:
        return MaterialPageRoute(builder: (_) => const CartPage());
          case Routes.homePage:
        return MaterialPageRoute(builder: (_) => const HomePage());
          case Routes.orderPage:
        return MaterialPageRoute(builder: (_) => const OrdersPage());
  case Routes.searchPage:
        return MaterialPageRoute(builder: (_) => const SearchProdutsPage());

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
