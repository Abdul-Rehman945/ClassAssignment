import 'package:flutter/material.dart';


class Product {
  String name;
  double price;
  int quantity;

  Product({required this.name, required this.price, required this.quantity});
}


class ProductCart extends StatelessWidget {
  ProductCart({super.key});

    final List<Product> cart = [
    Product(name: 'Laptop', price: 999.99, quantity: 1),
    Product(name: 'Smartphone', price: 699.99, quantity: 2),
    Product(name: 'Headphones', price: 150.00, quantity: 1),
  ];

    double getTotalPrice() {
    double total = 0;
    for (var product in cart) {
      total += product.price * product.quantity;
    }
    return total;
  }


  @override
  Widget build(BuildContext context) {
        return Scaffold(
      appBar: AppBar(
        title: Text('Cart'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('Total: \Rs:${getTotalPrice().toStringAsFixed(2)}'),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cart.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.shopping_cart),
              backgroundColor: Colors.blue,
            ),
            title: Text(cart[index].name),
            subtitle: Text('\Rs:${cart[index].price.toStringAsFixed(2)}'),
            trailing: Text('x${cart[index].quantity}'),
          );
        },
      ),
    );
  }
}


