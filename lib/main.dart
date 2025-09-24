import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:food_orders/constants/api_constants.dart';
import 'package:food_orders/presentation/resources/router/route_manager.dart';
import 'package:food_orders/presentation/resources/theme/theme_manager.dart';
import 'package:food_orders/services/mock_api/food_item_api.dart';
import 'package:food_orders/services/mock_api/order_api.dart';
import 'package:food_orders/services/mock_api/store_api.dart';


Future<void> main() async {
 
  
  // StoreApi _storeApiMock = StoreApi();
  // _storeApiMock.getStores();
  // print("Path from Main - ${ApiConstants.baseUrl}${ApiConstants.getStores}");
  // final response = await _storeApiMock.dio.get("${ApiConstants.baseUrl}${ApiConstants.getStores}") ;
  // print("Api Responce ${response.data}");

//   FoodItemApi _food_mock = FoodItemApi();
//   _food_mock.getFoodItems();
//   _food_mock.searchFoodItems(query1: {"search": "pizza"});
//   _food_mock.getSingleFoodItem(id: 5);

//   final response1 = await _food_mock.dio.get("${ApiConstants.baseUrl}${ApiConstants.getAllFood}") ;
// print("Api Responce Food Items All${response1.data}");
// print("Api Responce Main Url ${ApiConstants.baseUrl}${ApiConstants.searchFood}");
//     final response = await _food_mock.dio.post(
//     "${ApiConstants.baseUrl}${ApiConstants.searchFood}",
//     queryParameters: {"search": "pizza"}, 
//   );

//   // 4. Print the returned data
//   print("Search API response:");
//   print(response.data);

//    final response2 = await _food_mock.dio.get(
//     "${ApiConstants.baseUrl}${ApiConstants.getSingleFood}/5",
   
//   );

//   // 4. Print the returned data
//   print("Single Food API response:");
//   print(response2.data);


  final orderApi = OrderApi();

  // Setup mocks
  orderApi.getOrders();
  orderApi.getSingleOrder(id: 1);
  orderApi.createOrder(orderData: {
    "id": 3,
    "userId": 103,
    "tip": 10.0,
    "products": [
      {"id": 2, "name": "Veg Burger", "quantity": 2}
    ]
  });

  // Dio client
  final dio = orderApi.dio;

  // Get all orders
  final responseAll = await dio.get(ApiConstants.getAllOrders);
  print("All Orders:");
  print(responseAll.data);



  //  Create order
  final responseCreate = await dio.post(ApiConstants.placeNewOrder, queryParameters: {
    "id": 3,
    "userId": 103,
    "tip": 10.0,
    "products": [
      {"id": 2, "name": "Veg Burger", "quantity": 2}
    ]
  });
  print("Created Order:");
  print(responseCreate.data);

    //  Get single order
  final responseSingle = await dio.get("${ApiConstants.getSingleOrder}/1");
  print("Single Order (ID=1):");
  print(responseSingle.data);


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
