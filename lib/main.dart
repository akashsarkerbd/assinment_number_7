import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductList(),
    );
  }
}


class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  List<Product> products = [
    Product(name: "Product 1", price: 10),
    Product(name: "Product 2", price: 20),
    Product(name: "Product 3", price: 10),
    Product(name: "Product 4", price: 40),
    Product(name: "Product 5", price: 60),
    Product(name: "Product 6", price: 20),
    Product(name: "Product 7", price: 40),
    Product(name: "Product 8", price: 20),
    Product(name: "Product 9", price: 11),
    Product(name: "Product 10", price: 23),
    Product(name: "Product 11", price: 10),
    Product(name: "Product 12", price: 20),
  ];

  List<Product> cart = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Product List'),
      ),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductItem(
            product: products[index],
            onBuyPressed: () {
              setState(() {
                products[index].buy();
                if (!cart.contains(products[index])) {
                  cart.add(products[index]);
                }
                if (products[index].count == 5) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Congratulations!"),
                        content: Text("You've bought 5 ${products[index].name}!"),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: Text("OK"),
                          ),
                        ],
                      );
                    },
                  );
                }
              });
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => CartPage(cart: cart),
            ),
          );
        },
        child: Icon(Icons.shopping_cart),
      ),
    );
  }
}

class Product {
  final String name;
  final double price;
  int count;

  Product({required this.name, required this.price, this.count = 0});

  void buy() {
    count++;
  }
}

class ProductItem extends StatelessWidget {
  final Product product;
  final Function() onBuyPressed;

  ProductItem({required this.product, required this.onBuyPressed});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(product.name),
      subtitle: Text('Price: \$${product.price.toStringAsFixed(2)}'),
      trailing: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Count: ${product.count}'),
          Container(
            height:29,
            child:ElevatedButton(

              onPressed: onBuyPressed,
              child: Text('Buy Now',style: TextStyle(fontSize:12,
                  fontWeight:FontWeight.normal
              ),),
            ),),
        ],
      ),
    );
  }
}

class CartPage extends StatelessWidget {
  final List<Product> cart;

  CartPage({required this.cart});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Cart'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total Products: ${cart.length}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}