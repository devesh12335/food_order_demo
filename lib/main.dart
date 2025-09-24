import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_orders/constants/api_constants.dart';
import 'package:food_orders/prsentation/resources/router/route_manager.dart';
import 'package:food_orders/prsentation/resources/theme/theme_manager.dart';
import 'package:food_orders/services/mock_api/store_api.dart';


Future<void> main() async {
 
  
  StoreApi _storeApiMock = StoreApi();
  _storeApiMock.getStores();
  print("Path from Main - ${ApiConstants.baseUrl}${ApiConstants.getStores}");
  final response = await _storeApiMock.dio.get("${ApiConstants.baseUrl}${ApiConstants.getStores}") ;
  
  print("Api Responce ${response.data}");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.authPage,
      theme: getApplicationTheme(),
    
      
    );
  }
}
