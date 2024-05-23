import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import '../providers/orders.dart' as ord;
import '../providers/cart.dart';

class OrderItem extends StatefulWidget {
  final ord.OrderItem order;
  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  Future<void>? _clearAll(BuildContext cont) {
    return showDialog(
      context: cont,
      builder: (ctx) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text(
          'Do you want to remove all items from the orders?',
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
                Provider.of<Cart>(cont, listen: false).clearAll();
                Provider.of<ord.Orders>(cont, listen: false).clear();
              });
              Navigator.of(ctx).pop(false);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          height: 550,
          child: ListView.builder(
            itemCount: widget.order.products.length,
            itemBuilder: (context, index) => Card(
              elevation: 5,
              margin: EdgeInsets.symmetric(
                vertical: 4,
                horizontal: 1,
              ),
              child: Container(
                padding: EdgeInsets.all(30),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120),
                ),
                child: ListTile(
                  title: Text(
                    widget.order.products[index].name,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    DateFormat('dd/MM/yyyy hh:mm')
                        .format(widget.order.dateTime),
                  ),
                  trailing: FittedBox(
                    fit: BoxFit.fill,
                    child: Row(
                      children: <Widget>[
                        Text(
                          '${widget.order.products[index].quantity}x ',
                          style: TextStyle(fontSize: 24),
                        ),
                        CircleAvatar(
                          radius: 33,
                          child: Padding(
                            padding: EdgeInsets.all(1),
                            child: Text(
                              ' \$${widget.order.products[index].price.toInt()}',
                              style: TextStyle(
                                fontSize: 22,
                                fontFamily: 'Poppins',
                                color: Color.fromARGB(255, 181, 22, 217),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total is : \$${widget.order.amount}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FloatingActionButton(
              onPressed: () {
                _clearAll(context);
              },
              child: Icon(
                Icons.delete,
                color: Colors.black,
              ),
            )
          ],
        ),
      ],
    );
  }
}
