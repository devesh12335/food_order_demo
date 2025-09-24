import 'package:dio/dio.dart';
import 'package:food_orders/constants/api_constants.dart';
import 'package:food_orders/services/mock_data/fake_order.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';


class OrderApi {
  final dio = Dio(BaseOptions());
  DioAdapter? dioAdapter;

  OrderApi() {
    dioAdapter = DioAdapter(dio: dio);
  }

  /// Get all orders
  void getOrders() {
    print("Path from getOrdersApi - ${ApiConstants.getAllOrders}");
    dioAdapter!.onGet(
      ApiConstants.getAllOrders, // just path
      (server) => server.reply(
        200,
        fake_orders,
        delay: const Duration(seconds: 1),
      ),
    );
  }

  /// Get single order by ID
  void getSingleOrder({required int id}) {
    print("Path from getSingleOrderApi - ${ApiConstants.getSingleOrder}/$id");

    dioAdapter!.onGet(
      "${ApiConstants.getSingleOrder}/$id",
      (server) {
        Map<String, Object>? order;

        for (final o in fake_orders['data']) {
          if (o['orderId'] == id) {
            order = Map<String, Object>.from(o);
            break;
          }
        }

        if (order != null) {
          return server.reply(
            200,
            {"data": order},
            delay: const Duration(seconds: 1),
          );
        } else {
          return server.reply(
            404,
            {"error": "Order not found"},
            delay: const Duration(seconds: 1),
          );
        }
      },
    );
  }

  /// Create a new order
  void createOrder({required Map<String, dynamic> orderData}) {
    print("Path from createOrderApi - ${ApiConstants.placeNewOrder}");

    dioAdapter!.onPost(
      ApiConstants.placeNewOrder,
      (server) {
        // Normally you would push into fake_orders
        return server.reply(
          201,
          {"data": orderData},
          delay: const Duration(seconds: 1),
        );
      },
      queryParameters: orderData, // accept any request body
    );
  }
}
