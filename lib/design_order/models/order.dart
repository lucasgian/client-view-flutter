import 'dart:convert';

import 'package:flutter/material.dart';

class Order {
  Order({@required this.id, @required this.description, @required this.category, @required this.price, @required this.imgThumbnail});

  int id;
  String description;
  String category;
  String price;
  String imgThumbnail;

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      description: json['description'],
      category: json['category'],
      price: json['price'],
      imgThumbnail: json['img_thumbnail']
    );
  }
}