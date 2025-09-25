import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_orders/presentation/widgets/product_card_rect.dart';
import 'package:food_orders/presentation/widgets/product_card_square.dart';

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
              return HomeLoadedPage(state: state);
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
  HomeLoadedPage({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.transparent,
                child: Image.asset("assets/app_logo.png", scale: 0.2),
              ),
            ),
            SizedBox(width: 10),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text(
                      'Best of Foodies',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
                 SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 250,
                child: GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 0.7,crossAxisSpacing: 15,mainAxisSpacing: 15),
                  itemCount: 4,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      SquareProductCard(product: state.allFoodList!.data![index]),
                ),
              ),
          
           Text(
                      'Restaurents and Cafe',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
              SizedBox(
                height: 115,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemExtent:200,
                  itemCount: state.allStoreList!.data!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) =>
                      RectangleProductCard(product: state.allStoreList!.data![index]),
                ),
              ),
          
          
            Text(
                      'Explore More',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        shadows: [
                          Shadow(
                            blurRadius: 10.0,
                            color: Colors.black54,
                            offset: Offset(2.0, 2.0),
                          ),
                        ],
                      ),
                    ),
               GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                 shrinkWrap: true,
                 padding: EdgeInsets.symmetric(horizontal: 30),
                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 15,mainAxisSpacing: 15),
                 itemCount: state.allFoodList!.data!.length,
                 scrollDirection: Axis.vertical,
                 itemBuilder: (context, index) =>
                     SquareProductCard(product: state.allFoodList!.data![index]),
               ),

               SizedBox(height: 50,)
            ],
          ),
        ),
      ),
    );
  }
}
