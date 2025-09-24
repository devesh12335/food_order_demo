import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_orders/constants/api_constants.dart';
import 'package:food_orders/prsentation/resources/router/route_manager.dart';
import 'package:food_orders/prsentation/resources/theme/theme_manager.dart';
import 'package:food_orders/services/mock_api/food_item_api.dart';
import 'package:food_orders/services/mock_api/store_api.dart';


Future<void> main() async {
 
  
  // StoreApi _storeApiMock = StoreApi();
  // _storeApiMock.getStores();
  // print("Path from Main - ${ApiConstants.baseUrl}${ApiConstants.getStores}");
  // final response = await _storeApiMock.dio.get("${ApiConstants.baseUrl}${ApiConstants.getStores}") ;
  // print("Api Responce ${response.data}");

  FoodItemApi _food_mock = FoodItemApi();
  _food_mock.getFoodItems();
  _food_mock.searchFoodItems(query1: {"search": "pizza"});

  final response1 = await _food_mock.dio.get("${ApiConstants.baseUrl}${ApiConstants.getAllFood}") ;
print("Api Responce Food Items All${response1.data}");
print("Api Responce Main Url ${ApiConstants.baseUrl}${ApiConstants.searchFood}");
    final response = await _food_mock.dio.post(
    "${ApiConstants.baseUrl}${ApiConstants.searchFood}",
    queryParameters: {"search": "pizza"}, // the request body doesn't affect filtering here
  );

  // 4. Print the returned data
  print("Search API response:");
  print(response.data);

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
