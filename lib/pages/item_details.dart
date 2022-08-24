import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_shoppie/common_widgets/drop_down_list.dart';
import 'package:e_shoppie/pages/cart_page.dart';
import 'package:e_shoppie/pages/product_details.dart';
import 'package:e_shoppie/specific_page_data/constants.dart';
import 'package:flutter/material.dart';

class ItemDetails extends StatefulWidget {
  static final String id = 'Item Detials Page';
  final String? productName;
  final int? productPrice;
  final int? oldPrice;
  final String? picture;

  ItemDetails({
    this.productName,
    this.productPrice,
    this.oldPrice,
    this.picture,
  });
  @override
  State<ItemDetails> createState() => _ItemDetailsState();
}

class _ItemDetailsState extends State<ItemDetails> {
  final CarouselController controller = CarouselController();
  int activeIndex = 0;
  String? dropdownValue;
  @override
  Widget build(BuildContext context) {
    List<String> carousel_image_list = [widget.picture ?? 'image/image1.jpeg'];
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_sharp),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Cart(),
                ),
              );
            },
            icon: Icon(Icons.shopping_cart),
          ),
          IconButton(
            onPressed: () {
              //Search something
            },
            icon: Icon(
              Icons.search,
            ),
          ),
        ],
        title: InkWell(
            onTap: () {
              Navigator.popUntil(context, (route) => route.isFirst);
            },
            child: Text('EShoppie')),
      ),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          SizedBox(
            height: 300,
            child: GridTile(
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading: Text(
                    widget.productName ?? 'Product Name',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  title: Text(
                    '₹${widget.productPrice}',
                    style: TextStyle(
                      color: Colors.deepOrange[900],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.end,
                  ),
                  subtitle: Text(
                    '₹${widget.oldPrice}',
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.lineThrough,
                    ),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
              child: Container(
                color: Colors.white,
                child: CarouselSlider.builder(
                  itemCount: carousel_image_list.length,
                  itemBuilder: (context, index, realIndex) {
                    final imageAdd = carousel_image_list[index];
                    return buildImage(imageAdd, index);
                  },
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(
                        () {
                          activeIndex = index;
                        },
                      );
                    },
                    initialPage: 0,
                    height: 300,
                    autoPlay: true,
                    enlargeCenterPage: true,
                    enableInfiniteScroll: false,
                    enlargeStrategy: CenterPageEnlargeStrategy.height,
                    viewportFraction: 0.8,
                    pauseAutoPlayOnTouch: true,
                    pauseAutoPlayOnManualNavigate: true,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    autoPlayInterval: Duration(seconds: 3),
                  ),
                ),
              ),
            ),
          ),
          Container(
            // margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropDownButton(
                  dropdownValue: dropdownValue,
                  itemsList: ['L', 'XL', 'XXL', 'XXXL'],
                  hintText: 'Size',
                ),
                DropDownButton(
                  dropdownValue: dropdownValue,
                  itemsList: ['1', '2', '3', '4'],
                  hintText: 'Quantity',
                ),
                DropDownButton(
                  dropdownValue: dropdownValue,
                  itemsList: ['1', '2', '3', '4'],
                  hintText: 'Color',
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.lightGreen,
                      elevation: 10,
                      textStyle: const TextStyle(fontSize: 20),
                    ),
                    onPressed: () {},
                    child: const Text('Buy Now'),
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: Icon(
                    Icons.add_shopping_cart,
                    color: Colors.lightGreen,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: Icon(
                    Icons.favorite_border_outlined,
                    color: Colors.lightGreen,
                  ),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Divider(
            color: Colors.black12,
          ),
          ListTile(
            title: new Text(
              'Product Details:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.black45,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ProductDetail(
                    productTag: 'Product Name',
                    productDetail: widget.productName),
                ProductDetail(
                    productTag: 'Product Brand',
                    productDetail: widget.productName),
                ProductDetail(
                    productTag: 'Product Condition',
                    productDetail: widget.productName),
                ProductDetail(
                    productTag: 'Product Material',
                    productDetail: widget.productName),
              ],
            ),
          ),
          Divider(
            color: Colors.black12,
          ),
          ListTile(
            title: new Text(
              'Product Description:',
              style: TextStyle(
                fontWeight: FontWeight.w800,
                fontSize: 20,
                color: Colors.black45,
              ),
            ),
            subtitle: Text(
              defaultDescp,
              style: ProductDetailTextStyle,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'Similar Products',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            child: Similar_Products(),
          ),
        ],
      ),
    );
  }

  Widget buildImage(String imageAdd, int index) {
    return Container(
      color: Colors.grey,
      child: Image.asset(
        imageAdd,
        fit: BoxFit.cover,
      ),
    );
  }
}
