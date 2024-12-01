// import 'package:ecommerce_app/screens/product_details_screen.dart';
// import 'package:flutter/material.dart';

// class ProductCard extends StatelessWidget {
//   final Map<String, dynamic> product;

//   const ProductCard({Key? key, required this.product}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Price after applying discount
//     double discountedPrice = product['price'] -
//         (product['price'] * product['discountPercentage'] / 100);

//     return GestureDetector(
//       onTap: () {
//         // Navigate to the Product Details Screen
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProductDetailsScreen(product: product),
//           ),
//         );
//       },
//       child: Card(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.zero,
//         ),
//         elevation: 2,
//         child: Stack(
//           children: [
//             // Content of the product card
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // Product Image
//                 AspectRatio(
//                   aspectRatio: 1.0,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(12),
//                     child: Image.network(
//                       product['images'][0], // Get the first image from the list
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 // Product Title
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Text(
//                     product['title'],
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ),
//                 // Product Brand
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Text(
//                     'Brand: ${product['brand']}',
//                     style: TextStyle(
//                       color: const Color.fromARGB(255, 104, 103, 103),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 // Product Price with Discount
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Row(
//                     children: [
//                       Text(
//                         '₹${product['price']}',
//                         style: TextStyle(
//                           color: Colors.grey,
//                           decoration: TextDecoration.lineThrough,
//                           fontSize: 12,
//                         ),
//                       ),
//                       SizedBox(width: 8),
//                       Text(
//                         '₹${discountedPrice.toStringAsFixed(2)}',
//                         style: TextStyle(
//                           fontWeight: FontWeight.bold,
//                           color: Colors.black,
//                           fontSize: 13,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 8),
//                 // Discount Percentage
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 8),
//                   child: Text(
//                     '${product['discountPercentage']}% OFF',
//                     style: TextStyle(
//                       fontWeight: FontWeight.bold,
//                       color: const Color.fromARGB(255, 235, 106, 149),
//                       fontSize: 12,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 32), // Leave space for the button
//               ],
//             ),
//             // Add to Cart Button positioned at the bottom-right
//             Positioned(
//               bottom: 8,
//               right: 8,
//               child: ElevatedButton(
//                 onPressed: () {
//                   // Handle Add to Cart logic here
//                   print('Product added to cart: ${product['title']}');
//                 },
//                 style: ElevatedButton.styleFrom(
//                   primary: Colors.blue,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                 ),
//                 child: Text(
//                   'Add',
//                   style: TextStyle(fontSize: 14),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:ecommerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/models/cart_model.dart';
import 'product_details_screen.dart';

class ProductCard extends StatelessWidget {
  final Map<String, dynamic> product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Price after applying discount
    double discountedPrice = product['price'] -
        (product['price'] * product['discountPercentage'] / 100);

    return GestureDetector(
      onTap: () {
        // Navigate to the Product Details Screen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailsScreen(product: product),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
        elevation: 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(children: [
              // Product Image
              AspectRatio(
                aspectRatio: 1.0,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    product['images'][0], // Get the first image from the list
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                bottom: 8,
                right: 8,
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
                  ),
                  child: const Text(
                    'Add',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(226, 233, 30, 98),
                    ),
                  ),
                ),
              ),
            ]),
            SizedBox(height: 8),
            // Product Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                product['title'],
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            // Product Brand
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                'Brand: ${product['brand']}',
                style: TextStyle(
                  color: const Color.fromARGB(255, 104, 103, 103),
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 4),
            // Product Price with Discount
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Text(
                    '₹${product['price']}',
                    style: TextStyle(
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '₹${discountedPrice.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 8),
            // Discount Percentage
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Text(
                '${product['discountPercentage']}% OFF',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: const Color.fromARGB(255, 235, 106, 149),
                  fontSize: 12,
                ),
              ),
            ),
            SizedBox(height: 8), // Leave space for the button
          ],
        ),
      ),
    );
  }
}
