import 'package:flutter/material.dart';
import 'package:login/providers/cart.dart';
import 'package:login/screens/profile_page.dart';
import './providers/auth.dart';
import 'screens/login_page.dart';
import 'screens/home_page.dart';
import 'package:provider/provider.dart';
import './screens/orders_screen.dart';
import './providers/orders.dart';
import 'dart:io';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late File? _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => Auth(),
        ),
        ChangeNotifierProvider(
          create: (_) => Cart(),
        ),
        ChangeNotifierProvider.value(
          value: Orders(),
        ),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, _) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: 'Poppins',
          ),
          home: auth.isAuth ? ProfilePage() : LoginPage(),
          routes: {
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            HomePage.routeName: (ctx) => HomePage(
                  image: _pickedImage!,
                ),
            ProfilePage.routeName: (ctx) => ProfilePage(),
          },
        ),
      ),
    );
  }
}
