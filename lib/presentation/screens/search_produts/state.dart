import 'package:equatable/equatable.dart';

enum SearchProdutsStatus { initial, loading, loaded, error }

class SearchProdutsState extends Equatable {
  final SearchProdutsStatus status;
  final String? error;

  const SearchProdutsState({
    required this.status,
    this.error,
  });

  factory SearchProdutsState.initial() => const SearchProdutsState(
    status: SearchProdutsStatus.initial,
  );

  SearchProdutsState copyWith({
    SearchProdutsStatus? status,
    String? error,
  }) {
    return SearchProdutsState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
