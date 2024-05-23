import 'dart:io';

import 'package:flutter/material.dart';

import '../const.dart';
import 'details_page.dart';
import '../widgets/category_widget.dart';
import '../widgets/app_drawer.dart';
import '../models/FurnDataModel.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/home';
  final File image;

  const HomePage({required this.image});
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey catListKey = GlobalKey();
  int selectedCat = 0;
  static List<FurnDataModel> myCart = [];

  void _toggleFav(String url) {
    final exisIndex = myCart.indexWhere((furn) => furn.source == url);
    if (exisIndex < 0) {
      setState(() {
        myCart.add(furnData.firstWhere((furn) => furn.source == url));
      });
    }
  }

  void _deleteFav(String url) {
    final exisIndex = myCart.indexWhere((furn) => furn.source == url);
    if (exisIndex >= 0) {
      setState(() {
        myCart.removeAt(exisIndex);
      });
    }
  }

  Future<void>? _clearAll(BuildContext cont) {
    if (myCart.isNotEmpty) {
      return showDialog(
        context: cont,
        builder: (ctx) => AlertDialog(
          title: Text('Are you sure?'),
          content: Text(
            'Do you want to remove all items from the cart?',
          ),
          actions: <Widget>[
            TextButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
            TextButton(
              child: Text('Yes'),
              onPressed: () {
                setState(() {
                  myCart.clear();
                });
                Navigator.of(ctx).pop(false);
              },
            ),
          ],
        ),
      );
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Machines App'),
      ),
      drawer: AppDrawer(aa: this.widget.image),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(children: [
            const SizedBox(
              height: 15,
            ),
            // Header(),
            SizedBox(
              height: 178,
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Hero(
                    tag: 'blue_card',
                    child: Material(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(15.0),
                          ),
                          color: Colors.purple,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 10),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 25,
                    right: 0,
                    left: 0,
                    child: Hero(
                      tag: "cat",
                      child: listView(),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "My Cart",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    child: Text(
                      'Clear all',
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: Color.fromARGB(255, 165, 18, 198),
                    ),
                    onPressed: () => _clearAll(context),
                  ),
                ],
              ),
            ),
            // ignore: sdk_version_ui_as_code
            if (myCart.isEmpty)
              Container(
                child: Center(
                  child: Text(
                    'No thing available',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                height: 430,
              )
            else
              Container(
                height: 400,
                child: GridView.builder(
                  padding: const EdgeInsets.all(10.0),
                  itemCount: myCart.length,
                  itemBuilder: (ctx, i) => FurnDataModel(
                    name: myCart[i].name,
                    source: myCart[i].source,
                    desc: myCart[i].desc,
                    price: myCart[i].price,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                ),
              ),
          ]),
        ),
      ),
    );
  }

  Widget listView() {
    return Material(
      color: Colors.transparent,
      child: SizedBox(
        key: catListKey,
        height: 85,
        width: MediaQuery.of(context).size.width,
        child: ListView.builder(
          itemCount: categories.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return InkWell(
              onTap: () {
                final _offset =
                    (catListKey.currentContext!.findRenderObject() as RenderBox)
                        .localToGlobal(Offset.zero);
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation1, animation2) =>
                        DetailsPage(
                      selectedCat: index,
                      catListOffset: _offset,
                      addAsFav: _toggleFav,
                      remFav: _deleteFav,
                    ),
                    transitionDuration: const Duration(milliseconds: 500),
                    transitionsBuilder: (_, a, __, c) =>
                        FadeTransition(opacity: a, child: c),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: CategoryWidget(
                  category: categories[index],
                  isSelected: selectedCat == index,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
