import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../structure/constants.dart';

class SliderIndicator extends StatelessWidget {
  const SliderIndicator({
    Key? key,
    required this.controller,
    required this.activeIndex,
  }) : super(key: key);

  final CarouselController controller;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      onDotClicked: (index) => controller.jumpToPage(index),
      activeIndex: activeIndex,
      count: carousel_image_list.length,
      effect: JumpingDotEffect(
        dotColor: Colors.lightGreen,
        dotHeight: 10,
        dotWidth: 10,
        activeDotColor: Color(0xFF000000),
      ),
    );
  }
}
