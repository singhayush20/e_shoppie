import 'package:flutter/material.dart';

class DrawerTile extends StatelessWidget {
  String? tileheading;
  IconData? tileIcon;
  void Function()? onTap = () {};
  DrawerTile({@required this.tileheading, required this.tileIcon, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: ListTile(
        onTap: onTap,
        title: Text(tileheading ?? 'Not available'),
        leading: Icon(tileIcon ?? Icons.error_outline),
      ),
    );
  }
}
