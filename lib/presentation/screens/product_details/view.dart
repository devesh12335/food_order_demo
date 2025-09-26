import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_orders/models/food_list_model.dart';

import 'bloc.dart';
import 'events.dart';
import 'state.dart';

class ProductDetailsPage extends StatelessWidget {
  const ProductDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
     final foodItem = FoodItem.fromJson(ModalRoute.of(context)!.settings.arguments as Map<String,dynamic>);
    return BlocProvider(
      create: (_) => ProductDetailsBloc()..add(ProductDetailsInitEvent()),
      child: BlocConsumer<ProductDetailsBloc, ProductDetailsState>(
        listener: (context, state) {
          // handle navigation or snackbars
        },
        builder: (context, state) {
          switch (state.status) {
            case ProductDetailsStatus.loading:
              return const Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            case ProductDetailsStatus.loaded:
              return ProductDetailsLoadedPage(foodItem: foodItem,state: state,);
            case ProductDetailsStatus.error:
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

class ProductDetailsLoadedPage extends StatelessWidget {
  final ProductDetailsState state;
  final FoodItem foodItem;
   const ProductDetailsLoadedPage({super.key,required this.foodItem,required this.state});

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:  Text(
                      '${foodItem.name}',
                      style: TextStyle(
                        color: Colors.white,
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
       flexibleSpace:   ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: foodItem.image != null && foodItem.image!.isNotEmpty
                  ? Image.network(
                      foodItem.image!,
                      height: 250,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          Container(
                        height: 250,
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.coffee,color: Colors.white, size: 50),
                        ),
                      ),
                    )
                  : Container(
                      height: 250,
                      color: Colors.grey[300],
                      child: const Center(
                        child: Text('No Image Available',
                            style: TextStyle(fontSize: 16)),
                      ),
                    ),
            ),
            bottom: PreferredSize(preferredSize: Size(MediaQuery.of(context).size.width, 150), child: Container(color: Colors.white,)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            const SizedBox(height: 20),

            
            _buildInfoCard(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        foodItem.name ?? 'Unknown Food',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.all(6.0),
                      decoration: BoxDecoration(
                        color: foodItem.veg == true ? Colors.green : Colors.red,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        foodItem.veg == true ? 'VEG' : 'NON-VEG',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                
                Text(
                  foodItem.price != null
                      ? '\$${foodItem.price!.toStringAsFixed(2)}'
                      : 'Price not listed',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

            
            _buildInfoCard(
              title: 'Description',
              children: [
                Text(
                  foodItem.description ?? 'No description provided.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),

           
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildInfoCard(
                    title: 'Category',
                    children: [
                      Text(
                        foodItem.category ?? 'N/A',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.deepOrange,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: _buildInfoCard(
                    title: 'Rating',
                    children: [
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber, size: 24),
                          const SizedBox(width: 5),
                          Text(
                            foodItem.rating?.rate?.toStringAsFixed(1) ?? 'N/A',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '(${foodItem.rating?.count ?? 0} votes)',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
       bottomNavigationBar: _buildAddToCartButton(context),
    );
  }

  Widget _buildAddToCartButton(BuildContext context) {
 
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: () {
            context.read<ProductDetailsBloc>().add(GoToCartEvent(item: foodItem));
          
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('${foodItem.name ?? 'Item'} added to cart!'),
                duration: const Duration(seconds: 1),
              ),
            );
          },
          borderRadius: BorderRadius.circular(15.0),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            decoration: BoxDecoration(
              color: Colors.deepOrange, 
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.shopping_cart, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  'Add to Cart - \u{20B9}${(foodItem.price!).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    
  }

   Widget _buildInfoCard({String? title, required List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0), 
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (title != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ...children,
          ],
        ),
      ),
    );
  }
}


