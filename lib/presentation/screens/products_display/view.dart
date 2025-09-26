import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_orders/models/store_list_model.dart';
import 'package:food_orders/presentation/widgets/product_list_widget.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class ProductsDisplayPage extends StatelessWidget {
  const ProductsDisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Store.fromJson(ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>) ;
    return BlocProvider(
      create: (_) => ProductsDisplayBloc()..add(ProductsDisplayInitEvent()),
      child: BlocConsumer<ProductsDisplayBloc, ProductsDisplayState>(
        listener: (context, state) {
          // handle navigation or snackbars
        },
        builder: (context, state) {
          switch (state.status) {
            case ProductsDisplayStatus.initial:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case ProductsDisplayStatus.loaded:
              return ProductsDisplayLoadedPage(state: state,store: store,);
            case ProductsDisplayStatus.error:
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

class ProductsDisplayLoadedPage extends StatelessWidget {
  ProductsDisplayState state;
  Store store;
   ProductsDisplayLoadedPage({super.key,required this.state,required this.store});

  @override
  Widget build(BuildContext context) {
     

      return Scaffold(body: DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title:  Text('${store.name}'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home), text: 'Main Course'),
              Tab(icon: Icon(Icons.favorite), text: 'Snacks'),
              Tab(icon: Icon(Icons.person), text: 'Dessert'),
            ],
          ),
        ),
        body:  TabBarView(
          children: [
           ProductListWidget(products: state.allFoodList!.data!),
           ProductListWidget(products: state.allFoodList!.data!),
           ProductListWidget(products: state.allFoodList!.data!),
          ],
        ),
      ),
    ));
  }
}
