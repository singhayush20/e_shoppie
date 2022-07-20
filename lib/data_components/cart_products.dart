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
      color: Colors.white70,
      elevation: 20,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(right: 10, left: 5),
            child: Image.asset(
              '$cart_product_picture',
              fit: BoxFit.cover,
              height: 80,
              width: 80,
            ),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //=====PRODUCT NAME=======\\
                Text(
                  "Black dress",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w800,
                    fontSize: 20,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    //=====PRODUCT SIZE=======\\
                    Padding(
                      padding: EdgeInsets.fromLTRB(0.0, 4, 4, 4),
                      child: Text(
                        'Size: ',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black45,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        '$cart_product_size',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.green[800],
                            fontSize: 16),
                      ),
                    ),
                    //=====PRODUCT COLOR=======\\
                    Padding(
                      padding: EdgeInsets.fromLTRB(20.0, 8, 4, 4),
                      child: Text(
                        'Product Color:',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: Colors.black45,
                            fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        '$cart_product_color',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Colors.green[800],
                            fontSize: 16),
                      ),
                    ),
                  ],
                ),
                //====PRODUCT PRICE====
                Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    '$cart_product_price',
                    style: TextStyle(
                        fontWeight: FontWeight.w800,
                        color: Colors.red,
                        fontSize: 18),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_drop_up),
                ),
                Text(
                  '$cart_product_quantity',
                  style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: Colors.red,
                      fontSize: 15),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          )
        ],
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
