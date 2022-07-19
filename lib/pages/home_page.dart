import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_shoppie/widgets/category_tiles.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../structure/constants.dart';
import '../widgets/drawer_widget.dart';
import '../widgets/slider_indicator.dart';
import '../widgets/grid_components.dart';
import 'cart_page.dart';

class HomePage extends StatefulWidget {
  static final String id = 'Home Page';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int activeIndex = 0;

  final CarouselController controller = CarouselController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: AppBarTheme.of(context).backgroundColor,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_sharp),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, Cart.id);
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
        title: Text('EShoppie'),
      ),
      drawer: HomePageDrawer(),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 4),
            child: Column(
              children: [
                CarouselSlider.builder(
                  itemCount: carousel_image_list.length,
                  itemBuilder: (context, index, realIndex) {
                    final imageAdd = carousel_image_list[index];
                    return buildImage(imageAdd, index);
                  },
                  options: CarouselOptions(
                    onPageChanged: (index, reason) {
                      setState(() {
                        activeIndex = index;
                      });
                    },
                    initialPage: 0,
                    height: 150,
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
                SizedBox(
                  height: 10,
                ),
                SliderIndicator(
                    controller: controller, activeIndex: activeIndex),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.all(15),
            child: Text(
              'Categories',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 100,
            alignment: Alignment.center,
            child: ListView.builder(
              itemCount: categoryList.length,
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return CategoryTile(
                    containerImage: categoryList[index].image,
                    containerName: categoryList[index].name);
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: Text(
              'Recent Items',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            //color: Colors.green[100],
            child: GridProducts(),
            height: 410,
          ),
        ],
      ),
    );
  }

  Widget buildImage(String imageAdd, int index) {
    return Image.asset(
      imageAdd,
      fit: BoxFit.cover,
    );
  }
}
