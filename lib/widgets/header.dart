import 'dart:io';
import 'package:flutter/material.dart';

import '../screens/profile_page.dart';

// ignore: must_be_immutable
class Header extends StatelessWidget {
  final File? pp;

  Header({File? this.pp});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: FileImage(pp!),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          ProfilePageState.ff,
          style: TextStyle(
              fontSize: 18,
              height: 0.8,
              color: Color.fromARGB(255, 254, 253, 253),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
