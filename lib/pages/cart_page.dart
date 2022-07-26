import 'package:e_shoppie/specific_page_data/cart_products.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  static final String id = "Shopping Cart";

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
          onTap: () {
            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: Text('Cart'),
        ),
      ),
      body: CartProducts(),
      bottomNavigationBar: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Colors.white12,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text('Total:'),
                subtitle: Text('2000Rs.'),
              ),
            ),
            Expanded(
              child: MaterialButton(
                color: Colors.lightGreen,
                onPressed: () {},
                child: Text(
                  'Proceed to Buy',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
