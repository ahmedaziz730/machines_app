import 'dart:io';
import '../screens/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:login/screens/home_page.dart';
import 'package:provider/provider.dart';
import 'header.dart';
import '../providers/auth.dart';
import '../screens/orders_screen.dart';

class AppDrawer extends StatelessWidget {
  final File aa;

  AppDrawer({required File this.aa});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            child: Header(pp: this.aa),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => HomePage(image: ProfilePageState.pickedImage),
                ),
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.payment),
            title: Text('Orders'),
            onTap: () {
              Navigator.of(context)
                  .pushReplacementNamed(OrdersScreen.routeName);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    );
  }
}
