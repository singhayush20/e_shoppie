import 'package:flutter/material.dart';

class CategoryTile extends StatelessWidget {
  String? containerImage;
  String? containerName;
  CategoryTile({required this.containerImage, required this.containerName});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(2.0),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: InkWell(
          onTap: () {},
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                containerImage ?? 'images/image1.jpg',
                width: 100,
                height: 60,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: 5,
                ),
                child: Text(
                  containerName ?? 'Name',
                  style: TextStyle(fontWeight: FontWeight.w700, fontSize: 10),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
