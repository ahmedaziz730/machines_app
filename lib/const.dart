// import 'package:flutter/material.dart';
import './models/FurnDataModel.dart';

const categories = [
  {'name': 'Kitchen', 'icon': 'assets/category/kitchen.png'},
  {'name': 'Bathroom', 'icon': 'assets/category/bathroom.png'},
  {'name': 'Sofa', 'icon': 'assets/category/sofa.png'},
  {'name': 'Icebox', 'icon': 'assets/category/icebox.png'},
];
List<FurnDataModel> furnData = [
  FurnDataModel(
    name: 'Load Washer',
    source: 'assets/images/LG Washer.webp',
    desc: 'Load Washer Description ...',
    price: 120,
  ),
  FurnDataModel(
    name: 'Refrigerator 1',
    source: 'assets/images/refri_1.png',
    desc: 'Refrigerator 1 Description ...',
    price: 200,
  ),
  FurnDataModel(
    name: 'Smart Refrigerator',
    source: 'assets/images/grey_refr.png',
    desc: 'Smart Refrigerator Description ...',
    price: 330,
  ),
  FurnDataModel(
    name: 'TV 1',
    source: 'assets/images/TV_image.jpg',
    desc: 'TV 1 Description ...',
    price: 230,
  ),
  FurnDataModel(
    name: 'TV Smart',
    source: 'assets/images/TV_Smart.png',
    desc: 'TV Smart Description ...',
    price: 180,
  ),
];
