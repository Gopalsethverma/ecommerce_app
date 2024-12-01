import 'package:ecommerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductDetailsScreen({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double discountedPrice = product['price'] -
        (product['price'] * product['discountPercentage'] / 100);

    return Scaffold(
      appBar: AppBar(
        title: Text(product['title']),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Product Images
                  SizedBox(
                    height: 250,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: product['images'].length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              product['images'][index],
                              alignment: Alignment.center,
                              fit: BoxFit.cover,
                              width: 200,
                              height: 250,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 16),
                  // Title
                  Text(
                    product['title'],
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  // Brand and Category
                  Text(
                    'Brand: ${product['brand']}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  Text(
                    'Category: ${product['category']}',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                  SizedBox(height: 16),
                  // Description
                  Text(
                    product['description'],
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 16),
                  // Price and Discount
                  Row(
                    children: [
                      Text(
                        '₹${product['price']}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(
                        '₹${discountedPrice.toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    '${product['discountPercentage']}% OFF',
                    style: TextStyle(fontSize: 16, color: Colors.pink),
                  ),
                  SizedBox(height: 16),
                  // Rating and Stock
                  Row(
                    children: [
                      Icon(Icons.star, color: Colors.orange),
                      SizedBox(width: 4),
                      Text('${product['rating']}',
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Stock: ${product['stock']} available',
                    style: TextStyle(fontSize: 16, color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
          // Add To Cart Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Add product to the cart
                Provider.of<CartModel>(context, listen: false)
                    .addToCart(product);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      'Updated ${product['title']} in cart',
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 240, 229, 235),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                minimumSize: Size(double.infinity, 50),
              ),
              child: Text(
                'Add To Cart',
                style: TextStyle(fontSize: 18, color: Colors.pink),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
