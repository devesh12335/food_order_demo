import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc()..add(HomeInitEvent()),
      child: BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {
          // handle navigation or snackbars
        },
        builder: (context, state) {
          switch (state.status) {
            case HomeStatus.initial:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case HomeStatus.loaded:
              return HomeLoadedPage();
            case HomeStatus.error:
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

class HomeLoadedPage extends StatelessWidget {
  const HomeLoadedPage({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(body: Center(child: Text('Home',style: TextStyle(fontSize: 30),),),);
  }
}
