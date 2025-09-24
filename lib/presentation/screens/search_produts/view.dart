import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class SearchProdutsPage extends StatelessWidget {
  const SearchProdutsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchProdutsBloc()..add(SearchProdutsInitEvent()),
      child: BlocConsumer<SearchProdutsBloc, SearchProdutsState>(
        listener: (context, state) {
          // handle navigation or snackbars
        },
        builder: (context, state) {
          switch (state.status) {
            case SearchProdutsStatus.initial:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case SearchProdutsStatus.loaded:
              return SearchProdutsLoadedPage();
            case SearchProdutsStatus.error:
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

class SearchProdutsLoadedPage extends StatelessWidget {
  const SearchProdutsLoadedPage({super.key});

  @override
  Widget build(BuildContext context) {
      return Scaffold(body: Center(child: Text('SearchProduts',style: TextStyle(fontSize: 30),),),);
  }
}
