import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_orders/constants/api_constants.dart';
import 'package:food_orders/models/order_list_model.dart';
import 'package:food_orders/services/mock_api/order_api.dart';

import 'events.dart';
import 'state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersState.initial()) {
    on<OrdersInitEvent>(_onInit);
  }

  Future<void> _onInit(OrdersInitEvent event, Emitter<OrdersState> emit) async {
    try {
      emit(state.copyWith(status: OrdersStatus.loading));
       final orderApi = OrderApi();

 
  orderApi.getOrders();



  final dio = orderApi.dio;


  final responseAll = await dio.get(ApiConstants.getAllOrders);


  print("All Orders:");
  print(responseAll.data);
      emit(state.copyWith(
        status: OrdersStatus.loaded,
        orders: OrderListModel.fromJson(responseAll.data)
      ));
    } catch (e) {
      emit(state.copyWith(status: OrdersStatus.error, error: e.toString()));
    }
  }
}
