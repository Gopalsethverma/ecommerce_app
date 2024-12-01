import 'package:ecommerce_app/screens/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'product_bloc.dart';
import 'product_event.dart';
import 'product_state.dart';
import 'package:ecommerce_app/screens/cart.dart';

class CataloguePage extends StatefulWidget {
  @override
  _CataloguePageState createState() => _CataloguePageState();
}

class _CataloguePageState extends State<CataloguePage> {
  final ProductBloc _productBloc = ProductBloc();

  @override
  void initState() {
    super.initState();
    _productBloc.add(FetchProducts(1)); // Start by fetching products on page 1
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Catalogue'),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 253, 203, 219),
        actions: [
          // Cart icon in the top-right corner of the app bar
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              // Navigate to the CartScreen when the cart icon is tapped
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CartScreen(), // Navigate to the Cart Screen
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFFFF0F5), // Light pink background color
        ),
        child: BlocBuilder<ProductBloc, ProductState>(
          bloc: _productBloc,
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is ProductLoaded) {
              return GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      2, // Adjust grid layout to show 2 items per row
                  crossAxisSpacing: 2,
                  mainAxisSpacing: 4,
                  childAspectRatio:
                      0.6, // Adjust to ensure image + text fit nicely
                ),
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return ProductCard(product: product);
                },
              );
            } else if (state is ProductError) {
              return Center(child: Text(state.message));
            } else {
              return Container();
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _productBloc.close();
    super.dispose();
  }
}
