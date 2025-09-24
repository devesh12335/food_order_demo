import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(SplashInitEvent()),
      child: BlocConsumer<SplashBloc, SplashState>(
        listener: (context, state) {
          // handle navigation or snackbars
        },
        builder: (context, state) {
          switch (state.status) {
            case SplashStatus.initial:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case SplashStatus.loaded:
              return SplashLoadedPage();
            case SplashStatus.error:
              return Scaffold(
                body: Center(
                  child: Text(state.error ?? "An error occurred"),
                ),
              );
            default:
              return const Scaffold(
                body: Center(child: Text("Unknown state")),
              );
          }
        },
      ),
    );
  }
}

class SplashLoadedPage extends StatelessWidget {
  const SplashLoadedPage({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(body: Center(child: Text('Splash',style: TextStyle(fontSize: 30),),),);
  }
}
