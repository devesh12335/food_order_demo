import 'package:dio/dio.dart';
import 'package:food_orders/constants/api_constants.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

class StoreApi {
    final dio = Dio(BaseOptions());
  DioAdapter? dioAdapter ;

  StoreApi(){
    dioAdapter = DioAdapter(dio: dio);
  }

  void getStores(){
    print("Path from storeapi - ${ApiConstants.baseUrl}${ApiConstants.getStores}");
 dioAdapter!.onGet(
    "${ApiConstants.baseUrl}${ApiConstants.getStores}",
    (server) => server.reply(
      200,
      {"messgae":"Sdsdfsdf"},
      // Reply would wait for one-sec before returning data.
      delay: const Duration(seconds: 1),
    ),
  );

 
  }

 
}