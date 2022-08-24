import 'package:e_shoppie/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../pages/cart_page.dart';
import 'drawer_tile.dart';

class HomePageDrawer extends StatelessWidget {
  const HomePageDrawer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Ayush Singh'),
              accountEmail: Text('ayushsingh20november@gmail.com'),
              currentAccountPicture: GestureDetector(
                child: CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(
                    Icons.person,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            DrawerTile(
              tileheading: 'Home',
              tileIcon: Icons.home,
            ),
            DrawerTile(
              tileheading: 'Account',
              tileIcon: Icons.person,
            ),
            Divider(),
            DrawerTile(
              tileheading: 'Categories',
              tileIcon: Icons.category,
            ),
            DrawerTile(
              tileheading: 'My Orders',
              tileIcon: Icons.shopping_basket,
              onTap: () {},
            ),
            DrawerTile(
              tileheading: 'Favourites',
              tileIcon: Icons.favorite,
            ),
            DrawerTile(
              tileheading: 'Cart',
              tileIcon: Icons.shopping_cart,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Cart(),
                  ),
                );
              },
            ),
            Divider(),
            DrawerTile(
              tileheading: 'Settings',
              tileIcon: Icons.settings,
            ),
            DrawerTile(
              tileheading: 'About',
              tileIcon: Icons.help,
            ),
            Divider(),
            DrawerTile(
              tileheading: 'Sign Out',
              tileIcon: Icons.logout_rounded,
              onTap: () async {
                print('Entered signout onTap');
                await Provider.of<UserProvider>(context, listen: false)
                    .signOut();
                // Navigator.popUntil(context, (route) => route.isFirst);
                // Navigator.push(context,
                //     MaterialPageRoute(builder: (context) => LoginScreen()));
              },
            )
          ],
        ),
      ),
    );
  }
}
