import 'package:e_shoppie/pages/item_details.dart';
import 'package:flutter/material.dart';

class GridProducts extends StatefulWidget {
  const GridProducts({Key? key}) : super(key: key);

  @override
  State<GridProducts> createState() => _GridProductsState();
}

class _GridProductsState extends State<GridProducts> {
  List<Map> product_list = [
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer1.jpeg',
      'old price': 6000,
      'price': 5000,
    },
    {
      'name': 'Red dress',
      'picture': 'images/products/dress1.jpeg',
      'old price': 4000,
      'price': 3200,
    },
    {
      'name': 'Black Upper',
      'picture': 'images/products/blazer2.jpeg',
      'old price': 4000,
      'price': 3200,
    },
    {
      'name': 'Black dress',
      'picture': 'images/products/dress2.jpeg',
      'old price': 4000,
      'price': 3200,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: product_list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Single_prod(
          product_name: product_list[index]['name'],
          product_image: product_list[index]['picture'],
          oldPrice: product_list[index]['old price'],
          price: product_list[index]['price'],
        );
      },
    );
  }
}

class Single_prod extends StatelessWidget {
  String product_name = '';
  String product_image = '';
  int oldPrice = 0;
  int price = 0;
  Single_prod(
      {required this.product_name,
      required this.product_image,
      required this.oldPrice,
      required this.price});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Hero(
        tag: product_name,
        child: Material(
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return ItemDetails(
                        productPrice: price,
                        productName: product_name,
                        picture: product_image,
                        oldPrice: oldPrice);
                  },
                ),
              );
            },
            child: GridTile(
              footer: Container(
                color: Color(0xCDC8E6C9),
                child: ListTile(
                  leading: Text(
                    product_name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  title: Text(
                    '₹$price',
                    style: TextStyle(
                      color: Colors.deepOrange[900],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  subtitle: Text(
                    '₹$oldPrice',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              child: Image.asset(
                product_image,
                fit: BoxFit.scaleDown,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SimilarProducts extends StatefulWidget {
  const SimilarProducts({Key? key}) : super(key: key);

  @override
  State<SimilarProducts> createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {
  List<Map> product_list = [
    {
      'name': 'Blazer',
      'picture': 'images/products/blazer1.jpeg',
      'old price': 6000,
      'price': 5000,
    },
    {
      'name': 'Red dress',
      'picture': 'images/products/dress1.jpeg',
      'old price': 4000,
      'price': 3200,
    },
    {
      'name': 'Black Upper',
      'picture': 'images/products/blazer2.jpeg',
      'old price': 4000,
      'price': 3200,
    },
    {
      'name': 'Black dress',
      'picture': 'images/products/dress2.jpeg',
      'old price': 4000,
      'price': 3200,
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: product_list.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return Single_prod(
          product_name: product_list[index]['name'],
          product_image: product_list[index]['picture'],
          oldPrice: product_list[index]['old price'],
          price: product_list[index]['price'],
        );
      },
    );
  }
}
