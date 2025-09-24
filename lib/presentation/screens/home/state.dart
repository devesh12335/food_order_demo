import 'package:equatable/equatable.dart';

enum HomeStatus { initial, loading, loaded, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final String? error;

  const HomeState({
    required this.status,
    this.error,
  });

  factory HomeState.initial() => const HomeState(
    status: HomeStatus.initial,
  );

  HomeState copyWith({
    HomeStatus? status,
    String? error,
  }) {
    return HomeState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
