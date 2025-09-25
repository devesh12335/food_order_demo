import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart' ;

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? error;
  final FocusNode? focusNode;
  final TextEditingController? searchController;

  const HomeState({
    required this.status,
    this.error,
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
    FocusNode? focusNode,
    TextEditingController? searchController,
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
      focusNode: focusNode ?? this.focusNode,
      searchController: searchController ?? this.searchController,
    );
  }

  @override
  List<Object?> get props => [status, error, searchController, focusNode];
}
