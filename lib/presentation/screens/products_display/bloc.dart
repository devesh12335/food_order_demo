import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_orders/constants/api_constants.dart';
import 'package:food_orders/models/food_list_model.dart';
import 'package:food_orders/services/mock_api/food_item_api.dart';

import 'events.dart';
import 'state.dart';

class ProductsDisplayBloc extends Bloc<ProductsDisplayEvent, ProductsDisplayState> {
  ProductsDisplayBloc() : super(ProductsDisplayState.initial()) {
    on<ProductsDisplayInitEvent>(_onInit);
  }

  Future<void> _onInit(ProductsDisplayInitEvent event, Emitter<ProductsDisplayState> emit) async {
    try {
      emit(state.copyWith(status: ProductsDisplayStatus.loading));
      FoodItemApi _food_mock = FoodItemApi();
  _food_mock.getFoodItems();
  final response1 = await _food_mock.dio.get("${ApiConstants.baseUrl}${ApiConstants.getAllFood}") ;
  FoodListModel allitems = FoodListModel.fromJson(response1.data);
      emit(state.copyWith(
        status: ProductsDisplayStatus.loaded,
        allFoodList: allitems
      ));
    } catch (e) {
      emit(state.copyWith(status: ProductsDisplayStatus.error, error: e.toString()));
    }
  }
}
