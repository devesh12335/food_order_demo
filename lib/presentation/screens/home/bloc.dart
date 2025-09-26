import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_orders/constants/api_constants.dart';
import 'package:food_orders/models/food_list_model.dart';
import 'package:food_orders/models/store_list_model.dart';
import 'package:food_orders/presentation/resources/router/route_manager.dart';
import 'package:food_orders/services/mock_api/food_item_api.dart';
import 'package:food_orders/services/mock_api/store_api.dart';

import 'events.dart';
import 'state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState.initial()) {
    on<HomeInitEvent>(_onInit);
    on<onSearchEvent>(_ononSearch);
    on<onStoreTapEvent>(_ononStoreTap);
    on<productDetailsEvent>(_onproductDetails);
}

  Future<void> _onproductDetails(productDetailsEvent event, Emitter<HomeState> emit) async {
    try {
        Navigator.pushNamed(event.context, Routes.productDetailsPage,arguments: event.item.toJson());
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }




  Future<void> _ononStoreTap(
    onStoreTapEvent event,
    Emitter<HomeState> emit,
  ) async {
    try {
      Navigator.pushNamed(
        event.context,
        Routes.productDisplayPage,
        arguments: event.store.toJson(),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }

  Future<void> _ononSearch(onSearchEvent event, Emitter<HomeState> emit) async {
    try {
      FoodItemApi _food_mock = FoodItemApi();
      _food_mock.searchFoodItems(query1: {"search": "pizza"});
      final response1 = await _food_mock.dio.post(
        "${ApiConstants.baseUrl}${ApiConstants.searchFood}",
        queryParameters: {"search": "pizza"},
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }

  Future<void> _onInit(HomeInitEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(status: HomeStatus.loading));

      StoreApi _storeApiMock = StoreApi();
      _storeApiMock.getStores();
      print(
        "Path from Main - ${ApiConstants.baseUrl}${ApiConstants.getStores}",
      );
      final response = await _storeApiMock.dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.getStores}",
      );
      print("Api Responce ${response.data}");
      StoreListModel allStores = StoreListModel.fromJson(response.data);

      FoodItemApi _food_mock = FoodItemApi();
      _food_mock.getFoodItems();
      final response1 = await _food_mock.dio.get(
        "${ApiConstants.baseUrl}${ApiConstants.getAllFood}",
      );
      FoodListModel allitems = FoodListModel.fromJson(response1.data);

      emit(
        state.copyWith(
          status: HomeStatus.loaded,
          allFoodList: allitems,
          allStoreList: allStores,
        ),
      );
    } catch (e) {
      print("$e");
      emit(state.copyWith(status: HomeStatus.error, error: e.toString()));
    }
  }
}
