import 'package:equatable/equatable.dart';

enum SplashStatus { initial, loading, loaded, error }

class SplashState extends Equatable {
  final SplashStatus status;
  final String? error;

  const SplashState({
    required this.status,
    this.error,
  });

  factory SplashState.initial() => const SplashState(
    status: SplashStatus.initial,
  );

  SplashState copyWith({
    SplashStatus? status,
    String? error,
  }) {
    return SplashState(
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  @override
  List<Object?> get props => [status, error];
}
