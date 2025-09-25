import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' ;
import 'package:food_orders/models/food_list_model.dart';
import 'package:food_orders/models/store_list_model.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? error;
  final StoreListModel? allStoreList;
  final FoodListModel? allFoodList;
  final FocusNode? focusNode;
  final TextEditingController? searchController;

  const HomeState({
    required this.status,
    this.error,
    this.allStoreList,
    this.allFoodList,
    this.focusNode,
    this.searchController,
  });

  factory HomeState.initial() =>  HomeState(
    status: HomeStatus.initial,
    focusNode: FocusNode(),
    searchController: TextEditingController()
  );

  HomeState copyWith({
    HomeStatus? status,
    String? error,
    StoreListModel? allStoreList,
    FoodListModel? allFoodList,
    FocusNode? focusNode,
    TextEditingController? searchController,
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      allStoreList: allStoreList ?? this.allStoreList,
      allFoodList: allFoodList ?? this.allFoodList,
      focusNode: focusNode ?? this.focusNode,
      searchController: searchController ?? this.searchController,
    );
  }

  @override
  List<Object?> get props => [status, error, searchController, focusNode, allFoodList, allStoreList];
}
