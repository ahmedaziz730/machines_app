import 'package:flutter/material.dart';
import '../models/FurnDataModel.dart';
import '../providers/orders.dart';
import '../providers/cart.dart';
import 'package:provider/provider.dart';

class FurnDetail extends StatefulWidget {
  final FurnDataModel furnDataModel;
  final Function togFav;
  final Function delFav;

  FurnDetail({
    required this.furnDataModel,
    required this.togFav,
    required this.delFav,
  });

  @override
  State<FurnDetail> createState() => _FurnDetailState();
}

class _FurnDetailState extends State<FurnDetail> {
  bool isPressed = true;

  void _onPress() {
    if (isPressed == true) {
      widget.togFav(widget.furnDataModel.source);
    } else {
      widget.delFav(widget.furnDataModel.source);
    }
    ;
  }

  List get orders {
    // ignore: sdk_version_ui_as_code
    String a = widget.furnDataModel.name;
    String b = widget.furnDataModel.source;
    String c = widget.furnDataModel.desc;
    double d = widget.furnDataModel.price;
    List dde = [];
    dde.addAll([a, b, c, d]);
    // print(dde);
    return dde;
  }

  double totalAmount(int quan_2) {
    var total = 0.0;

    total += widget.furnDataModel.price * quan_2;
    return total;
  }

  String get names {
    String wor = widget.furnDataModel.name;
    return wor;
  }

  double get price {
    double wor = widget.furnDataModel.price;
    return wor;
  }

  @override
  Widget build(BuildContext context) {
    var cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.furnDataModel.name),
      ),
      body: Column(
        children: [
          Hero(
            tag: widget.furnDataModel.name,
            child: Image.asset(widget.furnDataModel.source),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color.fromRGBO(173, 26, 222, 1),
                shape: BoxShape.circle,
              ),
              child: Text(
                '${widget.furnDataModel.price}\$',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.furnDataModel.desc,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 70,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              isPressed
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          minimumSize: const Size(110, 38),
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          elevation: 0.5),
                      onPressed: () {
                        setState(() {
                          _onPress();
                          isPressed = !isPressed;
                        });
                      },
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    )
                  : ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.black,
                          backgroundColor: Colors.white,
                          minimumSize: const Size(110, 38),
                          padding: const EdgeInsets.symmetric(horizontal: 22),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          elevation: 0.5),
                      onPressed: () {
                        setState(() {
                          _onPress();
                          isPressed = !isPressed;
                        });
                      },
                      child: Text(
                        'Remove from Cart',
                        style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                    minimumSize: const Size(110, 38),
                    padding: const EdgeInsets.symmetric(horizontal: 22),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                    ),
                    elevation: 0.5),
                onPressed: () {
                  int quan = 0;
                  Provider.of<Cart>(context, listen: false)
                      .addItem(names, price, quan);
                  Provider.of<Orders>(context, listen: false).addOrder(
                      cart.items.values.toList(), cart.totalAmount, names);
                },
                child: Text(
                  'Buy Now',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
