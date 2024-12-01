// main.dart
import 'package:flutter/material.dart';
import 'screens/catalogue_page.dart'; // Import the catalogue page

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'E-Commerce App',

//       home: CataloguePage(),
//       color:
//           Color.fromARGB(255, 231, 108, 149), // Directly show the CataloguePage
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ecommerce_app/screens/cart.dart'; // Import your CartScreen
import 'models/cart_model.dart'; // Import your CartModel

void main() {
  runApp(
    // Wrapping the whole app with ChangeNotifierProvider
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CataloguePage(),
      routes: {
        '/cart': (context) => CartScreen(),
      },
    );
  }
}
