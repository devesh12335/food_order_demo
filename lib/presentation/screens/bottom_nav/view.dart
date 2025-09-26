import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class BottomNavPage extends StatelessWidget {
  const BottomNavPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => BottomNavBloc()..add(BottomNavInitEvent()),
      child: BlocConsumer<BottomNavBloc, BottomNavState>(
        listener: (context, state) {
          // handle navigation or snackbars
        },
        builder: (context, state) {
          switch (state.status) {
            case BottomNavStatus.loading:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case BottomNavStatus.loaded:
              return BottomNavLoadedPage(state: state);
            case BottomNavStatus.error:
              return Scaffold(
                body: Center(child: Text(state.error ?? "An error occurred")),
              );
            default:
              return const Scaffold(body: Center(child: Text("Unknown state")));
          }
        },
      ),
    );
  }
}

class BottomNavLoadedPage extends StatelessWidget {
  BottomNavState state;
  BottomNavLoadedPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Padding(
        padding: const EdgeInsets.only(bottom: 35.0),
        child: state.screenList![state.selectedIndex ?? 0],
      ),

      floatingActionButton: IconButton.filled(
        onPressed: () =>
            context.read<BottomNavBloc>().add(GoToCartEvent(context: context)),
        icon: Padding(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.shopping_cart, color: Colors.white),
        ),
      ),
      bottomNavigationBar: Container(
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(20),
              blurRadius: 10.0,
              spreadRadius: 0.0,
              offset: Offset(0.0, -10.0),
            ),
          ],
        ),

        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.dining_outlined),
              label: 'Orders',
            ),
             BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
            ),
          ],
          currentIndex: state.selectedIndex ?? 0,
          selectedItemColor: Colors.deepOrange,
          onTap: (val) => context.read<BottomNavBloc>().add(
            onItemTappedEvent(selectedIndex: val),
          ),
        ),
      ),
    );
  }
}
