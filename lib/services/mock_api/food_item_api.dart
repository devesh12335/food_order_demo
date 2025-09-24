import 'package:dio/dio.dart';
import 'package:food_orders/constants/api_constants.dart';
import 'package:food_orders/services/mock_data/fake_food_items.dart';
import 'package:food_orders/services/mock_data/fake_stores.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class FoodItemApi {
    final dio = Dio(BaseOptions());
  DioAdapter? dioAdapter ;

  FoodItemApi(){
    dioAdapter = DioAdapter(dio: dio);
  }

  void getFoodItems(){
    print("Path from foodItemapi - ${ApiConstants.baseUrl}${ApiConstants.getAllFood}");
 dioAdapter!.onGet(
    "${ApiConstants.baseUrl}${ApiConstants.getAllFood}",
    (server) => server.reply(
      200,
      fake_food_items,
      // Reply would wait for one-sec before returning data.
      delay: const Duration(seconds: 1),
    ),
  );
  }

  void searchFoodItems({required Map<String,dynamic> query1}) {
  print("Path from searchFoodItemApi - ${ApiConstants.baseUrl}${ApiConstants.searchFood}");

  dioAdapter!.onPost(
    "${ApiConstants.baseUrl}${ApiConstants.searchFood}",
    (server) {
      
      final query = query1['search'].toLowerCase();
      
      // Filter items from fake_food_items by name/description
      final filteredItems = fake_food_items['data'].where((item) {
        final name = (item['name'] ?? '').toString().toLowerCase();
        final desc = (item['description'] ?? '').toString().toLowerCase();
        return name.contains(query) || desc.contains(query);
      }).toList();

      return server.reply(
        200,
        {"data": filteredItems},
        delay: const Duration(seconds: 2),
      );
    },
    queryParameters:query1
  );
}

void getSingleFoodItem({required int id}) {
  print("Path from getSingleFoodItemApi - ${ApiConstants.getSingleFood}/$id");

  dioAdapter!.onGet(
    "${ApiConstants.baseUrl}${ApiConstants.getSingleFood}/$id", 
    (server) {
      Map<String, Object>? item; 

      
      for (final f in fake_food_items['data']) {
        if (f['id'] == id) {
          item = Map<String, Object>.from(f); 
          break;
        }
      }
      if (item != null) {
        return server.reply(
          200,
          {"data": item},
          delay: const Duration(seconds: 1),
        );
      } else {
        return server.reply(
          404,
          {"error": "Food item not found"},
          delay: const Duration(seconds: 1),
        );
      }
    },
  );
}



 
}