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
              return HomeLoadedPage(state: state,);
            case HomeStatus.error:
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

class HomeLoadedPage extends StatelessWidget {
  HomeState state;
   HomeLoadedPage({super.key,required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: false,
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadiusGeometry.circular(15)
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           Padding(
                  padding: EdgeInsets.only(bottom: 16.0),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.transparent,
                    child: Image.asset("assets/app_logo.png",scale: 0.2,),
                  ),
                ),
                SizedBox(width: 10,),
          Text(
                      'Foodies',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.normal,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size(MediaQuery.of(context).size.width, 50),
        child: Padding(
          padding: EdgeInsetsGeometry.only(bottom: 10),
          child: Card(
            
                  elevation: 4,
                  shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
                  ),
                  child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            controller: state.searchController,
            focusNode: state.focusNode,
            decoration: InputDecoration(
              hintText: 'Search Food Items...',
              border: InputBorder.none,
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: state.searchController!.text.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear, color: Colors.grey),
                      onPressed: () {
                        state.searchController!.clear();
                        state.focusNode!.requestFocus();
                      },
                    )
                  : null,
            ),
            onSubmitted: (value) {
              // This is where you would handle the search query
              context.read<HomeBloc>().add(onSearchEvent(query: value));
              print('Search query submitted: $value');
            },
          ),
                  ),
            ),
        ),
      ),

      
      ),
      body: Center(child: Text('Home', style: TextStyle(fontSize: 30))),
    );
  }
}
