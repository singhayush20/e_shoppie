import 'package:flutter/material.dart';

import '../structure/constants.dart';
import '../widgets/grid_components.dart';

class ProductDetail extends StatelessWidget {
  final String? productTag;
  final String? productDetail;
  ProductDetail({required this.productTag, required this.productDetail});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '${productTag}:',
          style: ProductDetailTextStyle,
        ),
        Text(
          '${productDetail}',
          style: ProductDetailTextStyle.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class Similar_Products extends StatefulWidget {
  const Similar_Products({Key? key}) : super(key: key);

  @override
  State<Similar_Products> createState() => _Similar_ProductsState();
}

class _Similar_ProductsState extends State<Similar_Products> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //color: Colors.green[100],
      child: SimilarProducts(),
      height: 410,
    );
  }
}
