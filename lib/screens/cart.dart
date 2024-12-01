import 'dart:math';
import 'package:ecommerce_app/models/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);

    return Scaffold(
      appBar: AppBar(
          title: Text('Cart'),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 253, 203, 219)),
      body: Container(
        padding: EdgeInsets.only(bottom: 100),
        decoration: BoxDecoration(
          color: Color(0xFFFFF0F5), // Light pink background color
        ),
        child: cart.cartItems.isEmpty
            ? Center(child: Text('Your cart is empty'))
            : ListView.builder(
                itemCount: cart.cartItems.length,
                itemBuilder: (context, index) {
                  final product = cart.cartItems[index];
                  double price = product['price'] ?? 0.0;
                  double discountPercentage =
                      product['discountPercentage'] ?? 0.0;
                  double discountedPrice =
                      price - (price * discountPercentage / 100);
                  int quantity = product['quantity'] ?? 1;

                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0), // Padding between tiles
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white, // White background for each tile
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade300,
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Stack(
                        children: [
                          ListTile(
                            leading: Image.network(product['images'][0],
                                height: 150, width: 100, fit: BoxFit.cover),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product['title'],
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    'Brand: ${product['brand']}',
                                    style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 104, 103, 103),
                                      fontSize: 12,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Row(
                                    children: [
                                      Text(
                                        '₹${price.toStringAsFixed(2)}',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          decoration:
                                              TextDecoration.lineThrough,
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
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    '${discountPercentage}% OFF',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 235, 106, 149),
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 8,
                            right: 8,
                            child: Container(
                              // margin: const EdgeInsets.symmetric(horizontal: 8),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.remove, size: 12),
                                    onPressed: () {
                                      if (quantity > 1) {
                                        cart.updateQuantity(
                                            product, quantity - 1);
                                      }
                                    },
                                  ),
                                  Text(
                                    '$quantity',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color:
                                            Color.fromARGB(255, 235, 106, 149)),
                                  ),
                                  IconButton(
                                    icon: Icon(Icons.add, size: 12),
                                    onPressed: () {
                                      cart.updateQuantity(
                                          product, quantity + 1);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.all(16.0),
        child: Container(
          height: 60,
          alignment: Alignment.bottomCenter,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                verticalDirection: VerticalDirection.down,
                children: [
                  Text(
                    'Amount Price ',
                    style: TextStyle(fontSize: 12),
                  ),
                  Text(
                    '₹${cart.totalPrice.toStringAsFixed(2)}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  // Implement checkout logic here
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text('Checkout'),
                      content: Text('Proceed to payment?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Order placed successfully!')),
                            );
                          },
                          child: Text('Proceed'),
                        ),
                      ],
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text('Checkout',
                        style: TextStyle(
                            color: Color.fromARGB(255, 240, 229, 235))),
                    SizedBox(width: 10),
                    Container(
                      height: 22, // Increased height
                      width: 22, // Increased width
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(255, 240, 229, 235),
                      ),
                      child: Center(
                        child: Text(
                          '${cart.cartItems.length}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color.fromARGB(226, 233, 30, 98),
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  textStyle: TextStyle(fontSize: 16),
                  backgroundColor: Color.fromARGB(226, 233, 30, 98),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
