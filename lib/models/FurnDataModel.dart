import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FurnDataModel extends StatelessWidget {
  FurnDataModel({
    required this.name,
    required this.source,
    required this.desc,
    required this.price,
  });

  final String name, source, desc;
  final double price;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      child: Image.asset(
        source,
        fit: BoxFit.fill,
      ),
    );
  }
}
