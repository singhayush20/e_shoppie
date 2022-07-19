import 'package:flutter/material.dart';

class CartProducts extends StatefulWidget {
  const CartProducts({Key? key}) : super(key: key);

  @override
  State<CartProducts> createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
  List<Map> products_inCart = [
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer1.jpeg',
      'price': 5000,
      'size': 'L',
      'color': 'Red',
      'quantity': 4,
    },
    {
      'name': 'Red dress',
      'picture': 'images/products/dress1.jpeg',
      'price': 3200,
      'size': 'L',
      'color': 'Red',
      'quantity': 1,
    },
    {
      'name': 'Black Upper',
      'picture': 'images/products/blazer2.jpeg',
      'price': 3250,
      'size': 'L',
      'color': 'Red',
      'quantity': 1,
    },
    {
      'name': 'Black dress',
      'picture': 'images/products/dress2.jpeg',
      'price': 6200,
      'size': 'L',
      'color': 'Red',
      'quantity': 8,
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: products_inCart.length,
      itemBuilder: (context, index) {
        return Single_CartProducts(
          cart_product_name: products_inCart[index]['name'],
          cart_product_picture: products_inCart[index]['picture'],
          cart_product_color: products_inCart[index]['color'],
          cart_product_price: products_inCart[index]['price'],
          cart_product_quantity: products_inCart[index]['quantity'],
          cart_product_size: products_inCart[index]['size'],
        );
      },
    );
  }
}

class Single_CartProducts extends StatelessWidget {
  String cart_product_name = 'name';
  int cart_product_price = 500;
  String cart_product_picture = 'images/image1.jpg';
  int cart_product_quantity = 1000;
  String cart_product_color = 'Red';
  String cart_product_size = 'L';
  Single_CartProducts(
      {required this.cart_product_name,
      required this.cart_product_price,
      required this.cart_product_color,
      required this.cart_product_picture,
      required this.cart_product_quantity,
      required this.cart_product_size});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Image.asset(
          '$cart_product_picture',
          fit: BoxFit.fill,
          // height: 80,
          // width: 80,
        ),
        title: Container(
          child: Text(
            cart_product_name,
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w800,
              fontSize: 20,
            ),
          ),
        ),
        subtitle: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 4, 4, 4),
                  child: Text(
                    'Size: ',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 4, 4, 4),
                  child: Text(
                    '$cart_product_size',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                  child: Text(
                    'Product Color:',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(0.0, 4, 4, 4),
                  child: Text(
                    '$cart_product_color',
                    style: TextStyle(
                      color: Colors.green,
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                    ),
                  ),
                ),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text(
                '₹$cart_product_price',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_drop_up),
            ),
            Text(
              '$cart_product_quantity',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 15,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.arrow_drop_down),
            ),
          ],
        ),
      ),
    );
  }

  void addQuantity() {
    cart_product_quantity++;
  }

  void reduceQuantity() {
    cart_product_quantity--;
  }
}
